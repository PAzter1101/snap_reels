# media_kit (libmpv via JNI): R8 must not rename Java classes that
# libmpv looks up via FindClass from native code. Without this rule
# release builds shipped through Play Store stall video playback
# after ~1-2 seconds.
-keep class com.alexmercerind.** { *; }
-dontwarn com.alexmercerind.**

# Native methods used by libmpv must keep their names and signatures.
-keepclasseswithmembernames class * {
    native <methods>;
}

# Classes annotated with @Keep are referenced from native code.
-keep @androidx.annotation.Keep class * { *; }
-keepclassmembers class * {
    @androidx.annotation.Keep *;
}
