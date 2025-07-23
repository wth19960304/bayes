import 'package:bayes/bean/StudyHomeBean.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/study/KechengSearchPage.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

//分类布局
// ignore: must_be_immutable
class TypeWidget extends StatelessWidget {
  List<SubjectManageList>? ctypeData;
  BuildContext? ct;

  TypeWidget({super.key, this.ctypeData, this.ct})

  // ignore: empty_constructor_bodies
  Widget _gridViewItemUI(SubjectManageList context) {
    return InkWell(
      onTap: () {
        Navigator.of(ct).push(MaterialPageRoute(
            builder: (v) => KeChengSearchPage(
                  id: "${context.id}",
                  typeName: "${context.subjectName}",
                )));
      },
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: ScreenUtil.L(12)),
            height: ScreenUtil.L(80),
            width: ScreenUtil.L(140),
            child: ClipRRect(
              // ignore: sort_child_properties_last
              child: CachedNetworkImage(
                imageUrl: "${context.img[0].url}",
                placeholder: (context, url) => ImageLoadingPage(
                  width: 20.0,
                ),
                errorWidget: (context, url, error) => ImageErrorPage(
                  width: 20.0,
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.L(5))),
            ),
          ),
          Container(
            height: ScreenUtil.L(20),
            margin: EdgeInsets.all(ScreenUtil.L(5)),
            child: Center(
              child: Text(
                "${context.subjectName}",
                style: KFontConstant.blackTextBigBold(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: ScreenUtil.L(25)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(right: ScreenUtil.L(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _carShopItem(),
        ),
      ),
    );
  }

  List<Widget> _carShopItem() {
    List<Widget> listWidget = List();
    for (var i = 0; i < ctypeData.length; i++) {
      listWidget.add(_gridViewItemUI(ctypeData[i]));
    }
    return listWidget;
  }
}
