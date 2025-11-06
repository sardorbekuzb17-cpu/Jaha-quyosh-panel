# Project Structure

## Root Directory

```
/api/                    # Serverless API functions (Node.js)
/public/                 # Static JSON data files
/assets/images/          # App images and icons
/lib/                    # Flutter application code
/android/                # Android platform code
/ios/                    # iOS platform code
/web/                    # Web platform code
/windows/                # Windows platform code
/linux/                  # Linux platform code
/macos/                  # macOS platform code
/test/                   # Test files
```

## Flutter App Structure (`/lib`)

```
/lib/
  main.dart              # App entry point
  /models/               # Data models
    panel_model.dart     # Panel, Pricing, Contact models
    solar_panel.dart     # Legacy panel model
    inverter_model.dart  # Inverter data model
  /screens/              # UI screens
    splash_screen.dart
    home_screen.dart
    panels_screen.dart
    pricing_screen.dart
    contact_screen.dart
    calculator_screen.dart
    gallery_screen.dart
    faq_screen.dart
    info_screen.dart
    inverters_screen.dart
    admin_*.dart         # Admin panel screens
  /services/             # Business logic & API
    api_service.dart     # HTTP client & API calls
    cache_service.dart   # Local data caching
    update_service.dart  # Version checking
    solar_panel_service.dart
  /widgets/              # Reusable components
    panel_card.dart      # Panel display card
    inverter_card.dart   # Inverter display card
    info_card.dart       # Info display card
    ads_carousel.dart    # Advertisement carousel
```

## API Structure (`/api`)

```
/api/
  panels.js              # Panel data endpoint
  contact.js             # Contact info endpoint
  version-check.js       # Update check endpoint
```

## Data Files (`/public`)

```
/public/
  panels.json            # Panel specifications
  pricing.json           # Pricing packages
  contact.json           # Contact information
  version-check.json     # Version metadata
```

## Naming Conventions

- **Files**: snake_case (e.g., `panel_card.dart`, `api_service.dart`)
- **Classes**: PascalCase (e.g., `PanelModel`, `ApiService`)
- **Variables**: camelCase (e.g., `panelData`, `hasInternet`)
- **Constants**: camelCase with `const` or `final` (e.g., `baseUrl`)
- **Private members**: prefix with underscore (e.g., `_dio`, `_checkForUpdates`)

## Code Organization Rules

1. **Models**: Include `fromJson()` and `toJson()` methods for API serialization
2. **Services**: Singleton pattern or stateless utility classes
3. **Screens**: StatefulWidget for interactive screens, StatelessWidget for static
4. **Widgets**: Prefer StatelessWidget, use `const` constructors when possible
5. **API calls**: Handle offline mode gracefully, return empty data on error
6. **Comments**: Use Uzbek for user-facing text, English for technical comments
