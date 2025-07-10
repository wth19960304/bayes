import 'package:bayes/constant/color.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:flutter/material.dart';

class KBoxStyle {
  //线框样式
  static BoxDecoration lineRadio({
    Color lineColor = KColorConstant.themeColor,
    Color bgColor = Colors.transparent,
    double radiusSize = 10,
  }) {
    return BoxDecoration(
      border: Border.all(color: lineColor, width: 1.0),
      color: bgColor,
      borderRadius: BorderRadius.circular(ScreenUtil.L(radiusSize)),
    );
  }

  ///
  static BoxDecoration shadowStyle() {
    return BoxDecoration(
      border: Border.all(color: KColorConstant.white, width: 0.0),
      color: KColorConstant.white,
      borderRadius: BorderRadius.circular(ScreenUtil.L(7)),
    );
  }

  static BoxDecoration loginInputBg() {
    return BoxDecoration(
      border: Border.all(color: KColorConstant.white, width: 0.0),
      borderRadius: BorderRadius.circular(ScreenUtil.L(7)),
      color: KColorConstant.loginInputColor,
    );
  }

  /// 下一步蓝色按钮
  static BoxDecoration nextBtn() {
    return BoxDecoration(
      border: Border.all(color: KColorConstant.themeColor, width: 0.0),
      borderRadius: BorderRadius.circular(ScreenUtil.L(50)),
      color: KColorConstant.themeColor,
    );
  }

  /// 下一步蓝色按钮
  static BoxDecoration nextBtnGray() {
    return BoxDecoration(
      border: Border.all(color: KColorConstant.hintTextColor, width: 0.0),
      borderRadius: BorderRadius.circular(ScreenUtil.L(50)),
      color: KColorConstant.hintTextColor,
    );
  }

  /// 圆点
  static BoxDecoration radioBg() {
    return BoxDecoration(
      border: Border.all(color: KColorConstant.redColor, width: 0.0),
      borderRadius: BorderRadius.circular(ScreenUtil.L(50)),
      color: KColorConstant.redColor,
    );
  }

  ///带阴影的topbar背景-背景色
  static BoxDecoration bottomShadowBg() {
    return BoxDecoration(
      color: KColorConstant.white,
      boxShadow: [
        BoxShadow(
          color: KColorConstant.shadowColor,
          offset: Offset(0.0, -2.5),
          blurRadius: 0.0,
          spreadRadius: 0.0,
        ),
      ],
    );
  }

  ///全圆角-背景色
  static BoxDecoration btnYuanBgcolor() {
    return BoxDecoration(
      border: Border.all(color: KColorConstant.searchBarBgColor, width: 0.8),
      borderRadius: BorderRadius.circular(10.0),
      color: KColorConstant.white,
    );
  }

  ///评论回复背景框
  static BoxDecoration pinglunBgcolor() {
    return BoxDecoration(
      border: Border.all(color: KColorConstant.appBgColor, width: 0.8),
      borderRadius: BorderRadius.circular(8.0),
      color: KColorConstant.appBgColor,
    );
  }

  ///评论回复背景框
  static BoxDecoration grayBgStyle() {
    return BoxDecoration(
      border: Border.all(color: KColorConstant.appBgColor, width: 0.8),
      borderRadius: BorderRadius.circular(8.0),
      color: KColorConstant.searchBarBgColor,
    );
  }

  static BoxDecoration whiteItemStyle() {
    return BoxDecoration(
      border: Border.all(color: KColorConstant.white, width: 0.0),
      borderRadius: BorderRadius.circular(ScreenUtil.L(7)),
      color: KColorConstant.white,
    );
  }

  ///圆角4，浅绿色
  static BoxDecoration lvseRound4Bg() {
    return BoxDecoration(
      border: Border.all(color: KColorConstant.lvseColorTr50, width: 0.0),
      borderRadius: BorderRadius.circular(ScreenUtil.L(4)),
      color: KColorConstant.lvseColorTr50,
    );
  }

  ///圆角4，浅橘色
  static BoxDecoration orangeRound4Bg() {
    return BoxDecoration(
      border: Border.all(color: KColorConstant.orangeColorTr50, width: 0.0),
      borderRadius: BorderRadius.circular(ScreenUtil.L(4)),
      color: KColorConstant.orangeColorTr50,
    );
  }

  ///圆角4，浅蓝色
  static BoxDecoration blueRound4Bg() {
    return BoxDecoration(
      border: Border.all(color: KColorConstant.blueColorTr50, width: 0.0),
      borderRadius: BorderRadius.circular(ScreenUtil.L(4)),
      color: KColorConstant.blueColorTr50,
    );
  }

  ///带下划线的样式，背景为白色
  static BoxDecoration bottomLineStyle() {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(color: KColorConstant.lineColor, width: 0.6),
      ),
      color: KColorConstant.white,
    );
  }

  static BoxDecoration selectTrue() {
    return BoxDecoration(
      border: Border.all(color: Color(0xFF04B0FA), width: 0.0),
      borderRadius: BorderRadius.circular(ScreenUtil.L(50)),
      color: Color(0xFF04B0FA),
    );
  }

  static BoxDecoration selectFalse() {
    return BoxDecoration(
      border: Border.all(color: Color(0xFFF0F0F0), width: 0.0),
      borderRadius: BorderRadius.circular(ScreenUtil.L(50)),
      color: Color(0xFFF0F0F0),
    );
  }
}
