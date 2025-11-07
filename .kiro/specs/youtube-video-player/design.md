# Dizayn Hujjati (Design Document)

## Umumiy Ko'rinish

YouTube video player funksiyasi Flutter ilovasiga qo'shiladi va foydalanuvchilarga quyosh panellari va inverterlar haqida ta'limiy videolarni to'g'ridan-to'g'ri app ichida tomosha qilish imkonini beradi. Dizayn mavjud arxitektura va UI/UX stiliga mos ravishda amalga oshiriladi.

## Arxitektura

### Komponentlar Tuzilishi

```
lib/
├── models/
│   └── video_model.dart          # Video ma'lumotlari modeli
├── services/
│   └── video_service.dart        # Video ma'lumotlarini boshqarish xizmati
├── screens/
│   ├── videos_screen.dart        # Videolar ro'yxati ekrani
│   └── video_player_screen.dart  # Video ijro etish ekrani
├── widgets/
│   └── video_card.dart           # Video kartochka widgeti
└── utils/
    └── youtube_helper.dart       # YouTube URL va ID bilan ishlash
```

### Texnologiyalar va Paketlar

1. **youtube_player_flutter** (^8.1.2) - YouTube videolarni Flutter'da ijro etish uchun
2. **cached_network_image** (^3.3.0) - Video thumbnail'larni keshlash uchun
3. **http** (mavjud) - Backend API bilan aloqa uchun

## Komponentlar va Interfeyslar

### 1. Video Model (video_model.dart)

```dart
class VideoModel {
  final String id;
  final String title;
  final String description;
  final String youtubeId;
  final String thumbnailUrl;
  final String category;
  final int order;
  final DateTime createdAt;

  VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.youtubeId,
    required this.thumbnailUrl,
    required this.category,
    required this.order,
    required this.createdAt,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
```

### 2. Video Service (video_service.dart)

Video ma'lumotlarini boshqarish uchun xizmat:

```dart
class VideoService {
  // Barcha videolarni olish
  Future<List<VideoModel>> fetchVideos();
  
  // Kategoriya bo'yicha videolarni olish
  Future<List<VideoModel>> fetchVideosByCategory(String category);
  
  // Qidiruv
  Future<List<VideoModel>> searchVideos(String query);
  
  // Admin: Video qo'shish
  Future<bool> addVideo(VideoModel video);
  
  // Admin: Video yangilash
  Future<bool> updateVideo(VideoModel video);
  
  // Admin: Video o'chirish
  Future<bool> deleteVideo(String videoId);
}
```

### 3. Videos Screen (videos_screen.dart)

Videolar ro'yxatini ko'rsatadigan asosiy ekran:

- AppBar: Qidiruv va filtr tugmalari
- Body: GridView yoki ListView formatida video kartochkalar
- Kategoriya filtrlari (Tabs yoki Dropdown)
- Pull-to-refresh funksiyasi

### 4. Video Player Screen (video_player_screen.dart)

Videoni ijro etish ekrani:

- YouTube Player widget
- Video sarlavhasi va tavsifi
- Tegishli videolar ro'yxati (opsional)
- Orqaga qaytish tugmasi

### 5. Video Card Widget (video_card.dart)

Har bir video uchun kartochka:

- Thumbnail rasm
- Video sarlavhasi
- Video davomiyligi
- Kategoriya belgisi
- Tap orqali video player'ga o'tish

## Ma'lumotlar Modeli

### Backend API Endpointlari

```
GET    /api/videos              # Barcha videolarni olish
GET    /api/videos/:id          # Bitta videoni olish
GET    /api/videos/category/:cat # Kategoriya bo'yicha
GET    /api/videos/search?q=    # Qidiruv
POST   /api/admin/videos        # Video qo'shish (admin)
PUT    /api/admin/videos/:id    # Video yangilash (admin)
DELETE /api/admin/videos/:id    # Video o'chirish (admin)
```

### JSON Format

```json
{
  "id": "uuid",
  "title": "Quyosh panellarini o'rnatish",
  "description": "Quyosh panellarini to'g'ri o'rnatish bo'yicha qo'llanma",
  "youtubeId": "dQw4w9WgXcQ",
  "thumbnailUrl": "https://img.youtube.com/vi/dQw4w9WgXcQ/maxresdefault.jpg",
  "category": "panels",
  "order": 1,
  "createdAt": "2024-01-01T00:00:00Z"
}
```

### Kategoriyalar

- `panels` - Quyosh panellari
- `inverters` - Inverterlar
- `installation` - O'rnatish
- `maintenance` - Texnik xizmat
- `general` - Umumiy ma'lumotlar

## Xatoliklarni Boshqarish

### Xato Turlari va Javoblar

1. **Internet aloqasi yo'q**
   - Xabar: "Internet aloqasi yo'q. Iltimos, internetni yoqing."
   - Action: Qayta urinish tugmasi

2. **Video yuklanmadi**
   - Xabar: "Video yuklanmadi. Qayta urinib ko'ring."
   - Action: Qayta yuklash tugmasi

3. **YouTube xatosi**
   - Xabar: "Video ijro etishda xatolik yuz berdi."
   - Action: Orqaga qaytish yoki qayta urinish

4. **Backend xatosi**
   - Xabar: "Ma'lumotlarni yuklashda xatolik. Keyinroq urinib ko'ring."
   - Action: Qayta yuklash tugmasi

### Xatolarni Qayd Qilish

```dart
try {
  // Video yuklash
} catch (e) {
  print('Video yuklashda xato: $e');
  // Foydalanuvchiga xabar ko'rsatish
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Xatolik yuz berdi')),
  );
}
```

## Test Strategiyasi

### 1. Unit Testlar

- VideoModel serialization/deserialization
- VideoService API chaqiruvlari
- YouTube ID ekstraktsiyasi
- Qidiruv va filtr logikasi

### 2. Widget Testlar

- VideoCard widget ko'rinishi
- VideosScreen ro'yxat ko'rsatish
- VideoPlayerScreen player ko'rsatish
- Qidiruv va filtr UI

### 3. Integration Testlar

- Video ro'yxatini yuklash va ko'rsatish
- Videoni tanlash va ijro etish
- Qidiruv funksiyasi
- Admin panel orqali video qo'shish

### 4. Manual Testlar

- Turli internet tezliklarida video ijro etish
- Ekranni aylantirish (portrait/landscape)
- Orqa fonda video ijro etish
- Batareya iste'moli

## UI/UX Dizayn

### Ranglar va Stillar

Mavjud app stiliga mos:
- Primary: `Color(0xFF1E3A8A)` - Quyuq ko'k
- Secondary: `Color(0xFF3B82F6)` - Ko'k
- Accent: `Color(0xFFFBBF24)` - Oltin
- Background: Gradient (mavjud dizaynga mos)

### Ekran Layoutlari

**Videos Screen:**
```
┌─────────────────────────┐
│ AppBar (Qidiruv, Filtr) │
├─────────────────────────┤
│ Kategoriya Tabs         │
├─────────────────────────┤
│ ┌─────┐ ┌─────┐        │
│ │Video│ │Video│        │
│ │Card │ │Card │        │
│ └─────┘ └─────┘        │
│ ┌─────┐ ┌─────┐        │
│ │Video│ │Video│        │
│ │Card │ │Card │        │
│ └─────┘ └─────┘        │
└─────────────────────────┘
```

**Video Player Screen:**
```
┌─────────────────────────┐
│ ← Orqaga                │
├─────────────────────────┤
│                         │
│   YouTube Player        │
│   (16:9 aspect ratio)   │
│                         │
├─────────────────────────┤
│ Video Sarlavhasi        │
│ Video Tavsifi           │
│                         │
│ Tegishli Videolar       │
│ ┌─────┐ ┌─────┐        │
│ │Video│ │Video│        │
│ └─────┘ └─────┘        │
└─────────────────────────┘
```

## Admin Panel Integratsiyasi

### Admin Dashboard'ga Yangi Bo'lim

Mavjud `admin_dashboard_screen.dart` ga yangi bo'lim qo'shiladi:

```dart
ListTile(
  leading: Icon(Icons.video_library),
  title: Text('Videolarni Boshqarish'),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminVideosScreen(),
      ),
    );
  },
)
```

### Admin Videos Screen

- Barcha videolar ro'yxati
- Video qo'shish tugmasi (FloatingActionButton)
- Har bir video uchun tahrirlash va o'chirish tugmalari
- Video qo'shish/tahrirlash dialog yoki ekrani

### Video Qo'shish Formasi

```
- YouTube URL input
- Sarlavha input
- Tavsif input (multiline)
- Kategoriya dropdown
- Tartib raqami input
- Saqlash tugmasi
```

## Performance Optimizatsiyasi

1. **Thumbnail Keshlash**: `cached_network_image` dan foydalanish
2. **Lazy Loading**: Videolar ro'yxatini sahifalash (pagination)
3. **Video Preloading**: Keyingi videoni oldindan yuklash
4. **Memory Management**: Video player'ni to'g'ri dispose qilish
5. **Network Optimization**: Faqat kerakli ma'lumotlarni yuklash

## Xavfsizlik

1. **Admin Autentifikatsiya**: Mavjud admin login tizimidan foydalanish
2. **API Token**: Backend API uchun token autentifikatsiyasi
3. **Input Validation**: YouTube URL validatsiyasi
4. **XSS Prevention**: HTML kontentni sanitize qilish

## Kelajakda Qo'shilishi Mumkin Bo'lgan Funksiyalar

1. Video yuklab olish (offline ko'rish)
2. Sevimli videolar ro'yxati
3. Video ko'rish tarixi
4. Video ulashish
5. Izohlar va reytinglar
6. Playlist yaratish
