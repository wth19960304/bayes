import 'package:cached_network_image/cached_network_image.dart';
import 'package:erp_music/bean/CourseMangeModel.dart';
import 'package:erp_music/constant/font.dart';
import 'package:erp_music/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../widget/image_loading.dart';
import 'CurriculumVideoItem.dart';

//视频列表
class CurriclumDetailPage1 extends StatelessWidget {
  List<CourseVideos> courseVideos;
  int? id;

  CurriclumDetailPage1({super.key, this.courseVideos, this.id});

  @override
  Widget build(BuildContext context) {
    if (courseVideos.isEmpty) {
      return Container(
        padding: EdgeInsets.all(ScreenUtil().L(30)),
        margin: EdgeInsets.only(top: ScreenUtil().L(30)),
        child: Text("当前课程正在上新中，先去学习其它课程吧~", style: KFontConstant.grayText()),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.only(top: 0, bottom: ScreenUtil().L(30)),
      itemCount: courseVideos.length,
      itemBuilder: (BuildContext context, int index) {
        return CurriculumVideoItem(
          id: id,
          data: courseVideos[index],
          index: index,
        );
      },
    );
  }
}
