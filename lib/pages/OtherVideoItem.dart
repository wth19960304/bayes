import 'package:bayes/constant/color.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/constant/style.dart';
import 'package:bayes/pages/VideoPage.dart';
import 'package:bayes/pages/VideoPage2.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widget/image_loading.dart';

//单个相关知识点
// ignore: must_be_immutable
class OtherVideoItem extends StatelessWidget {
  String? name;
  String? time;
  String? state;
  int? index;
  int? id;
  int? videoId;
  int? xiaoBiao;
  bool? isVideo;
  Function? itemClick;

  OtherVideoItem({
    super.key,
    this.name,
    this.index = 0,
    this.time = "",
    this.state = "0",
    this.id,
    this.xiaoBiao = 0,
    this.isVideo = false,
    this.videoId,
    this.itemClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.screenWidth,
      height: ScreenUtil.L(50),
      padding: EdgeInsets.only(left: ScreenUtil.L(15)),
      child: InkWell(
        onTap: () {
          if (itemClick != null) {
            itemClick!();
            return;
          }
          if (isVideo ?? false) {
            Navigator.of(
              context,
            ).push(CupertinoPageRoute(builder: (_) => VideoPage(id: id)));
          } else {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (_) => VideoPage2(id: id, videoId: videoId),
              ),
            );
          }
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
          width: ScreenUtil.screenWidth! - ScreenUtil.L(80),
          margin: EdgeInsets.only(left: ScreenUtil.L(10)),
          child: Row(
            children: <Widget>[
              Text("视频${index! + 1}", style: KFontConstant.grayTextSmall()),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: ScreenUtil.L(10)),
                  child: Text("$name", style: KFontConstant.defaultTextBold()),
                ),
              ),
              Text("$time", style: KFontConstant.grayTextSmall()),
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
