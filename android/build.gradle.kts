allprojects {
    repositories {
        // 腾讯云镜像（新增）
        maven { url = uri("https://mirrors.cloud.tencent.com/nexus/repository/maven-public/") }
        // 华为云（首推）
        maven { url = uri("https://mirrors.huaweicloud.com/repository/maven/") }
        // 清华大学源（次选）
        maven { url = uri("https://mirrors.tuna.tsinghua.edu.cn/nexus/content/repositories/maven-central/") }
        // 阿里云（备用）
        maven { url = uri("https://maven.aliyun.com/repository/public") }
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

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
