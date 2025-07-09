pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.PREFER_SETTINGS)
    repositories {
        // 腾讯云镜像（新增）
        maven { url "https://mirrors.cloud.tencent.com/nexus/repository/maven-public/" }
        // 华为云（首推）
        maven { url "https://mirrors.huaweicloud.com/repository/maven/" }
        // 清华大学源（次选）
        maven { url "https://mirrors.tuna.tsinghua.edu.cn/nexus/content/repositories/maven-central/" }
        // 阿里云（备用）
        maven { url "https://maven.aliyun.com/repository/public" }
        // 其他镜像或官方仓库
         google()
         mavenCentral()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.7.3" apply false
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false
}

include(":app")
