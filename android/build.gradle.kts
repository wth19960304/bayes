allprojects {
    repositories {
        google()
        mavenCentral()
    }
}



val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}


subprojects {
    beforeEvaluate {
        if (plugins.hasPlugin("com.android.library")) {
            extensions.configure<com.android.build.gradle.LibraryExtension> {
                namespace = when (name) {
                    "flutter_native_image" -> "com.example.flutternativeimage"
                    "fijkplayer_update" -> "com.example.fijkplayerupdate"
                    else -> namespace
                }
            }
        }
    }
}


configurations.all {
    resolutionStrategy {
        force("io.flutter:flutter_embedding_debug:1.0.0")
    }
}



tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
