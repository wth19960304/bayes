import 'package:bayes/bean/TestHomeBean.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/constant/style.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:flutter/material.dart';

//课程列表Item
// ignore: must_be_immutable
class ShitiItem extends StatelessWidget {
  TestManageList? data;
  Widget _rightWidget() {
    List<Widget> widgets = [];
    List<BoxDecoration> des = [
      KBoxStyle.lvseRound4Bg(),
      KBoxStyle.orangeRound4Bg(),
      KBoxStyle.blueRound4Bg(),
    ];

    for (int i = 0; i < (data?.testLabel!.length ?? 0); i++) {
      widgets.add(
        Container(
          margin: EdgeInsets.only(right: ScreenUtil.L(10)),
          padding: EdgeInsets.all(ScreenUtil.L(2)),
          // ignore: sort_child_properties_last
          child: Text("${data!.testLabel?[i].name}"),
          decoration: des[i % 3],
        ),
      );
    }
    return Container(
      height: ScreenUtil.L(55),
      margin: EdgeInsets.all(ScreenUtil.L(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${data?.testTopic}",
            maxLines: 2,
            style: KFontConstant.blackTextBig(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: widgets),
              Text("正确率：${data?.correctRate}%"),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: KBoxStyle.whiteItemStyle(),
      margin: EdgeInsets.only(
        left: ScreenUtil.L(10),
        right: ScreenUtil.L(10),
        bottom: ScreenUtil.L(10),
      ),
      padding: EdgeInsets.all(ScreenUtil.L(7)),
      child: _rightWidget(),
    );
  }

  ShitiItem({super.key, this.data});
}
