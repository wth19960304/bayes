import 'package:cached_network_image/cached_network_image.dart';
import 'package:erp_music/bean/CourseMangeModel.dart';
import 'package:erp_music/constant/font.dart';
import 'package:erp_music/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

import '../../widget/image_loading.dart';
import 'CurriculumVideoItem.dart';

//讲师介绍
class CurriclumDetailPage3 extends StatelessWidget {
  String contentString;
  String header;
  String lectorProfile;
  String name;

  CurriclumDetailPage3({String content, String header, String lectorProfile, String name}) {
    this.contentString = content;
    this.header = header;
    this.lectorProfile = lectorProfile;
    this.name = name;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: ScreenUtil().L(15), right: ScreenUtil().L(15)),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _topWidget(),
            _contentWidget(),
          ],
        ),
      ),
    );
  }

  ///顶部布局
  _topWidget() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().L(20), right: ScreenUtil().L(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().L(7))),
                    child: CachedNetworkImage(
                      imageUrl: "$header",
                      placeholder: (context, url) => ImageLoadingPage(
                        width: 20.0,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        "images/header_defalut.png",
                        width: ScreenUtil().L(35),
                        height: ScreenUtil().L(35),
                      ),
                      fit: BoxFit.fitHeight,
                    )),
                margin: EdgeInsets.only(
                  left: ScreenUtil().L(10),
                  right: ScreenUtil().L(8),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "$name",
                    style: KFontConstant.blackTextBig_bold(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///内容布局
  _contentWidget() {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(left: ScreenUtil().L(15), top: ScreenUtil().L(15), right: ScreenUtil().L(15)),
      child: Text(
        "讲师详情：$contentString",
        style: KFontConstant.blackTextBig(),
      ),
    );
  }
}
