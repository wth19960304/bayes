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

// 轮播图组件，继承自StatelessWidget
class SwiperWidget extends StatelessWidget {
  // 可空的轮播图数据列表
  List<BannerManageList>? images;

  // 构造函数，接收可选的key和images参数
  SwiperWidget({super.key, this.images});

  @override
  Widget build(BuildContext context) {
    // 数据为空检查：如果images为null或空列表，返回空容器
    if (images == null || images!.isEmpty) {
      return Container();
    }

    // 主组件布局
    return SizedBox(
      // 固定高度150逻辑像素（适配屏幕）
      height: ScreenUtil.L(150),
      // 使用Swiper组件实现轮播效果
      child: Swiper(
        // 轮播项构建器
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            // 点击事件处理
            onTap: () {
              // 根据类型跳转到不同页面
              if (images?[index].type == "跳转到视频") {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (_) => VideoPage(
                      // 解析跳转ID，空安全处理
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
            // 轮播项内容
            child: Container(
              // 外边距设置（左右10，顶部5逻辑像素）
              margin: EdgeInsets.only(
                left: ScreenUtil.L(10),
                right: ScreenUtil.L(10),
                top: ScreenUtil.L(5),
              ),
              // 圆角裁剪容器
              child: ClipRRect(
                // 7逻辑像素的圆角
                borderRadius: BorderRadius.all(
                  Radius.circular(ScreenUtil.L(7)),
                ),
                // 网络图片加载组件
                child: CachedNetworkImage(
                  // 图片URL（空安全访问）
                  imageUrl: "${images?[index].img?[0].url}",
                  // 加载占位图
                  placeholder: (context, url) => ImageLoadingPage(),
                  // 图片填充方式
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        // 轮播项数量（空安全处理）
        itemCount: images != null ? images?.length ?? 0 : 0,
        // 分页指示器配置
        pagination: SwiperPagination(
          // 指示器位置（右下角）
          alignment: Alignment.bottomRight,
          // 指示器外边距（右20，下10逻辑像素）
          margin: EdgeInsets.only(
            right: ScreenUtil.L(20),
            bottom: ScreenUtil.L(10),
          ),
        ),
        // 指示器布局样式（缩放效果）
        indicatorLayout: PageIndicatorLayout.SCALE,
        // 自动轮播开关
        autoplay: true,
      ),
    );
  }
}
