export default function handler(req, res) {
  // CORS headers
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  try {
    const { current_version } = req.query;
    
    // Eng so'nggi versiya ma'lumotlari
    const response = {
      latest_version: "1.1.0",
      current_version: current_version || "1.0.0",
      is_required: (current_version && current_version < "1.0.5") || false,
      download_url: "https://github.com/sardorbekuzb17-cpu/Jaha-quyosh-panel/releases/download/v1.1.0/solar-panel-app.apk",
      release_notes: "• Yangi panel turlari qo'shildi\n• Admin panel yaxshilandi\n• Xatoliklar tuzatildi\n• Bog'lanish ma'lumotlari yangilandi"
    };

    return res.status(200).json(response);
  } catch (error) {
    return res.status(500).json({ error: 'Server xatoligi' });
  }
}