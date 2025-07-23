import 'package:cached_network_image/cached_network_image.dart';
import 'package:erp_music/bean/CourseMangeModel.dart';
import 'package:erp_music/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

import '../../widget/image_loading.dart';

//轮播
class SwiperWidget1 extends StatelessWidget {
  List<CourseImg> images;

  SwiperWidget1({List<CourseImg> images}) {
    this.images = images;
  }

  @override
  Widget build(BuildContext context) {
    if (images == null || images.length < 1) {
      return Container();
    }
    return Container(
      height: ScreenUtil().L(200),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {},
            child: ClipRRect(
              child: CachedNetworkImage(
                imageUrl: "${images[index].url}",
                placeholder: (context, url) => ImageLoadingPage(),
                fit: BoxFit.cover,
              ),
            ),
          ); //添加图片并设置图片样式
        },
        itemCount: images != null ? images.length : 0,
        pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
        ),
        //显示的点
        indicatorLayout: PageIndicatorLayout.SCALE,
        autoplay: true, //是否循环
      ),
    );
  }
}
