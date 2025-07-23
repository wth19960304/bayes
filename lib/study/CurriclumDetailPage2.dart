import 'package:cached_network_image/cached_network_image.dart';
import 'package:erp_music/bean/CourseMangeModel.dart';
import 'package:erp_music/constant/font.dart';
import 'package:erp_music/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

import '../../widget/image_loading.dart';
import 'CurriculumVideoItem.dart';

//课程介绍
class CurriclumDetailPage2 extends StatelessWidget {
  String contentString;

  CurriclumDetailPage2({String content}) {
    this.contentString = content;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(ScreenUtil().L(15)),
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        child: Text(
          "$contentString",
          style: KFontConstant.blackTextBig(),
        ),
      ),
    );
  }
}
