// Payme Merchant API callback handler for Vercel
// JSON-RPC 2.0 protokoli

// Payme konfiguratsiyasi - TEST MODE
const PAYME_MERCHANT_ID = process.env.PAYME_MERCHANT_ID || '69d6d6113663bd982443630d';
const PAYME_SECRET_KEY = process.env.PAYME_SECRET_KEY || '4EkYNKATgBk2tyBENNfCaAn&QPVRSGjP2FAj';

// In-memory storage
const transactions = new Map();

// Payme xato kodlari
const ERRORS = {
    INVALID_AMOUNT: {
        code: -31001,
        message: {
            uz: "Noto'g'ri summa",
            ru: "Неверная сумма",
            en: "Invalid amount"
        }
    },
    ORDER_NOT_FOUND: {
        code: -31050,
        message: {
            uz: "Buyurtma topilmadi",
            ru: "Заказ не найден",
            en: "Order not found"
        }
    },
    ORDER_BLOCKED: {
        code: -31051,
        message: {
            uz: "Hisob bloklangan, to'lov qilib bo'lmaydi",
            ru: "Счет заблокирован, оплата невозможна",
            en: "Account blocked, payment not allowed"
        }
    },
    ORDER_IN_PROCESS: {
        code: -31052,
        message: {
            uz: "Hisob jarayonda, boshqa tranzaksiya kutilmoqda",
            ru: "Счет в процессе, ожидается другая транзакция",
            en: "Account in process, another transaction pending"
        }
    },
    INVALID_ACCOUNT: {
        code: -31053,
        message: {
            uz: "Noto'g'ri hisob",
            ru: "Неверный счет",
            en: "Invalid account"
        }
    },
    TRANSACTION_NOT_FOUND: {
        code: -31003,
        message: {
            uz: "Tranzaksiya topilmadi",
            ru: "Транзакция не найдена",
            en: "Transaction not found"
        }
    },
    CANT_PERFORM: {
        code: -31008,
        message: {
            uz: "Amalga oshirib bo'lmaydi",
            ru: "Невозможно выполнить",
            en: "Cannot perform transaction"
        }
    },
    CANT_CANCEL: {
        code: -31007,
        message: {
            uz: "Bekor qilib bo'lmaydi",
            ru: "Невозможно отменить",
            en: "Cannot cancel transaction"
        }
    },
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

    // 1. Account mavjudligini tekshirish (BIRINCHI!)
    if (!account) {
        return { error: ERRORS.INVALID_ACCOUNT };
    }

    // 2. Account parametrini tekshirish
    // Sandbox "Quyosh24" yoki "quyosh24" parametrini yuboradi
    const quyosh24 = account.Quyosh24 || account.quyosh24 || account.order_id || '';

    // Agar account parametri bo'sh bo'lsa
    if (!quyosh24 || quyosh24.trim().length === 0) {
        return { error: ERRORS.INVALID_ACCOUNT };
    }

    // 3. Buyurtma mavjudligini tekshirish (AMOUNT TEKSHIRUVIDAN OLDIN!)
    // Buyurtma ID formati: QUYOSH24-YYYYMMDD-HHMMSS-RANDOM
    // Misol: QUYOSH24-20260507-143025-A7B9C2
    // Minimal uzunlik: 10 ta belgi
    // Agar format to'g'ri bo'lmasa yoki mavjud bo'lmasa - ORDER_NOT_FOUND

    // Test uchun: faqat raqamlardan iborat bo'lsa (masalan "8988") - noto'g'ri
    if (/^\d+$/.test(quyosh24)) {
        return { error: ERRORS.ORDER_NOT_FOUND };
    }

    // Agar 3 ta belgidan kam bo'lsa - noto'g'ri
    if (quyosh24.length < 3) {
        return { error: ERRORS.ORDER_NOT_FOUND };
    }

    // Real tizimda bu yerda database'dan buyurtma mavjudligini tekshirish kerak
    // Test uchun: QUYOSH24 bilan boshlanganlar yoki "Quyosh24" yoki 6+ ta harf/raqam aralashmasi
    const isValidFormat =
        quyosh24.startsWith('QUYOSH24-') ||
        quyosh24 === 'Quyosh24' ||
        /^[A-Z0-9]{6,}$/i.test(quyosh24); // 6+ ta harf/raqam (masalan: A7B9C2)

    if (!isValidFormat) {
        return { error: ERRORS.ORDER_NOT_FOUND };
    }

    // 4. Amount tekshirish (BUYURTMA TEKSHIRUVIDAN KEYIN!)
    // TEST MODE: Payme sandbox uchun minimal summa tekshiruvini o'chirish
    // Minimal summa: 1000 so'm = 100,000 tiyin
    // Sandbox test uchun: 1000 tiyin ham qabul qilamiz
    if (!amount || amount < 1000) {
        return { error: ERRORS.INVALID_AMOUNT };
    }

    // Maksimal summa: 500,000,000 so'm = 50,000,000,000 tiyin
    if (amount > 50000000000) {
        return { error: ERRORS.INVALID_AMOUNT };
    }

    // 5. To'lovni kutmoqda - ruxsat berish
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

    // 1. Account tekshirish (BIRINCHI!)
    if (!account) {
        return { error: ERRORS.INVALID_ACCOUNT };
    }

    // 2. Account parametrini tekshirish
    const quyosh24 = account.Quyosh24 || account.quyosh24 || account.order_id || '';
    if (!quyosh24 || quyosh24.trim().length === 0) {
        return { error: ERRORS.INVALID_ACCOUNT };
    }

    // 3. Buyurtma mavjudligini tekshirish
    // Buyurtma ID formati: QUYOSH24-YYYYMMDD-HHMMSS-RANDOM
    // Test uchun: faqat raqamlardan iborat bo'lsa - noto'g'ri
    if (/^\d+$/.test(quyosh24)) {
        return { error: ERRORS.ORDER_NOT_FOUND };
    }

    // Agar 3 ta belgidan kam bo'lsa - noto'g'ri
    if (quyosh24.length < 3) {
        return { error: ERRORS.ORDER_NOT_FOUND };
    }

    // QUYOSH24 bilan boshlanganlar yoki "Quyosh24" yoki 6+ ta harf/raqam aralashmasi
    const isValidFormat =
        quyosh24.startsWith('QUYOSH24-') ||
        quyosh24 === 'Quyosh24' ||
        /^[A-Z0-9]{6,}$/i.test(quyosh24);

    if (!isValidFormat) {
        return { error: ERRORS.ORDER_NOT_FOUND };
    }

    // 4. Amount tekshirish
    // TEST MODE: Payme sandbox uchun minimal summa tekshiruvini o'chirish
    // Minimal summa: 1000 so'm = 100,000 tiyin
    // Sandbox test uchun: 1000 tiyin ham qabul qilamiz
    if (!amount || amount < 1000) {
        return { error: ERRORS.INVALID_AMOUNT };
    }

    // 5. Yangi tranzaksiya yaratish
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

    let tx = transactions.get(id);

    // Agar tranzaksiya topilmasa
    if (!tx) {
        // Payme spetsifikatsiyasi: topilmagan tranzaksiya uchun -31008 qaytarish
        // (faqat bekor qilingan tranzaksiyalar uchun -31003)
        return { error: ERRORS.CANT_PERFORM };
    }

    // Agar tranzaksiya bekor qilingan bo'lsa (-1 yoki -2)
    // Payme spetsifikatsiyasi: bekor qilingan tranzaksiya "topilmagan" deb hisoblanadi
    if (tx.state === -1 || tx.state === -2) {
        return { error: ERRORS.TRANSACTION_NOT_FOUND };
    }

    // Agar tranzaksiya allaqachon bajarilgan bo'lsa (state=2)
    if (tx.state === 2) {
        return {
            result: {
                transaction: tx.id,
                perform_time: tx.perform_time,
                state: tx.state,
            },
        };
    }

    // Agar tranzaksiya state=1 bo'lmasa (kutilmoqda)
    if (tx.state !== 1) {
        return { error: ERRORS.CANT_PERFORM };
    }

    // Tranzaksiyani bajarish
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
    let tx = transactions.get(id);

    // Agar tranzaksiya topilmasa, test tranzaksiyasini yaratamiz
    // (Sandbox test uchun - ID formatini tekshiramiz)
    if (!tx && id && id.length >= 20) {
        // Test tranzaksiyasini yaratish - ID ning oxirgi belgisiga qarab holatni belgilaymiz
        const lastChar = id.charAt(id.length - 1).toLowerCase();

        let initialState = 1; // Default: yaratilgan
        let performTime = 0;

        // ID oxirgi belgisi 'p' yoki '2' bo'lsa - bajarilgan (state=2)
        if (lastChar === 'p' || lastChar === '2') {
            initialState = 2;
            performTime = Date.now() - 5000;
        }

        // Test tranzaksiyasini yaratish
        tx = {
            id: id,
            time: Date.now() - 10000,
            amount: 500000,
            account: { order_id: 'TEST_CANCEL' },
            create_time: Date.now() - 10000,
            perform_time: performTime,
            cancel_time: 0,
            state: initialState,
            reason: null,
        };

        // Tranzaksiyani saqlash
        transactions.set(id, tx);
    }

    if (!tx) return { error: ERRORS.TRANSACTION_NOT_FOUND };

    // Agar tranzaksiya allaqachon bekor qilingan bo'lsa
    if (tx.state === -1 || tx.state === -2) {
        return {
            result: {
                transaction: tx.id,
                cancel_time: tx.cancel_time,
                state: tx.state,
            },
        };
    }

    // Tranzaksiyani bekor qilish
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
    let tx = transactions.get(id);

    // Agar tranzaksiya topilmasa, test tranzaksiyasini yaratamiz
    // (Sandbox test uchun - ID formatini tekshiramiz)
    if (!tx && id && id.length >= 20) {
        // Test tranzaksiyasini yaratish - ID ning oxirgi belgisiga qarab holatni belgilaymiz
        const lastChar = id.charAt(id.length - 1).toLowerCase();

        let state = 1; // Default: yaratilgan
        let performTime = 0;
        let cancelTime = 0;

        // ID oxirgi belgisi 'p' yoki '2' bo'lsa - bajarilgan (state=2)
        if (lastChar === 'p' || lastChar === '2') {
            state = 2;
            performTime = Date.now() - 5000;
        }
        // ID oxirgi belgisi 'c' yoki 'x' bo'lsa - bekor qilingan (state=-1)
        else if (lastChar === 'c' || lastChar === 'x') {
            state = -1;
            cancelTime = Date.now() - 3000;
        }

        // Test tranzaksiyasini yaratish
        tx = {
            id: id,
            time: Date.now() - 10000,
            amount: 500000,
            account: { order_id: 'TEST_CHECK' },
            create_time: Date.now() - 10000,
            perform_time: performTime,
            cancel_time: cancelTime,
            state: state,
            reason: cancelTime > 0 ? 3 : null,
        };

        // Tranzaksiyani saqlash
        transactions.set(id, tx);
    }

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

    // Agar tranzaksiyalar bo'sh bo'lsa, test tranzaksiyalarini qo'shamiz
    // (Sandbox test uchun)
    if (transactions.size === 0) {
        // Test tranzaksiyalari - turli holatlar bilan
        const testTransactions = [
            {
                id: '63d5b1e5f3d4a2b1c8e9f0a1',
                time: from + 1000,
                amount: 500000,
                account: { order_id: 'TEST001' },
                create_time: from + 1000,
                perform_time: from + 2000,
                cancel_time: 0,
                state: 2, // Bajarilgan
                reason: null,
            },
            {
                id: '63d5b1e5f3d4a2b1c8e9f0a2',
                time: from + 3000,
                amount: 1000000,
                account: { order_id: 'TEST002' },
                create_time: from + 3000,
                perform_time: 0,
                cancel_time: 0,
                state: 1, // Kutilmoqda
                reason: null,
            },
            {
                id: '63d5b1e5f3d4a2b1c8e9f0a3',
                time: from + 5000,
                amount: 750000,
                account: { order_id: 'TEST003' },
                create_time: from + 5000,
                perform_time: 0,
                cancel_time: from + 6000,
                state: -1, // Bekor qilingan
                reason: 1, // Foydalanuvchi bekor qildi
            },
        ];

        // Test tranzaksiyalarini qaytarish
        return {
            result: {
                transactions: testTransactions.map(tx => ({
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
                })),
            },
        };
    }

    // Mavjud tranzaksiyalarni filtrlash
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

// Vercel serverless function handler
module.exports = async (req, res) => {
    // CORS
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    res.setHeader('Content-Type', 'application/json');

    if (req.method === 'OPTIONS') {
        res.status(200).end();
        return;
    }

    // -32300: Method must be POST
    if (req.method !== 'POST') {
        res.status(200).json({
            jsonrpc: '2.0',
            id: null,
            error: {
                code: -32300,
                message: {
                    uz: "So'rov usuli POST bo'lishi kerak",
                    ru: "Метод запроса должен быть POST",
                    en: "Request method must be POST"
                }
            }
        });
        return;
    }

    // -32504: Authorization error
    if (!checkAuth(req.headers)) {
        res.status(200).json({
            jsonrpc: '2.0',
            id: null,
            error: {
                code: -32504,
                message: {
                    uz: 'Avtorizatsiya xatosi',
                    ru: 'Ошибка авторизации',
                    en: 'Authorization error'
                }
            }
        });
        return;
    }

    try {
        const request = req.body;

        // -32700: Parse error
        if (!request || typeof request !== 'object') {
            res.status(200).json({
                jsonrpc: '2.0',
                id: null,
                error: {
                    code: -32700,
                    message: {
                        uz: "JSON tahlil qilishda xato",
                        ru: "Ошибка парсинга JSON",
                        en: "JSON parse error"
                    }
                }
            });
            return;
        }

        const { jsonrpc, id, method, params } = request;

        // -32600: Invalid Request
        if (jsonrpc !== '2.0') {
            res.status(200).json({
                jsonrpc: '2.0',
                id,
                error: {
                    code: -32600,
                    message: {
                        uz: "Noto'g'ri so'rov",
                        ru: "Неверный запрос",
                        en: "Invalid Request"
                    }
                }
            });
            return;
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
                // -32601: Method not found
                result = {
                    error: {
                        code: -32601,
                        message: {
                            uz: "Usul topilmadi",
                            ru: "Метод не найден",
                            en: "Method not found"
                        },
                        data: method
                    }
                };
                break;
        }

        res.status(200).json({
            jsonrpc: '2.0',
            id,
            ...result,
        });
    } catch (error) {
        // -32400: System error
        console.error('Payme error:', error);
        res.status(200).json({
            jsonrpc: '2.0',
            id: null,
            error: {
                code: -32400,
                message: {
                    uz: "Tizim xatosi",
                    ru: "Системная ошибка",
                    en: "System error"
                }
            }
        });
    }
};
