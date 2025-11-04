# Avtomatik Yangilanish Server Sozlash

## 1. Server yaratish (Node.js misoli)

```javascript
const express = require('express');
const app = express();

app.use(express.json());
app.use(express.static('public')); // APK fayllar uchun

// CORS
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Headers', 'Content-Type');
  next();
});

// Versiya tekshiruvi
app.get('/api/version-check', (req, res) => {
  const currentVersion = req.query.current_version;
  
  // Eng so'nggi versiya ma'lumotlari
  const latestVersion = "1.1.0";
  const downloadUrl = "https://yourserver.com/solar_panel_app_v1.1.0.apk";
  
  res.json({
    latest_version: latestVersion,
    current_version: currentVersion,
    is_required: currentVersion < "1.0.5", // Majburiy yangilanish
    download_url: downloadUrl,
    release_notes: "• Yangi panel turlari qo'shildi\n• Admin panel yaxshilandi\n• Xatoliklar tuzatildi"
  });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server ${PORT} portda ishlamoqda`);
});
```

## 2. APK fayllarni joylashtirish

```
public/
  ├── solar_panel_app_v1.0.0.apk
  ├── solar_panel_app_v1.1.0.apk
  └── solar_panel_app_v1.2.0.apk
```

## 3. Flutter kodini yangilash

`lib/services/api_service.dart` da:

```dart
static const String baseUrl = 'https://yourserver.com/api';
```

## 4. Versiyani yangilash

`pubspec.yaml` da:

```yaml
version: 1.1.0+2  # 1.1.0 - versiya, +2 - build raqami
```

## 5. APK yaratish va yuklash

```bash
# APK yaratish
flutter build apk --release

# Server ga yuklash
scp build/app/outputs/flutter-apk/app-release.apk user@server:/path/to/public/solar_panel_app_v1.1.0.apk
```

## 6. Bepul server variantlari

### Heroku (Bepul)
```bash
# Heroku CLI o'rnatish
npm install -g heroku

# Loyiha yaratish
heroku create solar-panel-server

# Deploy qilish
git push heroku main
```

### Vercel (Bepul)
```bash
# Vercel CLI
npm install -g vercel

# Deploy
vercel --prod
```

### Railway (Bepul)
```bash
# Railway CLI
npm install -g @railway/cli

# Deploy
railway deploy
```

## 7. APK fayllarni saqlash

### Google Drive (Bepul)
1. APK ni Google Drive ga yuklang
2. Havolani umumiy qiling
3. Direct download link oling

### GitHub Releases (Bepul)
1. GitHub repository yarating
2. Release yarating
3. APK ni asset sifatida yuklang

## 8. Test qilish

1. Eski versiyani o'rnating
2. Yangi versiyani server ga yuklang
3. Ilovani oching
4. Yangilanish xabarini tekshiring

## 9. Foydalanuvchilarga yuborish

1. APK ni Telegram orqali yuboring
2. O'rnatish ko'rsatmasini bering
3. Avtomatik yangilanish haqida ma'lumot bering

## 10. Xavfsizlik

- HTTPS ishlatish
- APK imzolash
- Versiya tekshiruvi
- Faqat rasmiy manbalardan yuklash