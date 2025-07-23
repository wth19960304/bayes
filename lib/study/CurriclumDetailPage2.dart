import 'package:bayes/constant/font.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:flutter/material.dart';

//课程介绍
// ignore: must_be_immutable
class CurriclumDetailPage2 extends StatelessWidget {
  String? contentString;

  CurriclumDetailPage2({super.key, this.contentString});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(ScreenUtil.L(15)),
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        child: Text("$contentString", style: KFontConstant.blackTextBig()),
      ),
    );
  }
}
