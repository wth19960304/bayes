import 'package:bayes/base/base_widget.dart';
import 'package:bayes/base/common_function.dart';
import 'package:bayes/bean/ChengjiuModel.dart';
import 'package:bayes/bean/XuexiTongjiModel.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/constant/style.dart';
import 'package:bayes/network/intercept/showloading_intercept.dart';
import 'package:bayes/network/requestUtil.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:flutter/material.dart';

///答题\列表
class ChengjiuPage extends BaseWidget {
  String? id;

  ChengjiuPage({super.key});

  // ignore: non_constant_identifier_names
  DaTiJgPage(String id) {
    this.id = id;
  }

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _ChengjiuPagePageState();
  }
}

class _ChengjiuPagePageState extends BaseWidgetState<ChengjiuPage> {
  LoadingWidgetStatue pageStatue = LoadingWidgetStatue.LOADING;

  @override
  Widget buildWidget(BuildContext context) {
    if (pageStatue != LoadingWidgetStatue.NONE) {
      return baseStatueWidget(pageStatue);
    }
    return Column(
      children: <Widget>[
        _topWidget(),
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(
            left: ScreenUtil.L(20),
            top: ScreenUtil.L(15),
            bottom: ScreenUtil.L(15),
          ),
          child: Text("成就列表", style: KFontConstant.themTitleBigBold()),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(
              bottom: ScreenUtil.L(30),
              left: ScreenUtil.L(15),
              right: ScreenUtil.L(15),
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return _item(index);
            },
          ),
        ),
      ],
    );
  }

  _item(int index) {
    return Container(
      padding: EdgeInsets.only(
        left: ScreenUtil.L(5),
        right: ScreenUtil.L(15),
        bottom: ScreenUtil.L(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${data[index].name}",
                style: KFontConstant.blackTextBigBold(),
              ),
              Container(
                margin: EdgeInsets.only(top: ScreenUtil.L(8)),
                child: Text(
                  "${data[index].description}",
                  style: KFontConstant.grayText(),
                ),
              ),
            ],
          ),
          Container(
            decoration: data[index].isTrue != "1"
                ? KBoxStyle.nextBtnGray()
                : KBoxStyle.nextBtn(),
            padding: EdgeInsets.only(
              left: ScreenUtil.L(10),
              right: ScreenUtil.L(10),
              top: ScreenUtil.L(5),
              bottom: ScreenUtil.L(5),
            ),
            child: Text(
              data[index].isTrue != "1" ? "未完成" : "已完成",
              style: KFontConstant.whiteText(),
            ),
          ),
        ],
      ),
    );
  }

  _topWidget() {
    return Container(
      decoration: KBoxStyle.pinglunBgcolor(),
      padding: EdgeInsets.only(bottom: ScreenUtil.L(10)),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(
              left: ScreenUtil.L(20),
              top: ScreenUtil.L(15),
              bottom: ScreenUtil.L(15),
            ),
            child: Text("我的学习统计", style: KFontConstant.themTitleBigBold()),
          ),
          Container(
            margin: EdgeInsets.only(
              left: ScreenUtil.L(15),
              right: ScreenUtil.L(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: ScreenUtil.L(160),
                  decoration: KBoxStyle.shadowStyle(),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(ScreenUtil.L(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: ScreenUtil.L(10)),
                        child: Text(
                          "所有统计数据",
                          style: KFontConstant.blackTextBigBold(),
                        ),
                      ),
                      Text(
                        "观看视频数：${model1.data?.videos}",
                        style: KFontConstant.defaultText(),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: ScreenUtil.L(5),
                          bottom: ScreenUtil.L(5),
                        ),
                        child: Text(
                          "练习试题数：${model1.data?.tests}",
                          style: KFontConstant.defaultText(),
                        ),
                      ),
                      Text(
                        "练习正确率：${model1.data?.correctRate}",
                        style: KFontConstant.defaultText(),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: ScreenUtil.L(160),
                  decoration: KBoxStyle.shadowStyle(),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(ScreenUtil.L(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: ScreenUtil.L(10)),
                        child: Text(
                          "七日统计数据",
                          style: KFontConstant.blackTextBigBold(),
                        ),
                      ),
                      Text(
                        "观看视频数：${model2.data?.videos}",
                        style: KFontConstant.defaultText(),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: ScreenUtil.L(5),
                          bottom: ScreenUtil.L(5),
                        ),
                        child: Text(
                          "练习试题数：${model2.data?.tests}",
                          style: KFontConstant.defaultText(),
                        ),
                      ),
                      Text(
                        "练习正确率：${model2.data?.correctRate}",
                        style: KFontConstant.defaultText(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onCreate() {
    setTopBarVisible(true);
    setAppBarVisible(true);
    setAppBarTitle("我的成就");
    setFloatingShow(true);
    _getListvideos();
    _getWeekList();
    _beginTest();
  }

  @override
  void onClickErrorWidget() {
    _getListvideos();
    _getWeekList();
    _beginTest();
  }

  @override
  void onPause() {}

  @override
  void onResume() {}

  int pageNum = 1;
  int pageSize = 10;

  late List<ChengjiuData> data;

  ///获取答题记录列表
  _beginTest({isInit = true}) {
    var formData = {"pageNum": "$pageNum", "pageSize": "$pageSize"};
    RequestMap.getListAchieve(
      ShowLoadingIntercept(this, isInit: isInit),
      formData,
    ).listen(
      (da) {
        setState(() {
          data = da.data!;
          pageStatue = LoadingWidgetStatue.NONE;
        });
      },
      onError: (err) {
        setState(() {
          pageStatue = LoadingWidgetStatue.ERROR;
        });
        print(err.message);
      },
    );
  }

  late XuexiTongjiModel model1;
  late XuexiTongjiModel model2;

  ///获取答题记录列表
  _getListvideos({isInit = true}) {
    var formData = {"pageNum": "$pageNum", "pageSize": "$pageSize"};
    RequestMap.getListvideos(
      ShowLoadingIntercept(this, isInit: isInit),
      formData,
    ).listen((da) {
      setState(() {
        model1 = da;
      });
    }, onError: (err) {});
  }

  _getWeekList({isInit = true}) {
    var formData = {"pageNum": "$pageNum", "pageSize": "$pageSize"};
    RequestMap.getWeekList(
      ShowLoadingIntercept(this, isInit: isInit),
      formData,
    ).listen((da) {
      setState(() {
        model2 = da;
      });
    }, onError: (err) {});
  }
}
