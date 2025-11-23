plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.latihan_responsi"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // PERBAIKAN 1 & 3 (JavaVersion harus dipanggil dengan fungsi set)
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
        
        // Tambahkan baris ini untuk mengaktifkan desugaring
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        // PERBAIKAN 2 (Ganti VERSION_11 menjadi VERSION_1_8 agar konsisten dengan compileOptions)
        jvmTarget = JavaVersion.VERSION_1_8.toString()
    }

    defaultConfig {
        applicationId = "com.example.latihan_responsi"
        minSdk = flutter.minSdkVersion
        targetSdk = 33
        versionCode = flutter.versionCode as Int // Pastikan tipe data benar
        versionName = flutter.versionName as String // Pastikan tipe data benar
        
        // PERBAIKAN 4 (Untuk boolean di Kotlin DSL gunakan sintaks assignment)
        multiDexEnabled = true 
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // PERBAIKAN 5, 6, & 7 (Menggunakan function call "coreLibraryDesugaring" untuk dependencies)
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}