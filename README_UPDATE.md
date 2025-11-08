# 🚀 Yangilanish tizimini sozlash

## 1. GitHub'ga fayllarni yuklash

`update.json` faylini GitHub repository'ingizga yuklang:

```bash
git add update.json
git commit -m "Yangilanish ma'lumotlari qo'shildi"
git push origin main
```

## 2. APK yaratish va GitHub Releases'ga yuklash

```bash
# APK yaratish
flutter build apk --release

# GitHub'da yangi release yarating:
# - Tag: v1.1.0
# - Title: Quyosh24 v1.1.0 - Professional yangilanish tizimi
# - APK faylni yuklang
```

## 3. Test qilish

1. Ilovani ishga tushiring
2. Yangilanish tugmasini bosing
3. Dialog paydo bo'lishini kuting
4. "Yangilash" tugmasini bosing
5. Progress bar ishlashini kuzating

## 4. URL'larni yangilash

`update.json` faylida:
- `downloadUrl` - GitHub Releases'dagi APK havolasi
- `version` - yangi versiya raqami

## 5. Avtomatik yangilanish

Ilova har safar ochilganda avtomatik yangilanish tekshiradi.

## 6. Majburiy yangilanish

`update.json` da `"isForced": true` qilib qo'ysangiz, foydalanuvchi majburan yangilanishi kerak bo'ladi.