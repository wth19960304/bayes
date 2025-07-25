import 'package:bayes/bean/StudyHomeBean.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/constant/style.dart';
import 'package:bayes/pages/CurriclumDetailPage.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widget/image_loading.dart';

//课程列表Item
// ignore: must_be_immutable
class KechengItem extends StatelessWidget {
  CourseManageList data;

  KechengItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: KBoxStyle.whiteItemStyle(),
      margin: EdgeInsets.only(
        left: ScreenUtil.L(10),
        right: ScreenUtil.L(10),
        bottom: ScreenUtil.L(10),
      ),
      padding: EdgeInsets.all(ScreenUtil.L(7)),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (_) => CurriculumDetailPage(id: data.id),
            ),
          );
        },
        child: Row(
          children: <Widget>[
            SizedBox(
              height: ScreenUtil.L(75),
              width: ScreenUtil.L(140),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(ScreenUtil.L(7)),
                ),
                child: CachedNetworkImage(
                  imageUrl: "${data.courseImg?[0].url}",
                  placeholder: (context, url) => ImageLoadingPage(width: 20.0),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(child: _rightWidget()),
          ],
        ),
      ),
    );
  }

  Widget _rightWidget() {
    List<Widget> widgets = [];
    List<BoxDecoration> des = [
      KBoxStyle.lvseRound4Bg(),
      KBoxStyle.orangeRound4Bg(),
      KBoxStyle.blueRound4Bg(),
    ];

    for (int i = 0; i < data.courseLabel!.length; i++) {
      widgets.add(
        Container(
          margin: EdgeInsets.only(right: ScreenUtil.L(10)),
          padding: EdgeInsets.all(ScreenUtil.L(2)),
          decoration: des[i % 3],
          child: Text("${data.courseLabel?[i].name}"),
        ),
      );
    }
    return Container(
      height: ScreenUtil.L(65),
      margin: EdgeInsets.all(ScreenUtil.L(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${data.courseName}",
            maxLines: 2,
            style: KFontConstant.blackTextBig(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: widgets),
              Text("${data.studyNum}人已学习"),
            ],
          ),
        ],
      ),
    );
  }
}
