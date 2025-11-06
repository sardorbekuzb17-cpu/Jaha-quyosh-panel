# MyGov.uz Integration Requirements

## Introduction

Quyosh24 ilovasiga MyGov.uz integratsiyasi orqali foydalanuvchilar autentifikatsiya va sotib olish funksiyalarini qo'shish. Foydalanuvchilar MyGov.uz FaceID orqali tizimga kirib, quyosh panellarini xavfsiz sotib olishlari mumkin.

## Glossary

- **MyGov System**: O'zbekiston Respublikasining yagona elektron hukumat portali
- **FaceID Authentication**: MyGov.uz orqali yuz tanish texnologiyasi bilan autentifikatsiya
- **User**: Ilovadan foydalanuvchi shaxs
- **Panel**: Quyosh paneli tizimi
- **Order**: Sotib olish buyurtmasi
- **Payment**: To'lov jarayoni

## Requirements

### Requirement 1: MyGov.uz Autentifikatsiya

**User Story:** Foydalanuvchi sifatida, men MyGov.uz orqali FaceID yordamida tizimga kirishni xohlayman, shunda shaxsiy ma'lumotlarim xavfsiz bo'ladi.

#### Acceptance Criteria

1. WHEN foydalanuvchi "MyGov orqali kirish" tugmasini bosadi, THEN Sistema MyGov.uz autentifikatsiya sahifasiga yo'naltiradi
2. WHEN foydalanuvchi MyGov.uz'da FaceID orqali autentifikatsiya qiladi, THEN Sistema foydalanuvchi ma'lumotlarini oladi va saqlaydi
3. WHEN autentifikatsiya muvaffaqiyatli bo'ladi, THEN Sistema foydalanuvchini asosiy sahifaga qaytaradi
4. IF autentifikatsiya muvaffaqiyatsiz bo'lsa, THEN Sistema xatolik xabarini ko'rsatadi
5. WHILE foydalanuvchi tizimda bo'lsa, THEN Sistema session'ni saqlaydi

### Requirement 2: Foydalanuvchi Profili

**User Story:** Foydalanuvchi sifatida, men o'z profilimni ko'rishni va tahrirlashni xohlayman, shunda shaxsiy ma'lumotlarimni boshqara olaman.

#### Acceptance Criteria

1. WHEN foydalanuvchi tizimga kiradi, THEN Sistema MyGov.uz'dan olingan ma'lumotlarni ko'rsatadi
2. THE Sistema SHALL foydalanuvchi FIO, JSHSHIR, telefon raqami va manzilini ko'rsatadi
3. WHEN foydalanuvchi profil ma'lumotlarini o'zgartiradi, THEN Sistema o'zgarishlarni saqlaydi
4. THE Sistema SHALL foydalanuvchi buyurtmalar tarixini ko'rsatadi

### Requirement 3: Panel Sotib Olish

**User Story:** Foydalanuvchi sifatida, men tizimga kirgan holda panel sotib olishni xohlayman, shunda xavfsiz va tez to'lov qila olaman.

#### Acceptance Criteria

1. WHEN foydalanuvchi panelni tanlaydi, THEN Sistema panel ma'lumotlari va narxini ko'rsatadi
2. WHEN foydalanuvchi "Sotib olish" tugmasini bosadi, THEN Sistema buyurtma formini ochadi
3. THE Sistema SHALL foydalanuvchi ma'lumotlarini avtomatik to'ldiradi
4. WHEN foydalanuvchi buyurtmani tasdiqlaydi, THEN Sistema to'lov sahifasiga o'tadi
5. THE Sistema SHALL Click, Payme, Uzum va MyGov to'lov usullarini qo'llab-quvvatlaydi

### Requirement 4: To'lov Jarayoni

**User Story:** Foydalanuvchi sifatida, men turli to'lov usullari orqali to'lovni amalga oshirishni xohlayman, shunda qulay usulni tanlay olaman.

#### Acceptance Criteria

1. WHEN foydalanuvchi to'lov usulini tanlaydi, THEN Sistema tanlangan to'lov tizimiga yo'naltiradi
2. WHEN to'lov muvaffaqiyatli bo'ladi, THEN Sistema buyurtmani tasdiqlaydi va chek yuboradi
3. IF to'lov muvaffaqiyatsiz bo'lsa, THEN Sistema xatolik xabarini ko'rsatadi va qayta urinish imkonini beradi
4. THE Sistema SHALL to'lov tarixini saqlaydi
5. WHEN to'lov tugallangandan keyin, THEN Sistema foydalanuvchiga SMS va email orqali xabar yuboradi

### Requirement 5: Buyurtmalar Tarixi

**User Story:** Foydalanuvchi sifatida, men o'z buyurtmalarim tarixini ko'rishni xohlayman, shunda oldingi xaridlarimni kuzatib bora olaman.

#### Acceptance Criteria

1. THE Sistema SHALL barcha buyurtmalarni sana bo'yicha tartiblangan holda ko'rsatadi
2. WHEN foydalanuvchi buyurtmani tanlaydi, THEN Sistema buyurtma tafsilotlarini ko'rsatadi
3. THE Sistema SHALL buyurtma holati (kutilmoqda, tasdiqlandi, yetkazilmoqda, yetkazildi) ni ko'rsatadi
4. WHEN buyurtma holati o'zgaradi, THEN Sistema foydalanuvchiga xabar yuboradi

### Requirement 6: Xavfsizlik

**User Story:** Foydalanuvchi sifatida, men shaxsiy ma'lumotlarim xavfsiz saqlanishini xohlayman, shunda ma'lumotlarim himoyalangan bo'ladi.

#### Acceptance Criteria

1. THE Sistema SHALL barcha shaxsiy ma'lumotlarni shifrlangan holda saqlaydi
2. THE Sistema SHALL faqat autentifikatsiya qilingan foydalanuvchilarga ma'lumotlarni ko'rsatadi
3. THE Sistema SHALL to'lov ma'lumotlarini saqlamaydi (faqat to'lov tizimiga yo'naltiradi)
4. WHEN foydalanuvchi tizimdan chiqadi, THEN Sistema session'ni o'chiradi
5. THE Sistema SHALL har 30 daqiqada session'ni yangilaydi

### Requirement 7: Offline Rejim

**User Story:** Foydalanuvchi sifatida, men internet aloqasi bo'lmasa ham panellar haqida ma'lumot ko'rishni xohlayman, shunda har doim ma'lumotga ega bo'laman.

#### Acceptance Criteria

1. WHEN internet aloqasi yo'q bo'lsa, THEN Sistema offline ma'lumotlarni ko'rsatadi
2. THE Sistema SHALL sotib olish funksiyasini faqat online rejimda yoqadi
3. WHEN internet aloqasi qayta tiklanadi, THEN Sistema ma'lumotlarni yangilaydi
