import 'package:bayes/bean/StudyHomeBean.dart';
import 'package:bayes/pages/CurriclumDetailPage.dart';
import 'package:bayes/pages/VideoPage.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import '../../widget/image_loading.dart';

//轮播
// ignore: must_be_immutable
class SwiperWidget extends StatelessWidget {
  List<BannerManageList>? images;

  SwiperWidget({super.key, this.images});

  @override
  Widget build(BuildContext context) {
    if (images == null || images!.isEmpty) {
      return Container();
    }
    return SizedBox(
      height: ScreenUtil.L(150),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              if (images?[index].type == "跳转到视频") {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (_) => VideoPage(
                      id: int.parse(images![index].bounce!.id ?? ''),
                    ),
                  ),
                );
              } else if (images?[index].type == "跳转到课程") {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (_) => CurriculumDetailPage(
                      id: int.parse(images![index].bounce!.id ?? ''),
                    ),
                  ),
                );
              }
            },
            child: Container(
              margin: EdgeInsets.only(
                left: ScreenUtil.L(10),
                right: ScreenUtil.L(10),
                top: ScreenUtil.L(5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(ScreenUtil.L(7)),
                ),
                child: CachedNetworkImage(
                  imageUrl: "${images?[index].img?[0].url}",
                  placeholder: (context, url) => ImageLoadingPage(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ); //添加图片并设置图片样式
        },
        itemCount: images != null ? images?.length ?? 0 : 0,
        pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(
            right: ScreenUtil.L(20),
            bottom: ScreenUtil.L(10),
          ),
        ),
        //显示的点
        indicatorLayout: PageIndicatorLayout.SCALE,
        autoplay: true, //是否循环
      ),
    );
  }
}
