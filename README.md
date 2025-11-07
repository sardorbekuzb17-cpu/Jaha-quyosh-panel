# Quyosh Paneli Ma'lumotlari - Solar Panel Info App

Quyosh panellari haqida to'liq ma'lumot beruvchi professional Flutter ilovasi.

## 🌟 Asosiy funksiyalar

### 👥 Foydalanuvchi uchun:
- **Bosh sahifa** - Reklama va asosiy ma'lumotlar
- **Panel turlari** - Turli xil quyosh paneli turlarini ko'rish
- **Inverterlar** - Yuqori sifatli inverterlar haqida ma'lumot
- **Aloqa** - Telefon, Telegram, Instagram orqali bog'lanish
- **Online/Offline rejim** - Internet bo'lmasa ham ishlaydi

### 🔧 Admin panel:
- **Login tizimi** - Xavfsiz kirish
- **Panel boshqaruvi** - Yangi panellar qo'shish, tahrirlash, o'chirish
- **Aloqa tahrirlash** - Kontakt ma'lumotlarini yangilash
- **Statistika** - Foydalanuvchi harakatlari va hisobotlar

## 🚀 Texnologiyalar

- **Flutter** - Cross-platform development
- **Dart** - Dasturlash tili
- **HTTP/Dio** - Server bilan aloqa
- **SharedPreferences** - Mahalliy ma'lumotlar saqlash
- **Connectivity Plus** - Internet holatini kuzatish
- **Package Info Plus** - Ilova versiyasini tekshirish
- **URL Launcher** - Tashqi havolalarni ochish

## 📱 Ekran tasvirlari

### Asosiy ekranlar:
1. **Splash Screen** - Yuklanish ekrani (JAHON GROUP branding)
2. **Bosh sahifa** - Reklama carousel
3. **Panellar** - Quyosh panellari ro'yxati
4. **Inverterlar** - Inverterlar ro'yxati
5. **Aloqa** - Telefon, Telegram, Instagram, Manzil, Xizmatlar

### Admin paneli:
1. **Login Screen** - Kirish ekrani
2. **Dashboard** - Boshqaruv paneli
3. **Panel Management** - Panel boshqaruvi
4. **Contact Management** - Aloqa boshqaruvi
5. **Statistics** - Statistika va hisobotlar

## 🛠 O'rnatish va ishga tushirish

### Talablar:
- Flutter SDK (3.0+)
- Dart SDK (3.0+)
- Android Studio / VS Code
- Chrome browser (web uchun)

### Qadamlar:

1. **Loyihani klonlash:**
```bash
git clone <repository-url>
cd solar_panel_app
```

2. **Dependencies o'rnatish:**
```bash
flutter pub get
```

3. **Ishga tushirish:**

**Web uchun:**
```bash
flutter run -d chrome
```

**Android uchun:**
```bash
flutter run -d android
```

**Windows uchun:**
```bash
flutter run -d windows
```

## 🌐 Server konfiguratsiyasi

### API Endpoints:

Ilova quyidagi API endpointlar bilan ishlaydi:

- `GET /api/panels` - Panel ma'lumotlari
- `GET /api/inverters` - Inverter ma'lumotlari
- `GET /api/contact` - Aloqa ma'lumotlari
- `POST /api/stats` - Statistika yuborish

### Server o'rnatish:

`server_example.md` faylida batafsil ko'rsatma mavjud.

**Qisqa qadamlar:**
1. Node.js o'rnating
2. `server.js` faylini yarating
3. `npm install express` bajaring
4. `node server.js` bilan ishga tushiring
5. `lib/services/api_service.dart` da URL ni o'zgartiring

## 📦 APK yaratish

### Release APK:
```bash
flutter build apk --release
```

### Split APK (kichikroq hajm):
```bash
flutter build apk --split-per-abi
```

APK fayl `build/app/outputs/flutter-apk/` papkasida yaratiladi.

## 🔐 Admin panel

### Kirish ma'lumotlari:
- **Email:** ***************************
- **Parol:** ***************************

### Admin funksiyalari:
- Panel qo'shish/tahrirlash/o'chirish
- Aloqa ma'lumotlarini yangilash
- Foydalanuvchi statistikasini ko'rish
- Tizimdan xavfsiz chiqish

## 📊 Xususiyatlar

### Online/Offline rejim:
- Internet mavjud bo'lsa - server dan ma'lumot oladi
- Internet yo'q bo'lsa - mahalliy ma'lumotlardan foydalanadi
- Avtomatik cache yangilanishi

### Avtomatik yangilanish:
- Ilova ochilganda versiya tekshiruvi
- Yangilanish mavjudligini bildirishnoma
- Majburiy yangilanishlar qo'llab-quvvatlash

### Responsive dizayn:
- Barcha ekran o'lchamlari uchun moslashgan
- Material Design 3 qoidalari
- Zamonaviy UI/UX

## 🐛 Xatoliklarni tuzatish

### Umumiy muammolar:

1. **Internet aloqasi yo'q:**
   - Ilova offline rejimda ishlaydi
   - Mahalliy ma'lumotlar ko'rsatiladi

2. **Server javob bermaydi:**
   - API URL ni tekshiring
   - Server ishlab turganini tasdiqlang

3. **Admin panelga kirish muammosi:**
   - Email va parolni to'g'ri kiriting
   - Katta-kichik harflarni e'tiborga oling

## 📞 Qo'llab-quvvatlash

Savollar yoki muammolar bo'lsa:
- **Telefon:** +998 93 087 47 58
- **Telegram:** https://t.me/quyosh24_sun24
- **Instagram:** https://www.instagram.com/quyosh24_

## 📄 Litsenziya

Bu loyiha shaxsiy foydalanish uchun yaratilgan.

## 🔄 Yangilanishlar

### v1.0.0 (Joriy versiya):
- ✅ Asosiy funksiyalar
- ✅ Admin panel
- ✅ Online/Offline rejim
- ✅ Avtomatik yangilanish
- ✅ Responsive dizayn

### Rejalashtirilgan yangilanishlar:
- 🔄 Push notifications
- 🔄 Xarita integratsiyasi
- 🔄 Til o'zgartirish (Ingliz tili)
- 🔄 Dark mode
- 🔄 Video galereya

---

**Kompaniya:** JAHON GROUP  
**Manzil:** Navoiy viloyati, Uchquduq tumani, 13-A28  
**Sana:** 2025  
**Versiya:** 1.0.0
