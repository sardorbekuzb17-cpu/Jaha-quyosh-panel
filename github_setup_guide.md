# GitHub bilan Avtomatik Yangilanish O'rnatish

## 1. GitHub Repository yaratish

1. GitHub.com ga kiring
2. "New repository" tugmasini bosing
3. Repository nomi: `solar-panel-app`
4. Public yoki Private tanlang
5. "Create repository" bosing

## 2. Loyihani GitHub ga yuklash

```bash
# Terminal da loyiha papkasida
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/USERNAME/solar-panel-app.git
git push -u origin main
```

## 3. Vercel da API Server o'rnatish

### Vercel.com ga kiring va GitHub bilan bog'lang

### Server kodini yarating:

`api/version-check.js` fayl yarating:

```javascript
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
  const downloadUrl = "https://github.com/USERNAME/solar-panel-app/releases/download/v1.1.0/solar-panel-app.apk";
  
  res.status(200).json({
    latest_version: latestVersion,
    current_version: current_version,
    is_required: current_version < "1.0.5",
    download_url: downloadUrl,
    release_notes: "• Yangi panel turlari qo'shildi\\n• Admin panel yaxshilandi\\n• Xatoliklar tuzatildi"
  });
}
```

### `vercel.json` fayl yarating:

```json
{
  "functions": {
    "api/*.js": {
      "runtime": "@vercel/node"
    }
  },
  "rewrites": [
    {
      "source": "/api/(.*)",
      "destination": "/api/$1"
    }
  ]
}
```

## 4. Flutter kodini yangilash

### `lib/services/api_service.dart` da URL o'zgartiring:

```dart
static const String baseUrl = 'https://your-app-name.vercel.app/api';
```

### `pubspec.yaml` da versiyani yangilang:

```yaml
version: 1.0.0+1  # Hozirgi versiya
```

## 5. APK yaratish va GitHub Releases ga yuklash

### APK yaratish:
```bash
flutter build apk --release
```

### GitHub Releases:
1. GitHub repository ga kiring
2. "Releases" bo'limiga o'ting
3. "Create a new release" bosing
4. Tag: `v1.0.0`
5. Title: `Solar Panel App v1.0.0`
6. APK faylni yuklang
7. "Publish release" bosing

## 6. Yangilanish jarayoni

### Yangi versiya chiqarganda:

1. **Kodni yangilang**
2. **pubspec.yaml da versiyani oshiring:**
   ```yaml
   version: 1.1.0+2
   ```
3. **APK yarating:**
   ```bash
   flutter build apk --release
   ```
4. **GitHub Release yarating:**
   - Tag: `v1.1.0`
   - APK yuklang
5. **Vercel da version-check.js yangilang:**
   ```javascript
   const latestVersion = "1.1.0";
   const downloadUrl = "https://github.com/USERNAME/solar-panel-app/releases/download/v1.1.0/solar-panel-app.apk";
   ```
6. **Git push qiling:**
   ```bash
   git add .
   git commit -m "Update to v1.1.0"
   git push
   ```

## 7. Test qilish

1. Eski versiyani telefonga o'rnating
2. Yangi versiyani GitHub Releases ga yuklang
3. Ilovani oching
4. Yangilanish xabarini tekshiring
5. "Yuklab olish" tugmasini bosing
6. APK yuklab olinishini tekshiring

## 8. Foydalanuvchilarga tarqatish

### Birinchi marta:
- APK ni Telegram orqali yuboring
- O'rnatish ko'rsatmasini bering

### Keyingi yangilanishlar:
- Faqat GitHub ga yangi versiya yuklang
- Foydalanuvchilar avtomatik xabar oladi
- O'zlari yangilab oladi

## 9. Bepul xizmatlar

- **GitHub**: Repository va Releases - BEPUL
- **Vercel**: API hosting - BEPUL (500MB/oy)
- **Bandwidth**: Unlimited downloads - BEPUL

## 10. Xavfsizlik

- Repository ni Private qilish mumkin
- APK ni imzolash (keystore)
- HTTPS avtomatik (Vercel)
- Versiya tekshiruvi himoyasi