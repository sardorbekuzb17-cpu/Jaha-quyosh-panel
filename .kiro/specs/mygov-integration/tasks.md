# MyGov.uz Integration Implementation Tasks

- [ ] 1. Dependencies va Project Setup
  - [x] 1.1 Dependencies qo'shish


    - pubspec.yaml'ga oauth2, flutter_secure_storage, webview_flutter qo'shish
    - Dependencies'ni install qilish
    - _Requirements: 1.1, 1.2_

  - [ ] 1.2 Project structure yaratish
    - lib/services/auth/ papka yaratish
    - lib/services/order/ papka yaratish
    - lib/services/payment/ papka yaratish
    - lib/models/user/ papka yaratish
    - lib/screens/auth/ papka yaratish
    - _Requirements: Architecture_

  - [ ] 1.3 Environment configuration
    - .env fayl yaratish
    - MyGov client_id va client_secret qo'shish
    - API base URL'larni qo'shish
    - _Requirements: 3.2, 3.3_

- [ ] 2. Secure Storage Service
  - [ ] 2.1 SecureStorageService class yaratish
    - flutter_secure_storage instance yaratish
    - Token save/get metodlarini yozish
    - User profile save/get metodlarini yozish
    - Clear all metodi yozish
    - _Requirements: 2.1, 2.2, 6.1_

  - [ ]* 2.2 SecureStorageService unit tests
    - Token saqlash testlari
    - Ma'lumot o'qish testlari
    - Clear functionality testlari
    - _Requirements: Testing Strategy_

- [ ] 3. User Models
  - [ ] 3.1 UserProfile model yaratish
    - UserProfile class yaratish
    - fromJson va toJson metodlari
    - Validation metodlari
    - _Requirements: 2.1, 2.2_

  - [ ] 3.2 Order model yaratish
    - Order class yaratish
    - OrderStatus enum yaratish
    - fromJson va toJson metodlari
    - _Requirements: 3.1, 3.2, 3.3_

  - [ ] 3.3 Payment models yaratish
    - PaymentInfo class yaratish
    - PaymentMethod va PaymentStatus enum'lar
    - fromJson va toJson metodlari
    - _Requirements: 4.1, 4.2_

- [ ] 4. MyGov Authentication Service
  - [ ] 4.1 MyGovAuthService class yaratish
    - OAuth2 client setup
    - Authorization URL generation
    - Token exchange metodi
    - _Requirements: 1.1, 1.2, 1.3_

  - [ ] 4.2 Login flow implementation
    - initiateLogin() metodi
    - URL launcher integration
    - Callback handling
    - Token saqlash
    - _Requirements: 1.1, 1.2, 1.3_

  - [ ] 4.3 User profile fetching
    - getUserProfile() metodi
    - MyGov API'dan ma'lumot olish
    - Profile'ni local'ga saqlash
    - _Requirements: 2.1, 2.2_

  - [ ] 4.4 Token refresh mechanism
    - refreshToken() metodi
    - Auto-refresh logic
    - Token expiry handling
    - _Requirements: 1.5, 6.1_

  - [ ] 4.5 Logout functionality
    - logout() metodi
    - Token'larni o'chirish
    - Local ma'lumotlarni tozalash
    - _Requirements: 6.4_

  - [ ]* 4.6 Authentication service tests
    - Login flow testlari
    - Token refresh testlari
    - Logout testlari
    - _Requirements: Testing Strategy_

- [ ] 5. Login UI Screen
  - [ ] 5.1 LoginScreen widget yaratish
    - Scaffold va UI layout
    - MyGov login button
    - Guest mode button
    - Loading states
    - _Requirements: 1.1, 1.2_

  - [ ] 5.2 OAuth webview integration
    - WebView widget qo'shish
    - URL redirect handling
    - Authorization code extraction
    - _Requirements: 1.1, 1.2_

  - [ ] 5.3 Error handling UI
    - Error dialog'lar
    - Retry mechanism
    - User-friendly xabarlar
    - _Requirements: 1.4_

- [ ] 6. Profile Screen
  - [ ] 6.1 ProfileScreen widget yaratish
    - User ma'lumotlarini ko'rsatish
    - Avatar va FIO
    - JSHSHIR, telefon, manzil
    - _Requirements: 2.1, 2.2_

  - [ ] 6.2 Edit profile functionality
    - Edit form yaratish
    - Validation
    - Save changes
    - _Requirements: 2.3_

  - [ ] 6.3 Order history link
    - Order history button
    - Navigation
    - _Requirements: 2.4, 5.1_

- [ ] 7. Order Service
  - [ ] 7.1 OrderService class yaratish
    - API client setup
    - createOrder() metodi
    - getUserOrders() metodi
    - getOrderDetails() metodi
    - _Requirements: 3.1, 3.2, 3.3, 5.1_

  - [ ] 7.2 Order validation
    - Input validation
    - Stock checking
    - Price calculation
    - _Requirements: 3.2_

  - [ ] 7.3 Order status tracking
    - updateOrderStatus() metodi
    - Status change notifications
    - _Requirements: 5.3, 5.4_

  - [ ]* 7.4 Order service tests
    - Order creation testlari
    - Order retrieval testlari
    - Status update testlari
    - _Requirements: Testing Strategy_

- [ ] 8. Order UI Screens
  - [ ] 8.1 OrderScreen widget yaratish
    - Panel selection
    - Quantity selector
    - Delivery address form
    - Order summary
    - _Requirements: 3.1, 3.2, 3.3_

  - [ ] 8.2 Auto-fill user data
    - MyGov ma'lumotlaridan auto-fill
    - Address, telefon, FIO
    - Edit qilish imkoniyati
    - _Requirements: 3.3_

  - [ ] 8.3 Order confirmation
    - Confirmation dialog
    - Order details review
    - Submit button
    - _Requirements: 3.4_

  - [ ] 8.4 OrderHistoryScreen widget
    - Orders list view
    - Status badges
    - Order details navigation
    - _Requirements: 5.1, 5.2_

  - [ ] 8.5 OrderDetailsScreen widget
    - Full order information
    - Status timeline
    - Track order button
    - _Requirements: 5.2, 5.3_

- [ ] 9. Payment Service
  - [ ] 9.1 PaymentService class yaratish
    - initiatePayment() metodi
    - checkPaymentStatus() metodi
    - cancelPayment() metodi
    - _Requirements: 4.1, 4.2, 4.3_

  - [ ] 9.2 Click integration
    - Click API setup
    - Payment URL generation
    - Callback handling
    - _Requirements: 4.1, 4.5_

  - [ ] 9.3 Payme integration
    - Payme API setup
    - Payment URL generation
    - Callback handling
    - _Requirements: 4.1, 4.5_

  - [ ] 9.4 Uzum integration
    - Uzum API setup
    - Payment URL generation
    - Callback handling
    - _Requirements: 4.1, 4.5_

  - [ ]* 9.5 Payment service tests
    - Payment initiation testlari
    - Status check testlari
    - Callback handling testlari
    - _Requirements: Testing Strategy_

- [ ] 10. Payment UI Screens
  - [ ] 10.1 PaymentScreen widget yaratish
    - Payment method selection
    - Amount display
    - Payment button
    - _Requirements: 4.1, 4.2_

  - [ ] 10.2 Payment webview
    - WebView for payment gateway
    - URL handling
    - Success/failure detection
    - _Requirements: 4.2_

  - [ ] 10.3 Payment confirmation
    - Success screen
    - Receipt display
    - Order confirmation
    - _Requirements: 4.2, 4.5_

  - [ ] 10.4 Payment error handling
    - Error messages
    - Retry mechanism
    - Cancel option
    - _Requirements: 4.3_

- [ ] 11. Backend API Endpoints (Vercel)
  - [ ] 11.1 MyGov callback handler
    - /api/auth/mygov/callback endpoint
    - Authorization code validation
    - Token exchange
    - _Requirements: 1.1, 1.2_

  - [ ] 11.2 User profile endpoints
    - GET /api/user/profile
    - PUT /api/user/profile
    - Profile validation
    - _Requirements: 2.1, 2.2, 2.3_

  - [ ] 11.3 Order endpoints
    - POST /api/orders
    - GET /api/orders
    - GET /api/orders/:id
    - PUT /api/orders/:id/status
    - _Requirements: 3.1, 3.2, 3.3, 5.3_

  - [ ] 11.4 Payment endpoints
    - POST /api/payments/initiate
    - GET /api/payments/:id/status
    - POST /api/payments/:id/cancel
    - _Requirements: 4.1, 4.2, 4.3_

- [ ] 12. Security Implementation
  - [ ] 12.1 SSL Certificate Pinning
    - Certificate pinning setup
    - Dio interceptor
    - Certificate validation
    - _Requirements: 6.1, 6.2_

  - [ ] 12.2 Data encryption
    - AES-256 encryption setup
    - Encrypt sensitive data
    - Decrypt on read
    - _Requirements: 6.1, 6.2_

  - [ ] 12.3 Request signing
    - HMAC-SHA256 implementation
    - Sign all API requests
    - Verify signatures
    - _Requirements: 6.3_

  - [ ] 12.4 Session management
    - Session timeout logic
    - Auto-refresh mechanism
    - Secure logout
    - _Requirements: 6.4, 6.5_

- [ ] 13. Offline Mode Support
  - [ ] 13.1 Offline detection
    - Connectivity checking
    - Offline mode UI
    - _Requirements: 7.1, 7.2_

  - [ ] 13.2 Cached data display
    - Show cached panels
    - Disable purchase in offline
    - _Requirements: 7.1, 7.2_

  - [ ] 13.3 Sync on reconnect
    - Auto-sync when online
    - Update cached data
    - _Requirements: 7.3_

- [ ] 14. Notifications
  - [ ] 14.1 Order status notifications
    - Firebase Cloud Messaging setup
    - Order status change notifications
    - _Requirements: 5.4_

  - [ ] 14.2 Payment notifications
    - Payment success notification
    - Payment failure notification
    - _Requirements: 4.5_

  - [ ] 14.3 SMS/Email notifications
    - Backend SMS integration
    - Backend Email integration
    - _Requirements: 4.5_

- [ ] 15. Testing va QA
  - [ ]* 15.1 Unit tests
    - Service tests
    - Model tests
    - Utility tests
    - _Requirements: Testing Strategy_

  - [ ]* 15.2 Integration tests
    - OAuth flow test
    - Order flow test
    - Payment flow test
    - _Requirements: Testing Strategy_

  - [ ]* 15.3 UI tests
    - Login flow test
    - Order placement test
    - Payment flow test
    - _Requirements: Testing Strategy_

  - [ ] 15.4 Manual testing
    - End-to-end testing
    - Edge cases testing
    - Error scenarios testing
    - _Requirements: All_

- [ ] 16. Documentation
  - [ ] 16.1 API documentation
    - Endpoint documentation
    - Request/response examples
    - Error codes
    - _Requirements: All_

  - [ ] 16.2 User guide
    - How to login
    - How to order
    - How to pay
    - _Requirements: All_

  - [ ] 16.3 Developer documentation
    - Setup instructions
    - Architecture overview
    - Code examples
    - _Requirements: All_
