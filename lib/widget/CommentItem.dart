import 'package:bayes/bean/CommentBean.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/utils/DateUtils.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:bayes/widget/image_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

//评论item
// ignore: must_be_immutable
class CommentItem extends StatelessWidget {
  CommentContent? content;

  CommentItem({super.key, this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[_topWidget(), _contentWidget()],
    );
  }

  ///顶部布局
  _topWidget() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil.L(20), right: ScreenUtil.L(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: ScreenUtil.L(20),
                  right: ScreenUtil.L(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(ScreenUtil.L(50)),
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        "${content?.userHead == null || content?.userHead?.length == 0 ? "" : content!.userHead![0].url}",
                    placeholder: (context, url) =>
                        ImageLoadingPage(width: 20.0),
                    errorWidget: (context, url, error) => Image.asset(
                      "images/header_defalut.png",
                      width: ScreenUtil.L(40),
                      height: ScreenUtil.L(40),
                    ),
                    fit: BoxFit.cover,
                    width: ScreenUtil.L(40),
                    height: ScreenUtil.L(40),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${content?.userName}",
                    style: KFontConstant.defaultText(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil.L(5)),
                    child: Text(
                      "${DateUtil.instance.getFormartData(timeSamp: int.parse(content!.addTime ?? ''), format: "yyyy.MM.dd")}",
                      style: KFontConstant.grayTextSmall(),
                    ),
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
      padding: EdgeInsets.only(
        left: ScreenUtil.L(70),
        top: ScreenUtil.L(5),
        right: ScreenUtil.L(15),
      ),
      child: Text("${content?.content}", style: KFontConstant.defaultText()),
    );
  }
}
