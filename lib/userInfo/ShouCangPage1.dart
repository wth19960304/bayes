import 'package:bayes/base/base_inner_widget.dart';
import 'package:bayes/base/common_function.dart';
import 'package:bayes/bean/WoDeShouCangBean.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/constant/style.dart';
import 'package:bayes/network/intercept/showloading_intercept.dart';
import 'package:bayes/network/requestUtil.dart';
import 'package:bayes/pages/CurriclumDetailPage.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:bayes/widget/image_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///吐槽中心
class ShouCangPage1 extends BaseInnerWidget {
  ShouCangPage1({super.key});

  @override
  int setIndex() {
    // TODO: implement setIndex
    return 0;
  }

  @override
  BaseInnerWidgetState<BaseInnerWidget> getState() {
    // TODO: implement getState
    return _ShouCangPageState();
  }
}

class _ShouCangPageState extends BaseInnerWidgetState<ShouCangPage1> {
  TextEditingController userController = TextEditingController();
  LoadingWidgetStatue pageStatue = LoadingWidgetStatue.LOADING;

  @override
  Widget buildWidget(BuildContext context) {
    if (pageStatue != LoadingWidgetStatue.NONE) {
      return baseStatueWidget(pageStatue);
    } else {
      return ListView.builder(
        padding: EdgeInsets.only(
          top: ScreenUtil.L(15),
          bottom: ScreenUtil.L(30),
        ),
        itemCount: content.length,
        itemBuilder: (BuildContext context, int index) {
          return _item(content[index]);
        },
      );
    }
  }

  @override
  void onCreate() {
    setAppBarVisible(false);
    _getcomplainList();
  }

  late List<Data> content;

  //获取我的收藏
  _getcomplainList() {
    var formData = {
      "topicType": "5000", //主题类型（试题：3000  视频：4000  课程：5000）
    };
    RequestMap.myCollect(
      ShowLoadingIntercept(this, isInit: true),
      formData,
    ).listen((data) {
      setState(() {
        // ignore: prefer_is_empty
        if (data.data == null || data.data?.length == 0) {
          pageStatue = LoadingWidgetStatue.DATAEMPTY;
          return;
        }
        content = data.data ?? [];
        pageStatue = LoadingWidgetStatue.NONE;
      });
    }, onError: (err) {});
  }

  @override
  void onPause() {}

  @override
  void onResume() {}

  @override
  double getVerticalMargin() {
    return ScreenUtil.L(92) + //bar栏高度
        (ScreenUtil.statusBarHeight ?? 0) + //状态栏高度
        (ScreenUtil.bottomBarHeight ?? 0);
  }

  Widget _item(Data data) {
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
              width: ScreenUtil.L(130),
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
            Expanded(child: _rightWidget(data)),
          ],
        ),
      ),
    );
  }

  Widget _rightWidget(Data data) {
    List<Widget> widgets = [];
    List<BoxDecoration> des = [
      KBoxStyle.lvseRound4Bg(),
      KBoxStyle.orangeRound4Bg(),
      KBoxStyle.blueRound4Bg(),
    ];

    for (int i = 0; i < (data.courseLabel?.length ?? 0); i++) {
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
          Container(
            child: Text(
              "${data.courseName}",
              maxLines: 2,
              style: KFontConstant.blackTextBig(),
            ),
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
