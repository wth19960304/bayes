import 'package:cached_network_image/cached_network_image.dart';
import 'package:erp_music/base/base_inner_widget.dart';
import 'package:erp_music/base/base_widget.dart';
import 'package:erp_music/bean/CourseMangeModel.dart';
import 'package:erp_music/constant/font.dart';
import 'package:erp_music/constant/index_constant.dart';
import 'package:erp_music/ui/video/VideoPage.dart';
import 'package:erp_music/ui/video/VideoPage2.dart';
import 'package:erp_music/utils/screen_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widget/image_loading.dart';

//单个相关知识点
class OtherVideoItem extends StatelessWidget {
  String name;
  String time;
  String state;
  int index;
  int id;
  int videoId;
  int xiaoBiao;
  bool isVideo;
  Function itemClick;

  OtherVideoItem(
      {this.name,
      this.index = 0,
      this.time = "",
      this.state = "0",
      this.id,
      this.xiaoBiao = 0,
      this.isVideo = false,
      this.videoId,
      this.itemClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.screenWidth,
      height: ScreenUtil().L(50),
      padding: EdgeInsets.only(left: ScreenUtil().L(15)),
      child: InkWell(
        onTap: () {
          if (itemClick != null) {
            itemClick();
            return;
          }
          if (isVideo) {
            Navigator.of(context).push(CupertinoPageRoute(builder: (_) => VideoPage(id: id)));
          } else {
            Navigator.of(context).push(CupertinoPageRoute(builder: (_) => VideoPage2(id: id, videoId: videoId)));
          }
        },
        child: Row(
          children: <Widget>[
            _leftLine(),
            _rightWidget(),
          ],
        ),
      ),
    );
  }

  _leftLine() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: ScreenUtil().L(20),
          width: ScreenUtil().L(0.5),
          color: KColorConstant.lineColor,
        ),
        Container(
          height: ScreenUtil().L(10),
          width: ScreenUtil().L(10),
          decoration: KBoxStyle.btnYuanBgcolor(),
        ),
        Container(
          height: ScreenUtil().L(20),
          width: ScreenUtil().L(0.5),
          color: KColorConstant.lineColor,
        ),
      ],
    );
  }

  _rightWidget() {
    return Column(
      children: <Widget>[
        Container(
          height: ScreenUtil().L(49.5),
          width: ScreenUtil.screenWidth - ScreenUtil().L(80),
          margin: EdgeInsets.only(left: ScreenUtil().L(10)),
          child: Row(
            children: <Widget>[
              Text(
                "视频${index + 1}",
                style: KFontConstant.grayText_small(),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: ScreenUtil().L(10)),
                  child: Text(
                    "$name",
                    style: KFontConstant.defaultText_bold(),
                  ),
                ),
              ),
              Text(
                "$time",
                style: KFontConstant.grayText_small(),
              ),
            ],
          ),
        ),
        Container(
          width: ScreenUtil.screenWidth - ScreenUtil().L(80),
          height: ScreenUtil().L(0.5),
          color: KColorConstant.lineColor,
        ),
      ],
    );
  }
}
