import 'package:bayes/base/base_inner_widget.dart';
import 'package:bayes/base/common_function.dart';
import 'package:bayes/bean/ShouChangVideoBean.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/constant/style.dart';
import 'package:bayes/network/intercept/showloading_intercept.dart';
import 'package:bayes/network/requestUtil.dart';
import 'package:bayes/pages/VideoPage.dart';
import 'package:bayes/pages/VideoPage2.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:bayes/widget/image_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///收藏-视频
class ShouCangPage2 extends BaseInnerWidget {
  ShouCangPage2({super.key});

  @override
  int setIndex() {
    // TODO: implement setIndex
    return 1;
  }

  @override
  BaseInnerWidgetState<BaseInnerWidget> getState() {
    // TODO: implement getState
    return _ShouCangPageState();
  }
}

class _ShouCangPageState extends BaseInnerWidgetState<ShouCangPage2> {
  LoadingWidgetStatue pageStatue = LoadingWidgetStatue.LOADING;

  @override
  Widget buildWidget(BuildContext context) {
    if (pageStatue != LoadingWidgetStatue.NONE) {
      return baseStatueWidget(pageStatue);
    } else {
      return SingleChildScrollView(
        padding: EdgeInsets.only(top: ScreenUtil.L(10)),
        child: Column(
          children: <Widget>[
            Wrap(children: _list1()),
            Wrap(children: _list2()),
          ],
        ),
      );
    }
  }

  //视频列表
  List<Widget> _list1() {
    List<Widget> widgets = [];
    for (int i = 0; i < (data.data?.videoManageList?.length ?? 0); i++) {
      widgets.add(_item(data.data!.videoManageList![i]));
    }
    return widgets;
  }

  //视频列表
  List<Widget> _list2() {
    List<Widget> widgets = [];
    for (int i = 0; i < (data.data!.courseVideoList?.length ?? 0); i++) {
      widgets.add(_item2(data.data!.courseVideoList![i]));
    }
    return widgets;
  }

  @override
  void onCreate() {
    setAppBarVisible(false);
    _getcomplainList();
  }

  late ShouCangVideoBean data;

  //获取我的收藏
  _getcomplainList() {
    var formData = {
      "topicType": "4000", //主题类型（试题：3000  视频：4000  课程：5000）
    };
    RequestMap.myCollectVideo(
      ShowLoadingIntercept(this, isInit: true),
      formData,
    ).listen(
      (data) {
        setState(() {
          this.data = data;
          pageStatue = LoadingWidgetStatue.NONE;
        });
      },
      onError: (err) {
        print(err.message);
      },
    );
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

  Widget _item(VideoManageList data) {
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
          Navigator.of(
            context,
          ).push(CupertinoPageRoute(builder: (_) => VideoPage(id: data.id)));
        },
        child: Row(
          children: <Widget>[
            SizedBox(
              height: ScreenUtil.L(75),
              width: ScreenUtil.L(100),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(ScreenUtil.L(7)),
                ),
                child: CachedNetworkImage(
                  imageUrl: "${data.titlePage}",
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

  Widget _rightWidget(VideoManageList data) {
    List<Widget> widgets = [];
    List<BoxDecoration> des = [
      KBoxStyle.lvseRound4Bg(),
      KBoxStyle.orangeRound4Bg(),
      KBoxStyle.blueRound4Bg(),
    ];

    for (int i = 0; i < (data.videoLabel?.length ?? 0); i++) {
      widgets.add(
        Container(
          margin: EdgeInsets.only(right: ScreenUtil.L(10)),
          padding: EdgeInsets.all(ScreenUtil.L(2)),
          decoration: des[i % 3],
          child: Text("${data.videoLabel?[i].name}"),
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
              "${data.name}",
              maxLines: 2,
              style: KFontConstant.blackTextBig(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: widgets),
              //              Text("${data.studyNum}人已学习"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _item2(CourseVideoList data) {
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
              builder: (_) => VideoPage2(
                id: int.parse(data.courseId ?? ''),
                videoId: data.id,
              ),
            ),
          );
        },
        child: Row(
          children: <Widget>[
            SizedBox(
              height: ScreenUtil.L(75),
              width: ScreenUtil.L(100),
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
            Expanded(child: _rightWidget2(data)),
          ],
        ),
      ),
    );
  }

  Widget _rightWidget2(CourseVideoList data) {
    List<Widget> widgets = [];
    List<BoxDecoration> des = [
      KBoxStyle.lvseRound4Bg(),
      KBoxStyle.orangeRound4Bg(),
      KBoxStyle.blueRound4Bg(),
    ];
    if (data.videolabel != null)
      // ignore: curly_braces_in_flow_control_structures
      for (int i = 0; i < (data.videolabel?.length ?? 0); i++) {
        widgets.add(
          Container(
            margin: EdgeInsets.only(right: ScreenUtil.L(10)),
            padding: EdgeInsets.all(ScreenUtil.L(2)),
            decoration: des[i % 3],
            child: Text("${data.videolabel?[i].name}"),
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
              "${data.name}",
              maxLines: 2,
              style: KFontConstant.blackTextBig(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: widgets),
              //              Text("${data.studyNum}人已学习"),
            ],
          ),
        ],
      ),
    );
  }
}
