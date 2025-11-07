exports.handler = async (event, context) => {
  const path = event.path.replace('/.netlify/functions/api', '');
  
  // CORS headers
  const headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
    'Content-Type': 'application/json'
  };

  if (event.httpMethod === 'OPTIONS') {
    return { statusCode: 200, headers, body: '' };
  }

  // Version check
  if (path === '/version') {
    return {
      statusCode: 200,
      headers,
      body: JSON.stringify({
        latest_version: "1.2.0",
        download_url: "https://github.com/sardorbekuzb17-cpu/Jaha-quyosh-panel/releases/download/v1.2.0/Quyosh24.apk",
        force_update: false,
        changelog: "YouTube videolar tashqi ochiladi, Aloqa bo'limi yangilandi",
        min_version: "1.0.0"
      })
    };
  }

  // Panels
  if (path === '/panels') {
    return {
      statusCode: 200,
      headers,
      body: JSON.stringify({
        panels: [
          {
            id: 1,
            name: "Monokristalin Panel 450W",
            power: "450W",
            efficiency: "22.1%",
            price: "1,200,000",
            image: "panel1.jpg",
            description: "Yuqori samaradorlik bilan ishlaydigan monokristalin quyosh paneli"
          }
        ]
      })
    };
  }

  // Contact
  if (path === '/contact') {
    return {
      statusCode: 200,
      headers,
      body: JSON.stringify({
        phone: "+998 93 087 47 58",
        telegram: "https://t.me/quyosh24_sun24",
        instagram: "https://www.instagram.com/quyosh24_",
        address: "Navoiy viloyati, Uchquduq tumani, 13-A28",
        email: "info@quyosh24.uz"
      })
    };
  }

  return {
    statusCode: 404,
    headers,
    body: JSON.stringify({ error: 'Not found' })
  };
};