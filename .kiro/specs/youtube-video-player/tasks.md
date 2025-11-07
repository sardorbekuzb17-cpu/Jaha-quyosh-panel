# Vazifalar Ro'yxati (Implementation Plan)

- [ ] 1. Loyiha tuzilishi va asosiy interfeyslarni sozlash
  - Kerakli paketlarni `pubspec.yaml` ga qo'shish (youtube_player_flutter, cached_network_image)
  - Papkalar tuzilishini yaratish (models, services, screens, widgets, utils)
  - _Talablar: 1.1, 1.2_

- [ ] 2. Video model va yordamchi funksiyalarni yaratish
  - [ ] 2.1 VideoModel klassini yaratish
    - VideoModel klassini JSON serialization/deserialization bilan yaratish
    - Model uchun kerakli fieldlarni (id, title, description, youtubeId, category, order) qo'shish
    - _Talablar: 1.5, 2.3_
  
  - [ ] 2.2 YouTube helper funksiyalarini yaratish
    - YouTube URL dan video ID ni ekstraktsiya qilish funksiyasini yozish
    - Thumbnail URL generatsiya qilish funksiyasini yozish
    - _Talablar: 1.1, 2.2_

- [ ] 3. Video Service yaratish
  - [ ] 3.1 VideoService klassini yaratish
    - Backend API bilan aloqa uchun asosiy strukturani yaratish
    - HTTP client konfiguratsiyasini sozlash
    - _Talablar: 1.1, 2.1_
  
  - [ ] 3.2 Video CRUD operatsiyalarini implement qilish
    - fetchVideos() metodini yozish (barcha videolarni olish)
    - fetchVideosByCategory() metodini yozish (kategoriya bo'yicha)
    - searchVideos() metodini yozish (qidiruv)
    - _Talablar: 1.1, 4.1, 4.2, 4.3_
  
  - [ ] 3.3 Admin CRUD operatsiyalarini implement qilish
    - addVideo() metodini yozish (video qo'shish)
    - updateVideo() metodini yozish (video yangilash)
    - deleteVideo() metodini yozish (video o'chirish)
    - _Talablar: 2.1, 2.2, 2.4_
  
  - [ ] 3.4 Xatoliklarni boshqarish va error handling
    - Try-catch bloklarini qo'shish
    - Network xatolarini boshqarish
    - Timeout va retry logikasini qo'shish
    - _Talablar: 3.3_

- [ ] 4. Video Card widgetini yaratish
  - [ ] 4.1 VideoCard widget strukturasini yaratish
    - Thumbnail, sarlavha, kategoriya ko'rsatadigan widget yaratish
    - Cached network image bilan thumbnail yuklash
    - _Talablar: 1.5_
  
  - [ ] 4.2 VideoCard interaktivligini qo'shish
    - Tap gesture detector qo'shish
    - Video player ekraniga navigatsiya qilish
    - Loading va error state'larini ko'rsatish
    - _Talablar: 1.2_

- [ ] 5. Videos Screen (videolar ro'yxati) yaratish
  - [ ] 5.1 VideosScreen asosiy strukturasini yaratish
    - AppBar bilan ekran yaratish
    - GridView yoki ListView bilan videolar ro'yxatini ko'rsatish
    - Pull-to-refresh funksiyasini qo'shish
    - _Talablar: 1.1, 1.4_
  
  - [ ] 5.2 Kategoriya filtrlash funksiyasini qo'shish
    - Kategoriya tabs yoki dropdown yaratish
    - Kategoriya bo'yicha videolarni filtrlash
    - _Talablar: 1.4, 4.2_
  
  - [ ] 5.3 Qidiruv funksiyasini implement qilish
    - Qidiruv input fieldini qo'shish
    - Real-time yoki debounced qidiruv implement qilish
    - Qidiruv natijalari bo'sh bo'lsa xabar ko'rsatish
    - _Talablar: 4.1, 4.3, 4.5_
  
  - [ ] 5.4 Loading va error state'larini qo'shish
    - Loading indicator ko'rsatish
    - Error xabarlarini ko'rsatish
    - Qayta urinish tugmasini qo'shish
    - _Talablar: 3.3, 3.4_

- [ ] 6. Video Player Screen yaratish
  - [ ] 6.1 VideoPlayerScreen asosiy strukturasini yaratish
    - YouTube player widget integratsiyasini qo'shish
    - Video sarlavha va tavsifini ko'rsatish
    - Orqaga qaytish tugmasini qo'shish
    - _Talablar: 1.1, 1.2_
  
  - [ ] 6.2 Video player kontrollarini sozlash
    - Play, pause, seek funksiyalarini yoqish
    - Fullscreen rejimini qo'shish
    - Volume kontrolini qo'shish
    - _Talablar: 1.3_
  
  - [ ] 6.3 Video player lifecycle management
    - Video player'ni to'g'ri initialize qilish
    - Dispose metodini implement qilish
    - Screen rotation'ni boshqarish
    - _Talablar: 1.2, 3.1_
  
  - [ ] 6.4 Video yuklash va error handling
    - Loading indicator ko'rsatish
    - Network xatolarini boshqarish
    - Qayta urinish funksiyasini qo'shish
    - _Talablar: 3.1, 3.2, 3.3, 3.4_

- [ ] 7. Home Screen'ga videolar bo'limini qo'shish
  - [ ] 7.1 Bottom navigation'ga yangi tab qo'shish
    - "Videolar" yoki "Ta'lim" tab qo'shish
    - Icon va label sozlash
    - _Talablar: 1.1_
  
  - [ ] 7.2 Navigation'ni ulash
    - VideosScreen'ni home screen children ro'yxatiga qo'shish
    - Tab tap orqali ekranga o'tishni sozlash
    - _Talablar: 1.1_

- [ ] 8. Admin panel integratsiyasini yaratish
  - [ ] 8.1 Admin Videos Screen yaratish
    - Barcha videolar ro'yxatini ko'rsatish
    - Har bir video uchun tahrirlash va o'chirish tugmalari
    - FloatingActionButton bilan yangi video qo'shish
    - _Talablar: 2.1, 2.4_
  
  - [ ] 8.2 Video qo'shish/tahrirlash formasi yaratish
    - YouTube URL input field
    - Sarlavha va tavsif input fieldlari
    - Kategoriya dropdown
    - Tartib raqami input
    - Form validatsiyasini qo'shish
    - _Talablar: 2.1, 2.2, 2.3_
  
  - [ ] 8.3 Admin CRUD operatsiyalarini ulash
    - Video qo'shish funksiyasini ulash
    - Video tahrirlash funksiyasini ulash
    - Video o'chirish funksiyasini ulash (confirmation dialog bilan)
    - _Talablar: 2.1, 2.4_
  
  - [ ] 8.4 Admin dashboard'ga videolar bo'limini qo'shish
    - Admin dashboard'da yangi ListTile qo'shish
    - AdminVideosScreen'ga navigatsiya qo'shish
    - _Talablar: 2.1_

- [ ] 9. Backend API endpointlarini yaratish
  - [ ] 9.1 Videos API endpointlarini yaratish
    - GET /api/videos endpoint (barcha videolar)
    - GET /api/videos/:id endpoint (bitta video)
    - GET /api/videos/category/:cat endpoint (kategoriya bo'yicha)
    - GET /api/videos/search endpoint (qidiruv)
    - _Talablar: 1.1, 4.1, 4.2_
  
  - [ ] 9.2 Admin API endpointlarini yaratish
    - POST /api/admin/videos endpoint (video qo'shish)
    - PUT /api/admin/videos/:id endpoint (video yangilash)
    - DELETE /api/admin/videos/:id endpoint (video o'chirish)
    - Admin autentifikatsiya middleware qo'shish
    - _Talablar: 2.1, 2.4_
  
  - [ ] 9.3 Database schema va migratsiyalarini yaratish
    - Videos jadvali yaratish
    - Kerakli indekslarni qo'shish
    - Seed data qo'shish (test uchun)
    - _Talablar: 2.1, 2.3, 2.5_

- [ ] 10. Performance optimizatsiya va polishing
  - [ ] 10.1 Thumbnail keshlash va lazy loading
    - cached_network_image sozlamalarini optimallashtirish
    - Pagination yoki infinite scroll qo'shish
    - _Talablar: 3.1, 3.2_
  
  - [ ] 10.2 UI/UX yaxshilash
    - Animatsiyalar qo'shish (page transitions, loading)
    - Mavjud app stiliga to'liq mos qilish
    - Responsive dizayn tekshirish
    - _Talablar: 1.1, 1.2, 1.5_
  
  - [ ] 10.3 Offline support va connectivity handling
    - Internet aloqasi yo'q holatini boshqarish
    - Keshlangan ma'lumotlarni ko'rsatish
    - Connectivity status indicator
    - _Talablar: 3.3_

- [ ]* 11. Testing va debugging
  - [ ]* 11.1 Unit testlar yozish
    - VideoModel serialization testlari
    - VideoService metodlari uchun testlar
    - YouTube helper funksiyalari testlari
    - _Talablar: Barcha_
  
  - [ ]* 11.2 Widget testlar yozish
    - VideoCard widget testlari
    - VideosScreen widget testlari
    - VideoPlayerScreen widget testlari
    - _Talablar: Barcha_
  
  - [ ]* 11.3 Integration testlar yozish
    - End-to-end video ko'rish flow testi
    - Admin panel CRUD operatsiyalari testi
    - Qidiruv va filtr funksiyalari testi
    - _Talablar: Barcha_
  
  - [ ]* 11.4 Manual testing va bug fixing
    - Turli qurilmalarda test qilish
    - Turli internet tezliklarida test qilish
    - Edge case'larni test qilish
    - Topilgan bug'larni tuzatish
    - _Talablar: Barcha_
