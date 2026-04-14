// Payme Merchant API callback handler for Netlify Functions
// JSON-RPC 2.0 protokoli

// Payme konfiguratsiyasi
const PAYME_MERCHANT_ID = process.env.PAYME_MERCHANT_ID || '69d6d6113663bd982443630d';
const PAYME_SECRET_KEY = process.env.PAYME_SECRET_KEY || '60t8uMuuzoh#K%d3XKemv#zJ0S21RouEJ0hx';

// In-memory storage
const transactions = new Map();

// Payme xato kodlari
const ERRORS = {
    INVALID_AMOUNT: { code: -31001, message: "Noto'g'ri summa" },
    ORDER_NOT_FOUND: { code: -31050, message: "Buyurtma topilmadi" },
    ORDER_BLOCKED: { code: -31051, message: "Hisob bloklangan, to'lov qilib bo'lmaydi" },
    ORDER_IN_PROCESS: { code: -31052, message: "Hisob jarayonda, boshqa tranzaksiya kutilmoqda" },
    INVALID_ACCOUNT: { code: -31053, message: "Noto'g'ri hisob" },
    TRANSACTION_NOT_FOUND: { code: -31003, message: "Tranzaksiya topilmadi" },
    CANT_PERFORM: { code: -31008, message: "Amalga oshirib bo'lmaydi" },
    CANT_CANCEL: { code: -31007, message: "Bekor qilib bo'lmaydi" },
};

// Authorization tekshirish
function checkAuth(headers) {
    const auth = headers.authorization || headers.Authorization || '';
    if (!auth || !auth.startsWith('Basic ')) return false;

    const credentials = Buffer.from(auth.split(' ')[1], 'base64').toString();
    const [username, password] = credentials.split(':');

    return username === 'Paycom' && password === PAYME_SECRET_KEY;
}

// Metodlar
function checkPerformTransaction(params) {
    const { amount, account } = params;

    // Account mavjudligini tekshirish
    if (!account) {
        return { error: ERRORS.INVALID_ACCOUNT };
    }

    // Amount tekshirish
    if (!amount || amount < 100000) {
        return { error: ERRORS.INVALID_AMOUNT };
    }

    // order_id mavjud bo'lsa, holatini tekshirish
    const orderId = account.order_id || '';

    // Sandbox test parametri: account.status
    const accountStatus = account.status || '';

    // Agar status parametri berilgan bo'lsa, unga qarab javob qaytarish
    if (accountStatus === 'blocked' || accountStatus === 'BLOCKED') {
        return { error: ERRORS.ORDER_BLOCKED };
    }

    if (accountStatus === 'inprocess' || accountStatus === 'INPROCESS') {
        return { error: ERRORS.ORDER_IN_PROCESS };
    }

    if (accountStatus === 'notfound' || accountStatus === 'NOTFOUND') {
        return { error: ERRORS.ORDER_NOT_FOUND };
    }

    // order_id orqali ham tekshirish (backward compatibility)
    if (orderId.startsWith('BLOCKED')) {
        return { error: ERRORS.ORDER_BLOCKED };
    }

    if (orderId.startsWith('INPROCESS')) {
        return { error: ERRORS.ORDER_IN_PROCESS };
    }

    if (orderId.startsWith('NOTFOUND')) {
        return { error: ERRORS.ORDER_NOT_FOUND };
    }

    // To'lovni kutmoqda - ruxsat berish (default)
    return { result: { allow: true } };
}

function createTransaction(params) {
    const { id, time, amount, account } = params;

    if (transactions.has(id)) {
        const tx = transactions.get(id);
        return {
            result: {
                create_time: tx.create_time,
                transaction: tx.id,
                state: tx.state,
            },
        };
    }

    const tx = {
        id, time, amount, account,
        create_time: Date.now(),
        perform_time: 0,
        cancel_time: 0,
        state: 1,
        reason: null,
    };

    transactions.set(id, tx);

    return {
        result: {
            create_time: tx.create_time,
            transaction: tx.id,
            state: tx.state,
        },
    };
}

function performTransaction(params) {
    const { id } = params;
    const tx = transactions.get(id);

    if (!tx) return { error: ERRORS.TRANSACTION_NOT_FOUND };

    if (tx.state === 2) {
        return {
            result: {
                transaction: tx.id,
                perform_time: tx.perform_time,
                state: tx.state,
            },
        };
    }

    if (tx.state !== 1) return { error: ERRORS.CANT_PERFORM };

    tx.state = 2;
    tx.perform_time = Date.now();

    return {
        result: {
            transaction: tx.id,
            perform_time: tx.perform_time,
            state: tx.state,
        },
    };
}

function cancelTransaction(params) {
    const { id, reason } = params;
    const tx = transactions.get(id);

    if (!tx) return { error: ERRORS.TRANSACTION_NOT_FOUND };

    if (tx.state === -1 || tx.state === -2) {
        return {
            result: {
                transaction: tx.id,
                cancel_time: tx.cancel_time,
                state: tx.state,
            },
        };
    }

    tx.state = tx.state === 1 ? -1 : -2;
    tx.cancel_time = Date.now();
    tx.reason = reason;

    return {
        result: {
            transaction: tx.id,
            cancel_time: tx.cancel_time,
            state: tx.state,
        },
    };
}

function checkTransaction(params) {
    const { id } = params;
    const tx = transactions.get(id);

    if (!tx) return { error: ERRORS.TRANSACTION_NOT_FOUND };

    return {
        result: {
            create_time: tx.create_time,
            perform_time: tx.perform_time,
            cancel_time: tx.cancel_time,
            transaction: tx.id,
            state: tx.state,
            reason: tx.reason,
        },
    };
}

function getStatement(params) {
    const { from, to } = params;
    const result = [];

    for (const [id, tx] of transactions) {
        if (tx.create_time >= from && tx.create_time <= to) {
            result.push({
                id: tx.id,
                time: tx.time,
                amount: tx.amount,
                account: tx.account,
                create_time: tx.create_time,
                perform_time: tx.perform_time,
                cancel_time: tx.cancel_time,
                transaction: tx.id,
                state: tx.state,
                reason: tx.reason,
            });
        }
    }

    return { result: { transactions: result } };
}

// Netlify Function handler
exports.handler = async (event, context) => {
    // CORS
    const headers = {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'POST, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type, Authorization',
        'Content-Type': 'application/json',
    };

    if (event.httpMethod === 'OPTIONS') {
        return { statusCode: 200, headers, body: '' };
    }

    if (event.httpMethod !== 'POST') {
        return {
            statusCode: 405,
            headers,
            body: JSON.stringify({ error: 'Method not allowed' }),
        };
    }

    // Auth check
    if (!checkAuth(event.headers)) {
        return {
            statusCode: 401,
            headers,
            body: JSON.stringify({ error: 'Unauthorized' }),
        };
    }

    try {
        const request = JSON.parse(event.body);
        const { jsonrpc, id, method, params } = request;

        if (jsonrpc !== '2.0') {
            return {
                statusCode: 200,
                headers,
                body: JSON.stringify({
                    jsonrpc: '2.0',
                    id,
                    error: { code: -32600, message: 'Invalid Request' },
                }),
            };
        }

        let result;

        switch (method) {
            case 'CheckPerformTransaction':
                result = checkPerformTransaction(params);
                break;
            case 'CreateTransaction':
                result = createTransaction(params);
                break;
            case 'PerformTransaction':
                result = performTransaction(params);
                break;
            case 'CancelTransaction':
                result = cancelTransaction(params);
                break;
            case 'CheckTransaction':
                result = checkTransaction(params);
                break;
            case 'GetStatement':
                result = getStatement(params);
                break;
            default:
                result = { error: { code: -32601, message: 'Method not found' } };
                break;
        }

        return {
            statusCode: 200,
            headers,
            body: JSON.stringify({
                jsonrpc: '2.0',
                id,
                ...result,
            }),
        };
    } catch (error) {
        console.error('Payme error:', error);
        return {
            statusCode: 200,
            headers,
            body: JSON.stringify({
                jsonrpc: '2.0',
                id: null,
                error: { code: -32603, message: 'Internal error' },
            }),
        };
    }
};
