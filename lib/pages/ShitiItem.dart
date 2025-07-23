import 'package:cached_network_image/cached_network_image.dart';
import 'package:erp_music/bean/TestHomeBean.dart';
import 'package:erp_music/constant/font.dart';
import 'package:erp_music/constant/index_constant.dart';
import 'package:erp_music/utils/screen_util.dart';
import 'package:flutter/material.dart';
import '../../widget/image_loading.dart';

//课程列表Item
class ShitiItem extends StatelessWidget {
  TestManageList data;

  ShitiItem({TestManageList data}) {
    this.data = data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: KBoxStyle.WhiteItemStyle(),
      margin: EdgeInsets.only(
          left: ScreenUtil().L(10),
          right: ScreenUtil().L(10),
          bottom: ScreenUtil().L(10)),
      padding: EdgeInsets.all(ScreenUtil().L(7)),
      child: _rightWidget(),
    );
  }

  Widget _rightWidget() {
    List<Widget> widgets = new List();
    List<BoxDecoration> des = [
      KBoxStyle.lvseRound4Bg(),
      KBoxStyle.orangeRound4Bg(),
      KBoxStyle.blueRound4Bg()
    ];

    for (int i = 0; i < data.testLabel.length; i++) {
      widgets.add(Container(
        margin: EdgeInsets.only(right: ScreenUtil().L(10)),
        padding: EdgeInsets.all(ScreenUtil().L(2)),
        child: Text("${data.testLabel[i].name}"),
        decoration: des[i % 3],
      ));
    }
    return Container(
      height: ScreenUtil().L(55),
      margin: EdgeInsets.all(ScreenUtil().L(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              "${data.testTopic}",
              maxLines: 2,
              style: KFontConstant.blackTextBig(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: widgets,
              ),
              Text("正确率：${data.correctRate}%"),
            ],
          )
        ],
      ),
    );
  }
}
