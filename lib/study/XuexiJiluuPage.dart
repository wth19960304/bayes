import 'package:bayes/base/base_widget.dart';
import 'package:bayes/base/common_function.dart';
import 'package:bayes/bean/XuexiJiluBean.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/constant/style.dart';
import 'package:bayes/network/intercept/showloading_intercept.dart';
import 'package:bayes/network/requestUtil.dart';
import 'package:bayes/pages/CurriclumDetailPage.dart';
import 'package:bayes/pages/VideoPage.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:bayes/widget/image_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///学习记录
class XuexiJiluPage extends BaseWidget {
  const XuexiJiluPage({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _XuexiJiluPageState();
  }
}

class _XuexiJiluPageState extends BaseWidgetState<XuexiJiluPage> {
  LoadingWidgetStatue pageStatue = LoadingWidgetStatue.LOADING;

  @override
  Widget buildWidget(BuildContext context) {
    if (pageStatue != LoadingWidgetStatue.NONE) {
      return baseStatueWidget(pageStatue);
    }
    return ListView.builder(
      padding: EdgeInsets.only(top: ScreenUtil.L(20), bottom: ScreenUtil.L(30)),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        if (data[index].type != "1") {
          return _item(data[index]);
        } else {
          return _item2(data[index]);
        }
      },
    );
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
              builder: (_) => CurriculumDetailPage(id: data.course?.id),
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
                  imageUrl: "${data.course!.courseImg?[0].url}",
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

    for (int i = 0; i < (data.course?.courseLabel?.length ?? 0); i++) {
      widgets.add(
        Container(
          margin: EdgeInsets.only(right: ScreenUtil.L(10)),
          padding: EdgeInsets.all(ScreenUtil.L(2)),
          decoration: des[i % 3],
          child: Text("${data.course!.courseLabel?[i].name}"),
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
              "${data.course?.courseName}",
              maxLines: 2,
              style: KFontConstant.blackTextBig(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: widgets),
              Text("${data.course?.studyNum}人已学习"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _item2(Data data) {
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
            CupertinoPageRoute(builder: (_) => VideoPage(id: data.video?.id)),
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
                  imageUrl: "${data.video?.titlePage}",
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

  Widget _rightWidget2(Data data) {
    List<Widget> widgets = [];
    List<BoxDecoration> des = [
      KBoxStyle.lvseRound4Bg(),
      KBoxStyle.orangeRound4Bg(),
      KBoxStyle.blueRound4Bg(),
    ];

    for (int i = 0; i < (data.video?.videoLabel?.length ?? 0); i++) {
      widgets.add(
        Container(
          margin: EdgeInsets.only(right: ScreenUtil.L(10)),
          padding: EdgeInsets.all(ScreenUtil.L(2)),
          decoration: des[i % 3],
          child: Text("${data.video!.videoLabel?[i].name}"),
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
              "${data.video?.name}",
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

  @override
  void onCreate() {
    setTopBarVisible(true);
    setAppBarVisible(true);
    setAppBarTitle("学习记录");
    setFloatingShow(true);
    _beginTest();
  }

  @override
  void onPause() {}

  @override
  void onResume() {}

  int pageNum = 1;
  int pageSize = 10;

  late List<Data> data;

  ///获取答题记录列表
  _beginTest({isInit = true}) {
    var formData = {"pageNum": "$pageNum", "pageSize": "$pageSize"};
    RequestMap.getStudyRecord(
      ShowLoadingIntercept(this, isInit: isInit),
      formData,
    ).listen(
      (da) {
        if (da.data?.length == 0) {
          setState(() {
            data = da.data ?? [];
            pageStatue = LoadingWidgetStatue.DATAEMPTY;
          });
          return;
        }
        setState(() {
          data = da.data ?? [];
          pageStatue = LoadingWidgetStatue.NONE;
        });
      },
      onError: (err) {
        print(err.message);
        if (httpNoCancle(err))
          // ignore: curly_braces_in_flow_control_structures
          setState(() {
            pageStatue = LoadingWidgetStatue.ERROR;
          });
      },
    );
  }
}
