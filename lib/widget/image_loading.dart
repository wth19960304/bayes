import 'package:bayes/utils/screen_util.dart';
import 'package:flutter/material.dart';

//图片加载中显示样式
// ignore: must_be_immutable
class ImageLoadingPage extends StatelessWidget {
  double width;

  ImageLoadingPage({super.key, this.width = 30.0});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: ScreenUtil.L(width),
          width: ScreenUtil.L(width),
          child: CircularProgressIndicator(strokeWidth: ScreenUtil.L(2)),
        ),
      ],
    );
  }
}
