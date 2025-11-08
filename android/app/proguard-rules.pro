# JAHON GROUP - Quyosh24 APK
# Litsenziya: © 2025 JAHON GROUP
# Xavfsizlik: Verified Safe Application

# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# JAHON GROUP specific
-keep class com.jahongroup.quyosh24.** { *; }

# WebView
-keep class android.webkit.** { *; }

# Network security
-keep class javax.net.ssl.** { *; }
-keep class org.apache.http.** { *; }

# Prevent obfuscation of license info
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes InnerClasses