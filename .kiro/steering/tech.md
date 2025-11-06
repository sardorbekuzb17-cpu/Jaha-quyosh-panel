# Technology Stack

## Framework & Language

- **Flutter SDK**: 3.0+
- **Dart SDK**: 3.0+ (environment: >=2.12.0 <3.0.0)
- **Material Design 3**: UI design system

## Key Dependencies

**Networking & Data:**
- `dio` (5.3.2): HTTP client for API calls
- `http` (1.1.0): Alternative HTTP client
- `connectivity_plus` (5.0.1): Network connectivity monitoring

**Storage & State:**
- `shared_preferences` (2.2.2): Local data persistence and caching

**Utilities:**
- `package_info_plus` (4.2.0): App version checking
- `url_launcher` (6.0.9): Open external links (phone, email, social media)
- `carousel_slider` (5.1.1): Image carousels

**Development:**
- `flutter_lints` (1.0.0): Linting rules
- `flutter_launcher_icons` (0.14.2): App icon generation

## Backend

**Serverless API (Vercel):**
- Node.js 22.x runtime
- Serverless functions in `/api` directory
- Static JSON data served from `/public` directory
- GitHub raw files as fallback data source

**API Endpoints:**
- `/api/panels` - Panel data
- `/api/pricing` - Pricing packages
- `/api/contact` - Contact information
- `/api/version-check` - Version updates

## Common Commands

**Development:**
```bash
flutter pub get              # Install dependencies
flutter run -d chrome        # Run on web
flutter run -d android       # Run on Android
flutter run -d windows       # Run on Windows
```

**Building:**
```bash
flutter build apk --release           # Build release APK
flutter build apk --split-per-abi     # Build split APKs (smaller size)
flutter build web                     # Build for web
```

**Testing:**
```bash
flutter test                 # Run tests
flutter analyze              # Run static analysis
```

**Assets:**
```bash
flutter pub run flutter_launcher_icons:main  # Generate app icons
```

## Architecture Patterns

- **Service layer**: API calls and business logic in `/lib/services`
- **Model layer**: Data models with JSON serialization in `/lib/models`
- **Screen layer**: UI screens in `/lib/screens`
- **Widget layer**: Reusable UI components in `/lib/widgets`
- **Offline-first**: Cache data locally, fallback when no internet
