import 'package:bayes/base/base_widget.dart';
import 'package:bayes/base/common_function.dart';
import 'package:bayes/bean/DatiJlListBean.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/constant/style.dart';
import 'package:bayes/network/intercept/showloading_intercept.dart';
import 'package:bayes/network/requestUtil.dart';
import 'package:bayes/pages/DaTiJg_Page.dart';
import 'package:bayes/utils/DateUtils.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:bayes/widget/XuanzhetiWidget2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

///答题\列表
class ShitiListPage extends BaseWidget {
  String? id;

  ShitiListPage({super.key});

  // ignore: non_constant_identifier_names
  DaTiJgPage(String id) {
    this.id = id;
  }

  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return _ShitiListPageState();
  }
}

class _ShitiListPageState extends BaseWidgetState<ShitiListPage> {
  LoadingWidgetStatue pageStatue = LoadingWidgetStatue.LOADING;

  @override
  Widget buildWidget(BuildContext context) {
    if (pageStatue != LoadingWidgetStatue.NONE) {
      return baseStatueWidget(pageStatue);
    }
    return EasyRefresh(
      onRefresh: () async {
        pageNum = 1;
        await _beginTest();
      },
      // loadMore: () async {
      //   await _beginTest();
      // },
      header: ClassicalHeader(
        refreshText: '下拉刷新',
        refreshReadyText: '释放刷新',
        refreshingText: '正在刷新...',
        refreshedText: '刷新结束',
        bgColor: Colors.transparent,
        textColor: Colors.black87,
        infoColor: Colors.black54,
        showInfo: true,
      ),
      footer: ClassicalFooter(
        loadText: '上拉加载',
        loadReadyText: '释放加载',
        loadingText: '正在加载',
        loadedText: '加载完成',
        noMoreText: '没有更多数据',
        bgColor: Colors.transparent,
        textColor: Colors.black87,
        infoColor: Colors.black54,
        showInfo: true,
      ),
      child: ListView.builder(
        padding: EdgeInsets.only(
          top: ScreenUtil.L(20),
          bottom: ScreenUtil.L(30),
        ),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return _item(index);
        },
      ),
    );
  }

  _item(int index) {
    return Container(
      decoration: KBoxStyle.whiteItemStyle(),
      margin: EdgeInsets.only(
        left: ScreenUtil.L(10),
        right: ScreenUtil.L(10),
        bottom: ScreenUtil.L(10),
      ),
      padding: EdgeInsets.all(ScreenUtil.L(7)),
      child: InkWell(onTap: () {}, child: _rightWidget(data[index])),
    );
  }

  Widget _rightWidget(DatiJlContent data) {
    List<Widget> widgets = [];
    List<BoxDecoration> des = [
      KBoxStyle.lvseRound4Bg(),
      KBoxStyle.orangeRound4Bg(),
      KBoxStyle.blueRound4Bg(),
    ];
    widgets.add(
      Container(
        margin: EdgeInsets.only(right: ScreenUtil.L(10)),
        padding: EdgeInsets.all(ScreenUtil.L(2)),
        decoration: KBoxStyle.lvseRound4Bg(),
        child: Text("${data.recordType}"),
      ),
    );

    widgets.add(
      Container(
        margin: EdgeInsets.only(right: ScreenUtil.L(10)),
        padding: EdgeInsets.all(ScreenUtil.L(2)),
        child: Text(
          " ${DateUtil.instance.getFormartData(timeSamp: int.parse(data.addTime ?? ''), format: "yyyy-MM-dd HH:mm")}",
        ),
      ),
    );

    return InkWell(
      onTap: () {
        if (data.state == "1") {
          //跳转到答题结果详情界面
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DaTiJgPage("${data.id}")),
          );
        } else {
          //跳转到答题结果详情界面
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => XuanzhetiWidget2("${data.id}", 0),
            ),
          );
        }
      },
      child: Container(
        height: ScreenUtil.L(55),
        margin: EdgeInsets.all(ScreenUtil.L(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                "${data.recordName}",
                maxLines: 2,
                style: KFontConstant.blackTextBig(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(children: widgets),
                data.state == "1"
                    ? Text("正确率：${data.correctRate}")
                    : Container(
                        padding: EdgeInsets.all(ScreenUtil.L(5)),
                        decoration: KBoxStyle.nextBtn(),
                        child: Text("继续答题", style: KFontConstant.whiteText()),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onCreate() {
    setTopBarVisible(true);
    setAppBarVisible(true);
    setAppBarTitle("练习记录");
    setFloatingShow(true);
    _beginTest();
  }

  @override
  void onPause() {}

  @override
  void onResume() {}

  int pageNum = 1;
  int pageSize = 10;

  late List<DatiJlContent> data;

  ///获取答题记录列表
  _beginTest({isInit = true}) {
    var formData = {"pageNum": "$pageNum", "pageSize": "$pageSize"};
    RequestMap.getRecordList(
      ShowLoadingIntercept(this, isInit: isInit),
      formData,
    ).listen(
      (data) {
        // if (_easyRefreshKey.currentState != null) {
        //   _easyRefreshKey.currentState.callRefreshFinish();
        //   _easyRefreshKey.currentState.callLoadMoreFinish();
        // }
        if (data.data?.total == 0) {
          setState(() {
            pageStatue = LoadingWidgetStatue.DATAEMPTY;
          });
          return;
        }
        setState(() {
          if (pageNum == 1) {
            this.data = data.data?.content ?? [];
          } else {
            if (this.data.length >= (data.data?.total ?? 0)) {
              return;
            }
            this.data.addAll(data.data?.content ?? []);
          }

          pageNum++;
          pageStatue = LoadingWidgetStatue.NONE;
        });
      },
      onError: (err) {
        // if (_easyRefreshKey.currentState != null) {
        //   _easyRefreshKey.currentState.callRefreshFinish();
        //   _easyRefreshKey.currentState.callLoadMoreFinish();
        // }
        setState(() {
          pageStatue = LoadingWidgetStatue.ERROR;
        });
      },
    );
  }
}
