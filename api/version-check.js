export default function handler(req, res) {
  // CORS headers
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    res.status(200).end();
    return;
  }

  const { current_version } = req.query;
  
  // Eng so'nggi versiya ma'lumotlari
  const latestVersion = "1.1.0";
  const downloadUrl = "https://github.com/sardorbekuzb17-cpu/Jaha-quyosh-panel/releases/download/v1.1.0/solar-panel-app.apk";
  
  res.status(200).json({
    latest_version: latestVersion,
    current_version: current_version,
    is_required: current_version < "1.0.5",
    download_url: downloadUrl,
    release_notes: "• Yangi panel turlari qo'shildi\\n• Admin panel yaxshilandi\\n• Xatoliklar tuzatildi\\n• Bog'lanish ma'lumotlari yangilandi"
  });
}