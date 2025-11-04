# Server API Misoli

Sizning Flutter ilovangiz uchun server API misoli. Bu API lar orqali ilova ma'lumotlarni oladi va yangilanishlarni tekshiradi.

## API Endpoints

### 1. Panel ma'lumotlari
```
GET /api/panels
```

**Response:**
```json
{
  "panels": [
    {
      "id": "1",
      "name": "Monokristalin Panel 400W",
      "description": "Yuqori samaradorlik va uzoq muddatli ishonchlilik",
      "image_url": "https://example.com/panel1.jpg",
      "power": 400,
      "efficiency": 22.0,
      "warranty": "25 yil",
      "price": 150,
      "features": ["Yuqori samaradorlik", "Kam joy egallaydi", "Uzoq muddatli"]
    }
  ]
}
```

### 2. Narx paketlari
```
GET /api/pricing
```

**Response:**
```json
{
  "pricing": [
    {
      "id": "1",
      "package_name": "Uy uchun Standart",
      "description": "Kichik uylar uchun ideal",
      "price": 15000000,
      "duration": "20 yil kafolat",
      "includes": ["4kW tizim", "O'rnatish", "1 yil texnik xizmat"],
      "is_popular": false
    }
  ]
}
```

### 3. Aloqa ma'lumotlari
```
GET /api/contact
```

**Response:**
```json
{
  "phone": "+998930874758",
  "email": "jahongir@solarpanel.uz",
  "address": "Toshkent shahri, Yunusobod tumani\nChilonzor metro bekati yaqinida",
  "working_hours": "Dushanba - Juma: 9:00 - 18:00\nShanba: 10:00 - 16:00\nYakshanba: Dam olish kuni",
  "social_media": {
    "telegram": "@jahongir_solar",
    "instagram": "@jahongir_solar_panels"
  }
}
```

### 4. Versiya tekshiruvi
```
GET /api/version-check?current_version=1.0.0
```

**Response:**
```json
{
  "latest_version": "1.1.0",
  "is_required": false,
  "download_url": "https://example.com/app-v1.1.0.apk",
  "release_notes": "• Yangi panel turlari qo'shildi\n• Xatoliklar tuzatildi\n• Tezlik yaxshilandi"
}
```

### 5. Statistika yuborish
```
POST /api/stats
```

**Request Body:**
```json
{
  "user_id": "unique_device_id",
  "action": "panel_viewed",
  "timestamp": "2024-01-01T12:00:00Z",
  "data": {
    "panel_id": "1",
    "screen": "panels"
  }
}
```

## Server o'rnatish

### Node.js + Express misoli:

```javascript
const express = require('express');
const app = express();

app.use(express.json());

// CORS ni yoqish
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Headers', 'Content-Type');
  next();
});

// Panel ma'lumotlari
app.get('/api/panels', (req, res) => {
  res.json({
    panels: [
      {
        id: "1",
        name: "Monokristalin Panel 400W",
        description: "Yuqori samaradorlik va uzoq muddatli ishonchlilik",
        image_url: "https://example.com/panel1.jpg",
        power: 400,
        efficiency: 22.0,
        warranty: "25 yil",
        price: 150,
        features: ["Yuqori samaradorlik", "Kam joy egallaydi", "Uzoq muddatli"]
      }
    ]
  });
});

// Narx paketlari
app.get('/api/pricing', (req, res) => {
  res.json({
    pricing: [
      {
        id: "1",
        package_name: "Uy uchun Standart",
        description: "Kichik uylar uchun ideal",
        price: 15000000,
        duration: "20 yil kafolat",
        includes: ["4kW tizim", "O'rnatish", "1 yil texnik xizmat"],
        is_popular: false
      }
    ]
  });
});

// Aloqa ma'lumotlari
app.get('/api/contact', (req, res) => {
  res.json({
    phone: "+998930874758",
    email: "jahongir@solarpanel.uz",
    address: "Toshkent shahri, Yunusobod tumani\nChilonzor metro bekati yaqinida",
    working_hours: "Dushanba - Juma: 9:00 - 18:00\nShanba: 10:00 - 16:00\nYakshanba: Dam olish kuni",
    social_media: {
      telegram: "@jahongir_solar",
      instagram: "@jahongir_solar_panels"
    }
  });
});

// Versiya tekshiruvi
app.get('/api/version-check', (req, res) => {
  const currentVersion = req.query.current_version;
  const latestVersion = "1.1.0";
  
  res.json({
    latest_version: latestVersion,
    is_required: currentVersion < "1.0.5",
    download_url: "https://example.com/app-v1.1.0.apk",
    release_notes: "• Yangi panel turlari qo'shildi\n• Xatoliklar tuzatildi\n• Tezlik yaxshilandi"
  });
});

// Statistika
app.post('/api/stats', (req, res) => {
  console.log('Statistika:', req.body);
  res.json({ success: true });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server ${PORT} portda ishlamoqda`);
});
```

## Ishga tushirish

1. Server kodini `server.js` faylga saqlang
2. `npm init -y` va `npm install express` buyruqlarini bajaring
3. `node server.js` bilan serverni ishga tushiring
4. Flutter ilovasida `baseUrl` ni o'zgartiring: `http://localhost:3000/api`

## Hosting

Server ni quyidagi platformalarda joylashtirish mumkin:
- Heroku
- Vercel
- Railway
- DigitalOcean
- AWS
- Firebase Functions

## Ma'lumotlar bazasi

Katta loyihalar uchun ma'lumotlar bazasi qo'shing:
- PostgreSQL
- MongoDB
- Firebase Firestore
- SQLite