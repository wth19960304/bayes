//省市区item

import 'package:bayes/constant/color.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CityItem extends StatelessWidget {
  bool isSelect;
  String? name;

  CityItem({super.key, this.isSelect = false, this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.L(55),
      color: isSelect ? KColorConstant.appBgColor : Colors.white,
      child: Stack(
        children: <Widget>[
          Offstage(
            offstage: !isSelect,
            child: Container(
              height: ScreenUtil.L(55),
              color: KColorConstant.redColor,
              width: ScreenUtil.L(2),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: ScreenUtil.L(20)),
            child: Text(
              "$name",
              style: KFontConstant.myTextStyle(
                color: isSelect ? KColorConstant.redColor : Colors.black,
              ),
            ),
          ),
          Container(height: ScreenUtil.L(0.5), color: KColorConstant.lineColor),
        ],
      ),
    );
  }
}
