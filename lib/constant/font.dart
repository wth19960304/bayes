import 'package:bayes/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'color.dart';

class KFontConstant {
  ///系统主色字体样式
  static TextStyle myTextStyle({
    int size = 12,
    bool bold = false,
    Color color = KColorConstant.themeColor,
  }) {
    return TextStyle(
      fontSize: ScreenUtil.setSp(size, false),
      color: color,
      letterSpacing: 0.3, //字间距
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
  }

  //--------------------------超大号字体--------------------------------------
  ///Appbar标题
  static TextStyle appBarTiltleBigBold() {
    return TextStyle(
      fontSize: ScreenUtil.setSp(18, false),
      color: Colors.black,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.3, //字间距
    );
  }

  ///超大号字体-系统主色-加粗
  static TextStyle themTitleBigBold() {
    return TextStyle(
      fontSize: ScreenUtil.setSp(16, false),
      color: KColorConstant.themeColor,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.3, //字间距
    );
  }

  ///超大号字体-黑色
  static TextStyle blackBigBigText() {
    return TextStyle(
      fontSize: ScreenUtil.setSp(22, false),
      color: Colors.black,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.3, //字间距
    );
  }

  ///超大号字体-数字-红色
  static TextStyle themNumBig() {
    return TextStyle(
      fontSize: ScreenUtil.setSp(18, false),
      color: KColorConstant.themeColor,
      letterSpacing: 0.3, //字间距
    );
  }

  //--------------------------标准字体----------------------------------
  ///标准字体-黑色-不加粗
  static TextStyle defaultText() {
    return TextStyle(
      fontSize: ScreenUtil.setSp(14, false),
      color: Colors.black,
      letterSpacing: 0.3, //字间距
    );
  }

  ///标准字体-黑色-加粗
  static TextStyle defaultTextBold() {
    return TextStyle(
      fontSize: ScreenUtil.setSp(14, false),
      color: Colors.black,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.3, //字间距
    );
  }

  ///标准字体-系统主色调
  static TextStyle themeText() {
    return TextStyle(
      fontSize: ScreenUtil.setSp(14, false),
      color: KColorConstant.themeColor,
      letterSpacing: 0.3, //字间距
    );
  }

  ///标准字体-系统主色调-加粗
  static TextStyle redTextBold() {
    return TextStyle(
      fontSize: ScreenUtil.setSp(14, false),
      color: KColorConstant.redColor,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.3, //字间距
    );
  }

  ///标准字体-灰色
  static TextStyle grayText() {
    return TextStyle(
      fontSize: ScreenUtil.setSp(14, false),
      color: KColorConstant.greyColor,
      letterSpacing: 0.3, //字间距
    );
  }

  ///标准字体-灰色
  static TextStyle grayTextSmall() {
    return TextStyle(
      fontSize: ScreenUtil.setSp(12, false),
      color: KColorConstant.greyColor,
      letterSpacing: 0.3, //字间距
    );
  }

  ///标准字体-白色
  static TextStyle whiteText() {
    return TextStyle(
      fontSize: ScreenUtil.setSp(14, false),
      color: KColorConstant.white,
      letterSpacing: 0.3, //字间距
    );
  }

  ///标准字体-白色-加粗
  static TextStyle whiteTextBold() {
    return TextStyle(
      fontSize: ScreenUtil.setSp(14, false),
      color: KColorConstant.white,
      letterSpacing: 0.3, //字间距
    );
  }

  ///标准字体-绿色
  static TextStyle lvseText() {
    return TextStyle(
      fontSize: ScreenUtil.setSp(14, false),
      color: KColorConstant.lvseColor,
      letterSpacing: 0.3, //字间距
    );
  }

  //--------------------------小号字体----------------------------------

  ///小号字体-灰色色
  static TextStyle greyTextSmall() {
    return TextStyle(
      fontSize: ScreenUtil.setSp(12, false),
      color: KColorConstant.greyColor,
      letterSpacing: 0.3, //字间距
    );
  }

  //--------------------------大号字体----------------------------------
  ///大号字体-黑色
  static TextStyle blackTextBig() {
    return TextStyle(
      fontSize: ScreenUtil.setSp(16, false),
      color: Colors.black,
      letterSpacing: 0.3, //字间距
    );
  }

  ///大号字体-黑色-加粗
  static TextStyle blackTextBigBold() {
    return TextStyle(
      fontSize: ScreenUtil.setSp(16, false),
      color: Colors.black,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.3, //字间距
    );
  }

  ///大号字体-红色
  static TextStyle redTextBig() {
    return TextStyle(
      fontSize: ScreenUtil.setSp(16, false),
      color: KColorConstant.themeColor,
      letterSpacing: 0.3, //字间距
    );
  }

  ///大号字体-红色-加粗
  static TextStyle redTextBigBold() {
    return TextStyle(
      fontSize: ScreenUtil.setSp(16, false),
      color: KColorConstant.themeColor,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.3, //字间距
    );
  }

  ///大号字体-白色
  static TextStyle whiteTextBig() {
    return TextStyle(
      fontSize: ScreenUtil.setSp(16, false),
      color: KColorConstant.appBgColor,
      letterSpacing: 0.3, //字间距
    );
  }

  ///大号字体-灰色
  static TextStyle greyTextBig() {
    return TextStyle(
      fontSize: ScreenUtil.setSp(16, false),
      color: KColorConstant.greyColor,
      letterSpacing: 0.3, //字间距
    );
  }
}
