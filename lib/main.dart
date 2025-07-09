/*
 * 文件名称：main.dart
 * 功能描述：应用主入口文件，负责初始化全局配置和启动Flutter应用
 * 核心功能：
 *   1. 设置Android平台沉浸式状态栏
 *   2. 初始化本地存储(SharedPreferences)
 *   3. 构建MaterialApp基础框架
 *   4. 处理异步初始化期间的加载状态
 * 注意事项：
 *   - 状态栏设置需区分平台(仅Android生效)
 *   - 必须等待SpUtils初始化完成才能构建UI
 *   - 主题配置使用项目自定义颜色常量(KColorConstant)
 * 作者：wangtianhao
 * 创建日期：2025-07-09
 * 最后修改：2025-07-09
 */

import 'dart:io'; // 平台判断功能

// 项目资源引入
import 'package:bayes/constant/color.dart'; // 颜色常量定义
import 'package:bayes/utils/sp_utils.dart'; // 本地存储工具类
import 'package:flutter/material.dart'; // Material组件库
import 'package:flutter/services.dart'; // 系统UI控制

/// 应用启动入口函数
void main() {
  // 启动Flutter应用，根组件为MyApp
  runApp(MyApp());
}

/// 应用根组件（无状态组件）
class MyApp extends StatelessWidget {
  /// 构造函数中处理平台相关初始化
  MyApp({super.key}) {
    /* 
     * Android平台专属设置：
     * 设置透明状态栏实现沉浸式效果
     * 注意：必须在build方法外设置，避免被MaterialApp默认样式覆盖
     */
    if (Platform.isAndroid) {
      final systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // 透明状态栏
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  @override
  Widget build(BuildContext context) {
    /* 
     * 使用FutureBuilder处理异步初始化：
     * 1. 等待SpUtils完成SharedPreferences初始化
     * 2. 根据连接状态显示不同UI：
     *    - 未完成时：显示圆形进度指示器
     *    - 已完成时：构建主应用框架
     */
    return FutureBuilder(
      future: SpUtils().init(), // 初始化本地存储
      builder: (context, snapshot) {
        // 检查初始化状态
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(), // 加载中动画
          );
        }

        /* 
         * 主应用框架构建：
         * 1. 通过AnnotatedRegion强制设置系统UI样式
         * 2. MaterialApp作为应用容器
         */
        return AnnotatedRegion<SystemUiOverlayStyle>(
          // 强制深色状态栏图标（适配浅色背景）
          value: SystemUiOverlayStyle.dark,
          child: MaterialApp(
            title: '贝叶斯', // 应用名称（用于任务管理器显示）
            debugShowCheckedModeBanner: false, // 禁用调试横幅
            theme: ThemeData(
              brightness: Brightness.light, // 亮色主题
              scaffoldBackgroundColor: KColorConstant.white, // 使用项目白色常量
              platform: TargetPlatform.iOS, // 统一使用iOS风格组件
            ),
            home: Text("我是首页1111"), // 临时首页占位（实际应为SplashPage）
          ),
        );
      },
    );
  }
}
