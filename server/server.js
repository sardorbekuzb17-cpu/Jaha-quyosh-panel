const express = require('express');
const cors = require('cors');
const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// Panels API
app.get('/api/panels', (req, res) => {
  const panels = [
    {
      "id": 1,
      "name": "Monokristalin Panel 450W",
      "power": "450W",
      "efficiency": "22.1%",
      "price": "1,200,000",
      "image": "panel1.jpg",
      "description": "Yuqori samaradorlik bilan ishlaydigan monokristalin quyosh paneli"
    },
    {
      "id": 2,
      "name": "Polikristalin Panel 400W", 
      "power": "400W",
      "efficiency": "20.5%",
      "price": "950,000",
      "image": "panel2.jpg",
      "description": "Arzon narxda yuqori sifatli polikristalin panel"
    }
  ];
  res.json({ panels });
});

// Contact API
app.get('/api/contact', (req, res) => {
  const contact = {
    "phone": "+998 93 087 47 58",
    "telegram": "https://t.me/quyosh24_sun24",
    "instagram": "https://www.instagram.com/quyosh24_",
    "address": "Navoiy viloyati, Uchquduq tumani, 13-A28",
    "email": "info@quyosh24.uz"
  };
  res.json(contact);
});

// Version check API
app.get('/api/version', (req, res) => {
  const version = {
    "latest_version": "1.2.0",
    "download_url": "https://github.com/sardorbekuzb17-cpu/Jaha-quyosh-panel/releases/download/v1.2.0/Quyosh24.apk",
    "force_update": false,
    "changelog": "YouTube videolar tashqi ochiladi, Aloqa bo'limi yangilandi",
    "min_version": "1.0.0"
  };
  res.json(version);
});

// Stats API
app.post('/api/stats', (req, res) => {
  console.log('Stats received:', req.body);
  res.json({ success: true });
});

module.exports = app;