import 'package:bayes/bean/ShouChangVideoBean.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/constant/style.dart';
import 'package:bayes/pages/VideoPage.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widget/image_loading.dart';

//课程列表Item
// ignore: must_be_immutable
class VideoItem extends StatelessWidget {
  VideoManageList? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: KBoxStyle.whiteItemStyle(),
      width: (ScreenUtil.screenWidth! - ScreenUtil.L(30)) / 2,
      child: InkWell(
        onTap: () {
          Navigator.of(
            context,
          ).push(CupertinoPageRoute(builder: (_) => VideoPage(id: data?.id)));
        },
        child: Column(
          children: <Widget>[
            SizedBox(
              width: (ScreenUtil.screenWidth! - ScreenUtil.L(30)) / 2,
              height: (ScreenUtil.screenWidth! - ScreenUtil.L(30)) / 2 / 16 * 9,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ScreenUtil.L(7)),
                  topRight: Radius.circular(ScreenUtil.L(7)),
                ),
                child: CachedNetworkImage(
                  imageUrl: "${data?.titlePage}",
                  placeholder: (context, url) => ImageLoadingPage(width: 20.0),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${data?.name}",
                maxLines: 2,
                style: KFontConstant.defaultText(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  VideoItem(this.data, {super.key});
}
