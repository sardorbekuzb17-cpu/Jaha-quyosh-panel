// Yangiliklar API endpoint
export default async function handler(req, res) {
  // CORS headers
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  if (req.method === 'GET') {
    try {
      // public/news.json faylidan o'qish
      const fs = require('fs');
      const path = require('path');
      
      const filePath = path.join(process.cwd(), 'public', 'news.json');
      
      if (fs.existsSync(filePath)) {
        const data = fs.readFileSync(filePath, 'utf8');
        const news = JSON.parse(data);
        return res.status(200).json(news);
      } else {
        // Agar fayl bo'lmasa, demo ma'lumotlar
        return res.status(200).json(getDemoNews());
      }
    } catch (error) {
      console.error('Yangiliklar yuklashda xatolik:', error);
      return res.status(200).json(getDemoNews());
    }
  }

  return res.status(405).json({ message: 'Method not allowed' });
}

function getDemoNews() {
  return [
    {
      id: '1',
      title: 'O\'zbekistonda Quyosh Energiyasi Rivojlanmoqda',
      description: 'O\'zbekiston hukumati 2030 yilga qadar 5 GW quyosh energiyasi quvvatini o\'rnatishni rejalashtirmoqda. Bu loyiha mamlakatning energiya xavfsizligini oshiradi.',
      imageUrl: 'https://images.unsplash.com/photo-1509391366360-2e959784a276?w=800',
      date: '2024-11-01',
      category: 'Yangiliklar',
      link: 'https://kun.uz',
    },
    {
      id: '2',
      title: 'Yangi Avlod Quyosh Panellari',
      description: 'Longi kompaniyasi 600W quvvatli yangi avlod quyosh panellarini taqdim etdi. Bu panellar 22% gacha yuqori samaradorlikka ega.',
      imageUrl: 'https://images.unsplash.com/photo-1508514177221-188b1cf16e9d?w=800',
      date: '2024-10-28',
      category: 'Texnologiya',
      link: '',
    },
    {
      id: '3',
      title: 'Quyosh Panellari Narxi Pasaymoqda',
      description: '2024 yilda quyosh panellari narxi 15% ga kamaydi. Bu esa ko\'proq odamlar uchun quyosh energiyasini qulay qiladi.',
      imageUrl: 'https://images.unsplash.com/photo-1497440001374-f26997328c1b?w=800',
      date: '2024-10-25',
      category: 'Narxlar',
      link: '',
    },
    {
      id: '4',
      title: 'Yangi Qonun: Quyosh Energiyasi Uchun Imtiyozlar',
      description: 'O\'zbekiston hukumati quyosh panellari o\'rnatuvchilar uchun yangi imtiyozlar va subsidiyalar dasturini e\'lon qildi.',
      imageUrl: 'https://images.unsplash.com/photo-1473341304170-971dccb5ac1e?w=800',
      date: '2024-10-20',
      category: 'Qonunlar',
      link: 'https://lex.uz',
    },
  ];
}
