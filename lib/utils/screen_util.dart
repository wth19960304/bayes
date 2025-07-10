import 'package:flutter/material.dart';

/// 屏幕适配工具类
class ScreenUtil {
  /// 静态实例
  static final ScreenUtil _instance = ScreenUtil._internal();

  /// 私有构造函数，防止外部实例化
  ScreenUtil._internal();

  /// 设计稿的设备宽度
  final int _designWidth = 0;

  /// 设计稿的设备高度
  final int _designHeight = 0;

  /// 屏幕信息
  static MediaQueryData? _mediaQueryData;

  /// 屏幕宽度（px）
  static double? _screenWidth;

  /// 屏幕高度（px）
  static double? _screenHeight;

  /// 像素密度
  static double? _pixelRatio;

  /// 状态栏高度
  static double? _statusBarHeight;

  /// 底部安全区高度
  static double? _bottomBarHeight;

  /// 文字缩放因子
  static double? _textScaleFactor;

  /// 获取静态实例
  static ScreenUtil get instance => _instance;

  /// 初始化屏幕适配工具
  void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _mediaQueryData = mediaQuery;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = mediaQuery.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  /// 获取屏幕信息
  static MediaQueryData? get mediaQueryData => _mediaQueryData;

  /// 获取文字缩放因子
  static double? get textScaleFactor => _textScaleFactor;

  /// 获取像素密度
  static double? get pixelRatio => _pixelRatio;

  /// 获取屏幕宽度（dp）
  static double? get screenWidthDp => _screenWidth;

  /// 获取屏幕高度（dp）
  static double? get screenHeightDp => _screenHeight;

  /// 获取屏幕宽度（px）
  static double? get screenWidth => _screenWidth;

  /// 获取屏幕高度（px）
  static double? get screenHeight => _screenHeight;

  /// 获取状态栏高度
  static double? get statusBarHeight => _statusBarHeight;

  /// 获取底部安全区高度
  static double? get bottomBarHeight => _bottomBarHeight;

  /// 计算宽度适配比例
  double get scaleWidth => _screenWidth! / _designWidth;

  /// 计算高度适配比例
  double get scaleHeight => _screenHeight! / _designHeight;

  /// 根据设计稿宽度进行适配
  double setWidth(int width) => width * scaleWidth;

  /// 根据设计稿宽度进行适配（别名）
  double L(double width) => width * scaleWidth;

  /// 根据设计稿高度进行适配
  double setHeight(int height) => height * scaleHeight;

  /// 字体大小适配
  /// [fontSize] 设计稿上的字体大小（px）
  /// [allowFontScaling] 是否允许根据系统字体大小设置进行缩放，默认为 true
  double setSp(int fontSize, [bool allowFontScaling = true]) {
    double scaledSize = setWidth(fontSize);
    if (allowFontScaling) {
      scaledSize *= _textScaleFactor!;
    }
    return scaledSize;
  }
}
