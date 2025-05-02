# Flutter ProGuard configuration for newspaper_app

# Keep entry point of the app
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.common.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class androidx.annotation.** { *; }
-keep class androidx.core.** { *; }
-keep class androidx.lifecycle.** { *; }
-keep class androidx.savedstate.** { *; }
-keep class android.support.** { *; }
-keep class android.webkit.** { *; }
-keep class com.google.android.gms.** { *; }
-keep class com.google.firebase.** { *; }
-keep class com.squareup.okhttp.** { *; }
-keep class com.squareup.okio.** { *; }
-keep class javax.inject.** { *; }

# Keep native method names
-keepnames class * {
    native <methods>;
}

# Keep classes that are only referenced via reflection
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

-keepattributes *Annotation*
-keepattributes EnclosingMethod
-keepattributes InnerClasses
-keepattributes Signature
-keepattributes SourceFile, LineNumberTable

# Keep the generated Dart entry point
-keep class com.example.newspaper_app.MainActivity
-keep class com.example.newspaper_app.FlutterMainApplication

# Keep other potential entry points (adjust if your package name is different)
-keep class **.MainActivity
-keep class **.FlutterMainApplication

# Keep the R class and its inner classes (for resources)
-keep class **.R
-keep class **.R$* {
    public static <fields>;
}

# If you are using Hive, you might need to keep your generated adapters
-keep class *.g.dart { *; }
-keep @com.hive.annotations.* class * { *; }
-keep class **Adapter { *; }
-keepnames class * {
    @com.hive.annotations.* <fields>;
}

# If you are using GetX, you might need to keep some classes
-keep class get.** { *; }
