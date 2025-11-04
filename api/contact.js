export default function handler(req, res) {
  // CORS headers
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    res.status(200).end();
    return;
  }

  // Aloqa ma'lumotlari
  const contact = {
    phone: "+998930874758",
    email: "@jahonbas",
    address: "Navoiy viloyati, Uchquduq tumani !3 A28\\nMarkaziy ko'cha, 15-uy",
    working_hours: "Dushanba - Juma: 9:00 - 18:00\\nShanba: 10:00 - 16:00\\nYakshanba: Dam olish kuni",
    social_media: {
      telegram: "@jahonbas",
      whatsapp: "+998930874758",
      instagram: "@jahongir_solar_panels"
    }
  };

  res.status(200).json(contact);
}