module.exports = function handler(req, res) {
  // CORS headers
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    res.status(200).end();
    return;
  }

  // Panel ma'lumotlari
  const panels = [
    {
      id: "1",
      name: "Jinko Solar Monokristalin Panel",
      description: "Klass A, Tier 1 - Monokristalin texnologiya, 715W quvvat, KPD 23%",
      image_url: "https://example.com/jinko_mono.jpg",
      power: 715,
      efficiency: 23.0,
      warranty: "25 yil mahsulot kafolati",
      price: 1162500,
      features: [
        "Jinko Solar brendi",
        "Klass A sifat",
        "Tier 1 ishlab chiqaruvchi",
        "Monokristalin texnologiya",
        "Yuqori KPD 23%",
        "25 yil kafolat",
        "Ob-havo bardoshli"
      ]
    },
    {
      id: "2",
      name: "DEYE Setevoy Invertor",
      description: "50 kVt, 3 fazali setevoy invertor, KPD 98.6%",
      image_url: "https://example.com/deye_inverter.jpg",
      power: 50000,
      efficiency: 98.6,
      warranty: "10 yil kafolat",
      price: 25625000,
      features: [
        "DEYE brendi",
        "3 fazali tizim",
        "Yuqori KPD 98.6%",
        "Setevoy ulanish",
        "MPPT nazorat",
        "Wi-Fi monitoring",
        "IP65 himoya darajasi"
      ]
    }
  ];

  res.status(200).json({
    panels: panels
  });
}