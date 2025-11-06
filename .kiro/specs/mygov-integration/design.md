# MyGov.uz Integration Design Document

## Overview

Quyosh24 ilovasiga MyGov.uz OAuth 2.0 va FaceID integratsiyasi orqali xavfsiz autentifikatsiya va sotib olish funksiyalarini qo'shish. Foydalanuvchilar MyGov.uz orqali tizimga kirib, quyosh panellarini sotib olishlari mumkin.

## Architecture

### High-Level Architecture

```
┌─────────────────┐
│   Flutter App   │
│   (Quyosh24)    │
└────────┬────────┘
         │
         ├─────────────────┐
         │                 │
         ▼                 ▼
┌─────────────────┐  ┌──────────────┐
│   MyGov.uz      │  │   Backend    │
│   OAuth API     │  │   Server     │
│   + FaceID      │  │   (Vercel)   │
└─────────────────┘  └──────┬───────┘
                            │
                            ▼
                     ┌──────────────┐
                     │   Payment    │
                     │   Gateways   │
                     │ Click/Payme  │
                     └──────────────┘
```

### Authentication Flow

```
User → Tap "MyGov orqali kirish"
  ↓
App → Redirect to MyGov.uz OAuth
  ↓
MyGov.uz → FaceID Authentication
  ↓
MyGov.uz → Return authorization code
  ↓
App → Exchange code for access token
  ↓
App → Get user profile from MyGov.uz
  ↓
App → Save user session locally
  ↓
User → Logged in successfully
```

## Components and Interfaces

### 1. Authentication Service

**Purpose:** MyGov.uz OAuth va FaceID autentifikatsiyasini boshqarish

**Key Methods:**
```dart
class MyGovAuthService {
  // OAuth login boshlash
  Future<void> initiateLogin();
  
  // Authorization code'ni token'ga almashtirish
  Future<String> exchangeCodeForToken(String code);
  
  // Foydalanuvchi ma'lumotlarini olish
  Future<UserProfile> getUserProfile(String accessToken);
  
  // Token'ni yangilash
  Future<String> refreshToken(String refreshToken);
  
  // Logout
  Future<void> logout();
  
  // Session tekshirish
  bool isAuthenticated();
}
```

**Dependencies:**
- `oauth2` package
- `flutter_secure_storage` (token saqlash uchun)
- `http` (API calls)

### 2. User Profile Model

**Purpose:** Foydalanuvchi ma'lumotlarini saqlash

```dart
class UserProfile {
  final String id;              // MyGov user ID
  final String pinfl;           // JSHSHIR
  final String firstName;
  final String lastName;
  final String middleName;
  final String phoneNumber;
  final String email;
  final String address;
  final DateTime birthDate;
  final String passportSeries;
  final String passportNumber;
  
  // Constructor, fromJson, toJson methods
}
```

### 3. Order Management Service

**Purpose:** Buyurtmalarni boshqarish

```dart
class OrderService {
  // Yangi buyurtma yaratish
  Future<Order> createOrder({
    required String userId,
    required String panelId,
    required int quantity,
    required double totalPrice,
  });
  
  // Buyurtmalarni olish
  Future<List<Order>> getUserOrders(String userId);
  
  // Buyurtma tafsilotlari
  Future<Order> getOrderDetails(String orderId);
  
  // Buyurtma holatini yangilash
  Future<void> updateOrderStatus(String orderId, OrderStatus status);
}
```

### 4. Payment Service

**Purpose:** To'lov jarayonini boshqarish

```dart
class PaymentService {
  // To'lov boshlash
  Future<PaymentSession> initiatePayment({
    required String orderId,
    required double amount,
    required PaymentMethod method,
  });
  
  // To'lov holatini tekshirish
  Future<PaymentStatus> checkPaymentStatus(String paymentId);
  
  // To'lovni bekor qilish
  Future<void> cancelPayment(String paymentId);
}

enum PaymentMethod {
  click,
  payme,
  uzum,
  mygovWallet,
}

enum PaymentStatus {
  pending,
  processing,
  completed,
  failed,
  cancelled,
}
```

### 5. Secure Storage Service

**Purpose:** Sensitive ma'lumotlarni xavfsiz saqlash

```dart
class SecureStorageService {
  // Token saqlash
  Future<void> saveAccessToken(String token);
  Future<String?> getAccessToken();
  
  // Refresh token
  Future<void> saveRefreshToken(String token);
  Future<String?> getRefreshToken();
  
  // User profile
  Future<void> saveUserProfile(UserProfile profile);
  Future<UserProfile?> getUserProfile();
  
  // Barcha ma'lumotlarni o'chirish
  Future<void> clearAll();
}
```

## Data Models

### Order Model

```dart
class Order {
  final String id;
  final String userId;
  final String panelId;
  final String panelName;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? trackingNumber;
  final PaymentInfo? paymentInfo;
  
  // Delivery address
  final String deliveryAddress;
  final String deliveryCity;
  final String deliveryRegion;
  final String deliveryPhone;
}

enum OrderStatus {
  pending,      // Kutilmoqda
  confirmed,    // Tasdiqlandi
  processing,   // Tayyorlanmoqda
  shipping,     // Yetkazilmoqda
  delivered,    // Yetkazildi
  cancelled,    // Bekor qilindi
}
```

### Payment Info Model

```dart
class PaymentInfo {
  final String paymentId;
  final PaymentMethod method;
  final double amount;
  final PaymentStatus status;
  final DateTime paidAt;
  final String? transactionId;
}
```

## UI Screens

### 1. Login Screen

**Path:** `lib/screens/auth/login_screen.dart`

**Features:**
- MyGov.uz login button
- Guest mode (browse without login)
- Terms and conditions

### 2. Profile Screen

**Path:** `lib/screens/profile/profile_screen.dart`

**Features:**
- User information display
- Edit profile
- Order history
- Logout button

### 3. Order Screen

**Path:** `lib/screens/order/order_screen.dart`

**Features:**
- Panel selection
- Quantity selector
- Delivery address form (auto-filled from MyGov)
- Order summary
- Payment method selection

### 4. Payment Screen

**Path:** `lib/screens/payment/payment_screen.dart`

**Features:**
- Payment method cards (Click, Payme, Uzum)
- Payment amount display
- Secure payment webview
- Payment confirmation

### 5. Order History Screen

**Path:** `lib/screens/order/order_history_screen.dart`

**Features:**
- List of all orders
- Order status badges
- Order details view
- Track order button

## API Endpoints

### MyGov.uz OAuth Endpoints

```
Authorization URL: https://sso.egov.uz/sso/oauth/Authorization.do
Token URL: https://sso.egov.uz/sso/oauth/Authorization.do
User Info URL: https://sso.egov.uz/sso/oauth/Authorization.do
```

### Backend API Endpoints (Vercel)

```
POST   /api/auth/mygov/callback    - MyGov callback handler
GET    /api/user/profile           - Get user profile
PUT    /api/user/profile           - Update user profile

POST   /api/orders                 - Create new order
GET    /api/orders                 - Get user orders
GET    /api/orders/:id             - Get order details
PUT    /api/orders/:id/status      - Update order status

POST   /api/payments/initiate      - Initiate payment
GET    /api/payments/:id/status    - Check payment status
POST   /api/payments/:id/cancel    - Cancel payment
```

## Security Measures

### 1. Token Security
- Access token: 1 soat amal qiladi
- Refresh token: 30 kun amal qiladi
- Token'lar `flutter_secure_storage`da saqlanadi
- Token'lar shifrlangan holda saqlanadi

### 2. API Security
- Barcha API so'rovlar HTTPS orqali
- SSL Certificate Pinning
- Request signing (HMAC-SHA256)
- Rate limiting

### 3. Data Encryption
- Local ma'lumotlar AES-256 bilan shifrlangan
- Sensitive ma'lumotlar hech qachon plain text'da saqlanmaydi

### 4. Session Management
- Session timeout: 30 daqiqa
- Auto-refresh token mechanism
- Secure logout (barcha ma'lumotlarni o'chirish)

## Error Handling

### Authentication Errors
```dart
enum AuthError {
  networkError,           // Internet aloqasi yo'q
  invalidCredentials,     // Noto'g'ri ma'lumotlar
  tokenExpired,          // Token muddati tugagan
  serverError,           // Server xatosi
  userCancelled,         // Foydalanuvchi bekor qildi
}
```

### Payment Errors
```dart
enum PaymentError {
  insufficientFunds,     // Mablag' yetarli emas
  paymentDeclined,       // To'lov rad etildi
  networkError,          // Aloqa xatosi
  timeout,               // Vaqt tugadi
  invalidCard,           // Noto'g'ri karta
}
```

## Testing Strategy

### Unit Tests
- Authentication service tests
- Order service tests
- Payment service tests
- Data model tests

### Integration Tests
- MyGov OAuth flow test
- Payment gateway integration test
- Order creation flow test

### UI Tests
- Login flow test
- Order placement test
- Payment flow test

## Dependencies

```yaml
dependencies:
  # OAuth & Authentication
  oauth2: ^2.0.2
  flutter_secure_storage: ^9.0.0
  
  # HTTP & Networking
  http: ^1.1.0
  dio: ^5.3.2
  
  # State Management
  provider: ^6.1.1
  
  # URL Launcher (for OAuth)
  url_launcher: ^6.2.1
  
  # WebView (for payments)
  webview_flutter: ^4.4.2
  
  # Local Storage
  shared_preferences: ^2.2.2
  
  # Encryption
  encrypt: ^5.0.3
  
  # QR Code (for payment)
  qr_flutter: ^4.1.0
```

## Implementation Phases

### Phase 1: Authentication (Week 1)
- MyGov OAuth integration
- Login/Logout functionality
- User profile management
- Secure token storage

### Phase 2: Order Management (Week 2)
- Order creation
- Order history
- Order details
- Order status tracking

### Phase 3: Payment Integration (Week 3)
- Click integration
- Payme integration
- Uzum integration
- Payment confirmation

### Phase 4: Testing & Polish (Week 4)
- Unit tests
- Integration tests
- UI/UX improvements
- Bug fixes

## Monitoring & Analytics

### Key Metrics
- Login success rate
- Order completion rate
- Payment success rate
- Average order value
- User retention rate

### Error Tracking
- Authentication failures
- Payment failures
- API errors
- Crash reports

## Compliance

### Data Privacy
- GDPR compliance
- O'zbekiston data protection laws
- User consent management
- Data retention policies

### Security Standards
- OWASP Mobile Top 10
- PCI DSS (for payments)
- OAuth 2.0 best practices
- SSL/TLS 1.3
