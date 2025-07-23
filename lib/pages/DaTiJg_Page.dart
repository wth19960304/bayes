//答题结果-详情
import 'package:bayes/base/base_widget.dart';
import 'package:bayes/base/common_function.dart';
import 'package:bayes/bean/DatiJlBean.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/constant/style.dart';
import 'package:bayes/network/intercept/showloading_intercept.dart';
import 'package:bayes/network/requestUtil.dart';
import 'package:bayes/utils/DateUtils.dart';
// ignore: library_prefixes
import 'package:bayes/utils/screen_util.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

///答题界面
// ignore: must_be_immutable
class DaTiJgPage extends BaseWidget {
  String id;

  DaTiJgPage(this.id, {super.key});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _DaTiJgPageState();
  }
}

class _DaTiJgPageState extends BaseWidgetState<DaTiJgPage> {
  String _name = "";
  int _sales = 0;
  String _name2 = "";
  int _sales2 = 0;
  String _name3 = "";
  int _sales3 = 0;

  //点击柱状图触发的函数
  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;
    setState(() {
      //改变两个显示的数值
      _name = selectedDatum.first.datum.name;
      _sales = selectedDatum.first.datum.sales;
    });
  }

  _onSelectionChanged2(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;
    setState(() {
      //改变两个显示的数值
      _name2 = selectedDatum.first.datum.name;
      _sales2 = selectedDatum.first.datum.sales;
    });
  }

  _onSelectionChanged3(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;
    setState(() {
      //改变两个显示的数值
      _name3 = selectedDatum.first.datum.name;
      _sales3 = selectedDatum.first.datum.sales;
    });
  }

  LoadingWidgetStatue pageStatue = LoadingWidgetStatue.LOADING;

  @override
  Widget buildWidget(BuildContext context) {
    if (pageStatue != LoadingWidgetStatue.NONE) {
      return baseStatueWidget(pageStatue);
    }
    chartData = ChartFlutterBean.createSampleData(data.telvMap1 ?? []);
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: ScreenUtil.L(0.5)),
        padding: EdgeInsets.only(
          left: ScreenUtil.L(15),
          right: ScreenUtil.L(15),
        ),
        child: Column(
          children: <Widget>[
            _jinDuTiao(),
            //_topWidget(),
            Visibility(
              visible: data.testRecord?.recordName != "课后练习",
              child: Container(
                decoration: KBoxStyle.shadowStyle(),
                padding: EdgeInsets.all(ScreenUtil.L(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("科目分布统计", style: KFontConstant.blackTextBigBold()),
                    Container(height: ScreenUtil.L(10)),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "正确率：$_name3",
                              style: KFontConstant.grayText(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "答题数：$_sales3",
                              style: KFontConstant.grayText(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: ScreenUtil.screenWidth,
                        height: 200.0,
                        child: charts.BarChart(
                          //通过下面获取数据传入
                          ChartFlutterBean.createSampleData(data.subMap ?? []),
                          //配置项，以及设置触发的函数
                          selectionModels: [
                            charts.SelectionModelConfig(
                              type: charts.SelectionModelType.info,
                              changedListener: _onSelectionChanged3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: data.testRecord?.recordName != "课后练习",
              child: Container(
                decoration: KBoxStyle.shadowStyle(),
                padding: EdgeInsets.all(ScreenUtil.L(15)),
                margin: EdgeInsets.only(top: ScreenUtil.L(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("专题分布统计", style: KFontConstant.blackTextBigBold()),
                    Container(height: ScreenUtil.L(10)),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "正确率：$_name2",
                              style: KFontConstant.grayText(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "答题数：$_sales2",
                              style: KFontConstant.grayText(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: ScreenUtil.screenWidth,
                        height: 200.0,
                        child: charts.BarChart(
                          //通过下面获取数据传入
                          ChartFlutterBean.createSampleData(data.therate ?? []),
                          //配置项，以及设置触发的函数
                          selectionModels: [
                            charts.SelectionModelConfig(
                              type: charts.SelectionModelType.info,
                              changedListener: _onSelectionChanged2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: KBoxStyle.shadowStyle(),
              padding: EdgeInsets.all(ScreenUtil.L(15)),
              margin: EdgeInsets.only(top: ScreenUtil.L(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("难度分布统计", style: KFontConstant.blackTextBigBold()),
                  Container(height: ScreenUtil.L(10)),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "正确率：$_name",
                            style: KFontConstant.grayText(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "答题数：$_sales",
                            style: KFontConstant.grayText(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      width: ScreenUtil.screenWidth,
                      height: 200.0,
                      child: charts.BarChart(
                        //通过下面获取数据传入
                        ChartFlutterBean.createSampleData(data.telvMap1 ?? []),
                        animate: true,
                        behaviors: [
                          charts.SlidingViewport(),
                          charts.PanAndZoomBehavior(),
                        ],
                        //配置项，以及设置触发的函数
                        selectionModels: [
                          charts.SelectionModelConfig(
                            type: charts.SelectionModelType.info,
                            changedListener: _onSelectionChanged,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //进度条
  // 条形进度条布局
  _jinDuTiao() {
    return Container(
      decoration: KBoxStyle.shadowStyle(),
      margin: EdgeInsets.only(bottom: ScreenUtil.L(15), top: ScreenUtil.L(15)),
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
            child: Text(
              "${data.testRecord?.recordName} - ${DateUtil.instance.getFormartData(timeSamp: int.parse(data.testRecord!.addTime ?? ''), format: "yyyy.MM.dd")}",
              style: KFontConstant.blackTextBigBold(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: ScreenUtil.L(25),
              right: ScreenUtil.L(50),
              bottom: ScreenUtil.L(10),
            ),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: ScreenUtil.L(10)),
                  child: Image.asset(
                    "images/icon_lianxi.png",
                    width: ScreenUtil.L(30),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("答题数量", style: KFontConstant.themTitleBigBold()),
                          Text("${data.testRecord?.testNum}"),
                        ],
                      ),
                      SizedBox(
                        width: 300.0,
                        height: 10.0,
                        child: ClipRRect(
                          // 边界半径（`borderRadius`）属性，圆角的边界半径。
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          child: LinearProgressIndicator(
                            value:
                                double.parse(data.testRecord?.testNum ?? '') /
                                100,
                            backgroundColor: Color(0xffE6E6E6),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xffF6AB67),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: ScreenUtil.L(25),
              right: ScreenUtil.L(50),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: ScreenUtil.L(10)),
                  child: Image.asset(
                    "images/icon_zhengque.png",
                    width: ScreenUtil.L(30),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "答题正确率",
                            style: KFontConstant.themTitleBigBold(),
                          ),
                          Text("${data.testRecord?.correctRate}"),
                        ],
                      ),
                      SizedBox(
                        width: 300.0,
                        height: 10.0,
                        child: ClipRRect(
                          // 边界半径（`borderRadius`）属性，圆角的边界半径。
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          child: LinearProgressIndicator(
                            value:
                                double.parse(
                                  data.testRecord?.correctRate!.split("%")[0] ??
                                      '',
                                ) /
                                100,
                            backgroundColor: Color(0xffE6E6E6),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xff66B645),
                            ),
                          ),
                        ),
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
    setAppBarTitle("练习结果");
    setFloatingShow(true);
    _beginTest();
  }

  @override
  void onPause() {}

  @override
  void onResume() {}

  late DatiJlData data;

  ///获取答题记录
  _beginTest() {
    var formData = {"id": widget.id};
    RequestMap.getTestRecord(
      ShowLoadingIntercept(this, isInit: true),
      formData,
    ).listen(
      (data) {
        setState(() {
          this.data = data.data!;
          pageStatue = LoadingWidgetStatue.NONE;
        });
      },
      onError: (err) {
        showToast(err.message);
      },
    );
  }
}

class OrdinalSales {
  final String name;
  final int sales;

  OrdinalSales(this.name, this.sales);
}

List<charts.Series<OrdinalSales, String>> chartData = [];

class ChartFlutterBean {
  //柱颜色
  bool btn = false;

  static List<charts.Series<OrdinalSales, String>> createSampleData(
    List<SubMap> datas,
  ) {
    List<OrdinalSales> data = [];
    for (SubMap bean in datas) {
      data.add(
        OrdinalSales(
          '${bean.name}(${bean.trueNum})',
          int.parse(bean.totalNum ?? ''),
        ),
      );
    }

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFFF6AB67)),
        //柱颜色控制
        domainFn: (OrdinalSales sales, _) => sales.name,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      ),
    ];
  }
}
