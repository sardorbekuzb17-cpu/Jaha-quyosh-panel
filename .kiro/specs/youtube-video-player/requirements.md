# Talablar Hujjati (Requirements Document)

## Kirish

Ushbu funksiya foydalanuvchilarga quyosh panellari va inverterlar haqida ta'limiy YouTube videolarni to'g'ridan-to'g'ri app ichida tomosha qilish imkonini beradi. Bu foydalanuvchi tajribasini yaxshilaydi va foydalanuvchilar app'dan chiqmasdan kerakli ma'lumotlarni olishlari mumkin.

## Lug'at (Glossary)

- **Video Player**: Ilovada YouTube videolarni ko'rsatish uchun ishlatiladigan komponent
- **App**: Quyosh panellari ma'lumot ilovasi (Solar Panel Info Application)
- **Admin Panel**: Administrator tomonidan videolarni boshqarish uchun interfeys
- **Video List**: Foydalanuvchilarga ko'rsatiladigan videolar ro'yxati
- **YouTube API**: YouTube videolarni yuklash va ko'rsatish uchun interfeys

## Talablar

### Talab 1

**Foydalanuvchi hikoyasi:** Foydalanuvchi sifatida, men quyosh panellari va inverterlar haqida ta'limiy videolarni app ichida tomosha qilishni xohlayman, shunda men app'dan chiqmasdan kerakli ma'lumotlarni olaman.

#### Qabul Mezonlari

1. THE App SHALL YouTube videolarni to'g'ridan-to'g'ri app ichida ko'rsatish imkonini taqdim etadi
2. WHEN foydalanuvchi video ro'yxatidan videoni tanlasa, THEN THE Video Player SHALL tanlangan videoni yuklab, to'liq ekranda yoki oddiy rejimda ko'rsatadi
3. THE Video Player SHALL video ijro etish boshqaruvlarini (play, pause, seek, volume) taqdim etadi
4. THE App SHALL videolarni turli kategoriyalarga (quyosh panellari, inverterlar, o'rnatish, texnik xizmat) ajratib ko'rsatadi
5. THE App SHALL har bir video uchun sarlavha, tavsif va davomiylik ma'lumotlarini ko'rsatadi

### Talab 2

**Foydalanuvchi hikoyasi:** Administrator sifatida, men foydalanuvchilarga ko'rsatiladigan YouTube videolarni boshqarishni (qo'shish, o'chirish, tahrirlash) xohlayman, shunda men app kontentini yangilab turaman.

#### Qabul Mezonlari

1. THE Admin Panel SHALL YouTube video URL'larini qo'shish imkonini taqdim etadi
2. WHEN administrator yangi video URL'ini kiritsa, THEN THE App SHALL video ma'lumotlarini (sarlavha, tavsif, thumbnail) avtomatik ravishda oladi
3. THE Admin Panel SHALL har bir videoga kategoriya va tartib raqamini belgilash imkonini beradi
4. THE Admin Panel SHALL mavjud videolarni o'chirish va tahrirlash funksiyalarini taqdim etadi
5. THE App SHALL admin tomonidan kiritilgan videolarni real vaqtda yoki yangilanishdan keyin foydalanuvchilarga ko'rsatadi

### Talab 3

**Foydalanuvchi hikoyasi:** Foydalanuvchi sifatida, men videolarni tez va sifatli ko'rishni xohlayman, shunda men kutmasdan kerakli ma'lumotlarni olaman.

#### Qabul Mezonlari

1. WHEN foydalanuvchi videoni boshlasa, THEN THE Video Player SHALL 3 soniya ichida videoni yuklash va ijro etishni boshlaydi
2. THE Video Player SHALL turli internet tezliklarida moslashuvchan sifatda (adaptive quality) video ko'rsatadi
3. IF internet aloqasi uzilsa, THEN THE App SHALL foydalanuvchiga xato xabarini ko'rsatadi va qayta urinish tugmasini taqdim etadi
4. THE App SHALL video yuklash jarayonida loading indikatorini ko'rsatadi
5. THE Video Player SHALL foydalanuvchi oxirgi tomosha qilgan joyni eslab qoladi va davom ettirish imkonini beradi

### Talab 4

**Foydalanuvchi hikoyasi:** Foydalanuvchi sifatida, men videolarni qidirish va filtrlash imkoniga ega bo'lishni xohlayman, shunda men kerakli videoni tez topaman.

#### Qabul Mezonlari

1. THE App SHALL videolarni sarlavha bo'yicha qidirish funksiyasini taqdim etadi
2. THE App SHALL videolarni kategoriya bo'yicha filtrlash imkonini beradi
3. WHEN foydalanuvchi qidiruv so'zini kiritsa, THEN THE App SHALL mos keladigan videolarni 1 soniya ichida ko'rsatadi
4. THE App SHALL eng ko'p ko'rilgan yoki eng yangi videolarni birinchi qilib ko'rsatish opsiyasini taqdim etadi
5. THE App SHALL agar qidiruv natijalari bo'sh bo'lsa, foydalanuvchiga tegishli xabar ko'rsatadi
