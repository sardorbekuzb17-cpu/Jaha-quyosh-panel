# Quyosh Paneli Ma'lumotlari - Solar Panel Info App

Quyosh panellari haqida to'liq ma'lumot beruvchi professional Flutter ilovasi.

## 🌟 Asosiy funksiyalar

### 👥 Foydalanuvchi uchun:
- **Panel turlari** - Turli xil quyosh paneli turlarini ko'rish
- **Narx paketlari** - Turli narx paketlari va taqqoslash
- **Aloqa ma'lumotlari** - Bog'lanish uchun barcha ma'lumotlar
- **Online/Offline rejim** - Internet bo'lmasa ham ishlaydi
- **Avtomatik yangilanish** - Yangi versiyalar haqida xabar berish

### 🔧 Admin panel:
- **Login tizimi** - Xavfsiz kirish
  - Email: `sardorbekuzb17@gmail.com`
  - Parol: `Sardo9050r`
- **Panel boshqaruvi** - Yangi panellar qo'shish, tahrirlash, o'chirish
- **Narx boshqaruvi** - Paketlarni boshqarish
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
1. **Splash Screen** - Yuklanish ekrani
2. **Home Screen** - Asosiy sahifa
3. **Panels Screen** - Panel turlari
4. **Pricing Screen** - Narx paketlari
5. **Contact Screen** - Aloqa ma'lumotlari

### Admin paneli:
1. **Login Screen** - Kirish ekrani
2. **Dashboard** - Boshqaruv paneli
3. **Panel Management** - Panel boshqaruvi
4. **Pricing Management** - Narx boshqaruvi
5. **Contact Management** - Aloqa boshqaruvi
6. **Statistics** - Statistika va hisobotlar

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
- `GET /api/pricing` - Narx paketlari
- `GET /api/contact` - Aloqa ma'lumotlari
- `GET /api/version-check` - Versiya tekshiruvi
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
- **Email:** sardorbekuzb17@gmail.com
- **Parol:** Sardo9050r

### Admin funksiyalari:
- Panel qo'shish/tahrirlash/o'chirish
- Narx paketlarini boshqarish
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
- **Email:** sardorbekuzb17@gmail.com
- **Telegram:** @jahongir_solar

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
- 🔄 Quyosh paneli kalkulyatori
- 🔄 Xarita integratsiyasi
- 🔄 Til o'zgartirish (Ingliz tili)
- 🔄 Dark mode

---

**Ishlab chiquvchi:** Jahongir  
**Sana:** 2024  
**Versiya:** 1.0.0