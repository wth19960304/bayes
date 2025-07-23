import 'package:bayes/bean/CourseMangeModel.dart';
import 'package:bayes/constant/color.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/constant/style.dart';
import 'package:bayes/pages/VideoPage2.dart';
import 'package:bayes/utils/screen_util.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//课程列表Item
// ignore: must_be_immutable
class CurriculumVideoItem extends StatelessWidget {
  CourseVideos? data;
  int? index;
  int? id;
  String? time;

  // ignore: use_key_in_widget_constructors
  CurriculumVideoItem({this.id, this.data, this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.screenWidth,
      padding: EdgeInsets.only(left: ScreenUtil.L(15)),
      child: InkWell(
        onTap: () {
          //前往课程视频播放界面
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (_) => VideoPage2(id: id, videoId: data?.id),
            ),
          );
        },
        child: Row(children: <Widget>[_leftLine(), _rightWidget()]),
      ),
    );
  }

  _leftLine() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: ScreenUtil.L(20),
          width: ScreenUtil.L(0.5),
          color: KColorConstant.lineColor,
        ),
        Container(
          height: ScreenUtil.L(10),
          width: ScreenUtil.L(10),
          decoration: KBoxStyle.btnYuanBgcolor(),
        ),
        Container(
          height: ScreenUtil.L(20),
          width: ScreenUtil.L(0.5),
          color: KColorConstant.lineColor,
        ),
      ],
    );
  }

  _rightWidget() {
    return Column(
      children: <Widget>[
        Container(
          height: ScreenUtil.L(49.5),
          width: ScreenUtil.screenWidth! - ScreenUtil.L(95),
          margin: EdgeInsets.only(left: ScreenUtil.L(10)),
          child: Row(
            children: <Widget>[
              Text("课程${index! + 1}", style: KFontConstant.grayTextSmall()),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: ScreenUtil.L(10)),
                  child: Text(
                    "${data?.name}",
                    style: KFontConstant.defaultTextBold(),
                  ),
                ),
              ),
              //              Container(
              //                margin: EdgeInsets.only(
              //                    left: ScreenUtil.L(10), right: ScreenUtil.L(10)),
              //                decoration: KBoxStyle.orangeRound4Bg(),
              //                padding: EdgeInsets.all(ScreenUtil.L(3)),
              //                child: Text(
              //                  "已学习",
              //                  style: KFontConstant.grayText_small(),
              //                ),
              //              ),
              Text("${data?.time}", style: KFontConstant.grayTextSmall()),
            ],
          ),
        ),
        Container(
          width: ScreenUtil.screenWidth! - ScreenUtil.L(80),
          height: ScreenUtil.L(0.5),
          color: KColorConstant.lineColor,
        ),
      ],
    );
  }
}
