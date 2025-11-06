// Buyurtmalar API endpoint
export default async function handler(req, res) {
  // CORS headers
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  if (req.method === 'POST') {
    try {
      const order = req.body;
      
      // Bu yerda buyurtmani database'ga saqlash yoki email yuborish mumkin
      // Hozircha faqat console'ga chiqaramiz
      console.log('Yangi buyurtma:', order);
      
      // Telegram bot orqali xabar yuborish (ixtiyoriy)
      // await sendToTelegram(order);
      
      return res.status(201).json({
        success: true,
        message: 'Buyurtma qabul qilindi',
        orderId: order.id,
      });
    } catch (error) {
      console.error('Buyurtma qabul qilishda xatolik:', error);
      return res.status(500).json({
        success: false,
        message: 'Xatolik yuz berdi',
      });
    }
  }

  if (req.method === 'GET') {
    // Admin uchun buyurtmalar ro'yxatini qaytarish
    // Bu yerda database'dan o'qish kerak
    return res.status(200).json([]);
  }

  return res.status(405).json({ message: 'Method not allowed' });
}

// Telegram bot orqali xabar yuborish funksiyasi (ixtiyoriy)
async function sendToTelegram(order) {
  const TELEGRAM_BOT_TOKEN = process.env.TELEGRAM_BOT_TOKEN;
  const TELEGRAM_CHAT_ID = process.env.TELEGRAM_CHAT_ID;
  
  if (!TELEGRAM_BOT_TOKEN || !TELEGRAM_CHAT_ID) {
    return;
  }

  const message = `
🆕 Yangi Buyurtma!

👤 Mijoz: ${order.customerName}
📞 Telefon: ${order.phoneNumber}
📍 Manzil: ${order.address}

🌞 Panel: ${order.panelType}
📦 Soni: ${order.quantity}
${order.inverterType ? `⚡ Inverter: ${order.inverterType}` : ''}

${order.additionalInfo ? `📝 Qo'shimcha: ${order.additionalInfo}` : ''}

📅 Sana: ${new Date(order.orderDate).toLocaleString('uz-UZ')}
  `;

  try {
    const response = await fetch(
      `https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage`,
      {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          chat_id: TELEGRAM_CHAT_ID,
          text: message,
          parse_mode: 'HTML',
        }),
      }
    );
    
    if (!response.ok) {
      console.error('Telegram xabar yuborishda xatolik');
    }
  } catch (error) {
    console.error('Telegram xatolik:', error);
  }
}
