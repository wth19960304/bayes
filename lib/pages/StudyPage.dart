import 'package:bayes/base/base_inner_widget.dart';
import 'package:bayes/base/common_function.dart';
import 'package:bayes/bean/TestHomeBean.dart';
import 'package:bayes/constant/color.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/constant/style.dart';
import 'package:bayes/network/intercept/showloading_intercept.dart';
import 'package:bayes/network/requestUtil.dart';
import 'package:bayes/pages/MyMessagePage.dart';
import 'package:bayes/pages/ShitiSearchPage.dart';
import 'package:bayes/pages/search_page.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

///学习
class StudyPage extends BaseInnerWidget {
  StudyPage({super.key});

  @override
  int setIndex() {
    // TODO: implement setIndex
    return 0;
  }

  @override
  BaseInnerWidgetState<BaseInnerWidget> getState() {
    // TODO: implement getState
    return _StudyPageState();
  }
}

class _StudyPageState extends BaseInnerWidgetState<StudyPage> {
  // 文本编辑控制器，用于处理输入
  TextEditingController userController = TextEditingController();

  // 页面状态，用于显示加载、错误或空状态
  LoadingWidgetStatue pageStatue = LoadingWidgetStatue.LOADING;

  // 当前显示的页面索引，0表示课程点播，1表示刷题
  int currentPage = 0;

  // 用于存储页面数据
  Data data;

  @override
  Widget? buildWidget(BuildContext context) {
    // 根据pageStatue决定显示内容
    if (pageStatue != LoadingWidgetStatue.NONE) {
      // 显示加载、错误或空状态widget
      return baseStatueWidget(pageStatue);
    } else {
      // 显示主内容，包含顶部选择栏和根据currentPage切换的内容
      return Column(
        children: <Widget>[
          _topSelect(),
          Expanded(
            child: currentPage == 0 ? _kechengWidget() : _shuatiWidget(),
          ),
        ],
      );
    }
  }

  // 课程点播与刷题的界面切换
  Widget _topSelect() {
    return Container(
      width: ScreenUtil.screenWidth,
      color: Colors.white,
      padding: EdgeInsets.only(top: ScreenUtil.L(5), bottom: ScreenUtil.L(10)),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // 课程点播选项
              InkWell(
                onTap: () {
                  if (currentPage == 0) return;
                  setState(() {
                    currentPage = 0;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: ScreenUtil.L(70)),
                  padding: EdgeInsets.only(
                    top: ScreenUtil.L(10),
                    bottom: ScreenUtil.L(10),
                  ),
                  child: Text(
                    "课程点播",
                    style: currentPage == 0
                        ? KFontConstant.themTitleBigBold()
                        : KFontConstant.blackTextBig(),
                  ),
                ),
              ),
              // 刷题选项
              InkWell(
                onTap: () {
                  if (currentPage == 1) return;
                  setState(() {
                    currentPage = 1;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: ScreenUtil.L(70)),
                  padding: EdgeInsets.only(
                    top: ScreenUtil.L(10),
                    bottom: ScreenUtil.L(10),
                  ),
                  child: Text(
                    "我要刷题",
                    style: currentPage == 1
                        ? KFontConstant.themTitleBigBold()
                        : KFontConstant.blackTextBig(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 导航栏 appBar 可以重写
  @override
  Widget getAppBar() {
    return Container(
      height: ScreenUtil.L(50),
      width: double.infinity,
      color: KColorConstant.white,
      padding: EdgeInsets.only(left: ScreenUtil.L(20), right: ScreenUtil.L(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // 搜索按钮
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SearchPage(name: currentPage == 0 ? "课程搜索" : "试题搜索"),
                ),
              );
            },
            child: Container(
              height: ScreenUtil.L(30),
              width: ScreenUtil.L(285),
              decoration: KBoxStyle.btnYuanBgcolor(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // 搜索图标
                  Container(
                    height: ScreenUtil.L(18),
                    width: ScreenUtil.L(20),
                    padding: EdgeInsets.all(ScreenUtil.L(1)),
                    margin: EdgeInsets.only(left: ScreenUtil.L(10)),
                    child: Image.asset("images/search_icon.png"),
                  ),
                  // 搜索文本
                  Container(
                    margin: EdgeInsets.only(left: ScreenUtil.L(3)),
                    child: Center(
                      child: Text(
                        currentPage == 0 ? "课程搜索" : "试题搜索",
                        style: KFontConstant.grayText(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 消息按钮
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyMessagePage()),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(ScreenUtil.L(10)),
              child: Image.asset(
                "images/message_icon.png",
                width: ScreenUtil.L(25),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 生成课程分类widget列表
  List<Widget> _setWidgets1() {
    List<Widget> widgets = [];
    for (int i = 0; i < data.subjectManageList.length; i++) {
      widgets.add(
        _warpItem(
          "${data.subjectManageList[i].id}",
          data.subjectManageList[i].subjectName,
          1,
        ),
      );
    }
    return widgets;
  }

  // 包装内容widget
  _warpContent(List<Widget> widgets) {
    return Container(
      width: ScreenUtil.screenWidth,
      margin: EdgeInsets.only(
        left: ScreenUtil.L(10),
        right: ScreenUtil.L(10),
        top: ScreenUtil.L(10),
      ),
      padding: EdgeInsets.all(ScreenUtil.L(20)),
      decoration: KBoxStyle.whiteItemStyle(),
      child: Wrap(
        spacing: ScreenUtil.L(20),
        runSpacing: ScreenUtil.L(15),
        children: widgets,
      ),
    );
  }

  // 生成单个课程分类item
  _warpItem(String id, String content, int type) {
    bool isSelect = false;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (v) => ShitiSearchPage(id: id, typeName: content),
          ),
        );
      },
      child: Container(
        decoration: isSelect
            // ignore: dead_code
            ? KBoxStyle.selectTrue()
            : KBoxStyle.selectFalse(),
        width: ScreenUtil.L(80),
        height: ScreenUtil.L(30),
        alignment: Alignment.center,
        child: Text(
          content,
          style: isSelect
              // ignore: dead_code
              ? KFontConstant.whiteTextBig()
              : KFontConstant.greyTextBig(),
        ),
      ),
    );
  }

  // 用于存储试题列表数据
  late List<TestManageList> testHomeData;

  // 获取首页数据
  _getHomeData() {
    var formData = {"page": "1"};
    RequestMap.StudyHome(
      ShowLoadingIntercept(this, isInit: true),
      formData,
    ).listen(
      (data) {
        if (_easyRefreshKey.currentState != null) {
          _easyRefreshKey.currentState.callRefreshFinish();
          _easyRefreshKey.currentState.callLoadMoreFinish();
        }
        setState(() {
          pageStatue = LoadingWidgetStatue.NONE;
          this.data = data.data;
        });
      },
      onError: (err) {
        if (_easyRefreshKey.currentState != null) {
          _easyRefreshKey.currentState.callRefreshFinish();
          _easyRefreshKey.currentState.callLoadMoreFinish();
        }
        setState(() {
          pageStatue = LoadingWidgetStatue.ERROR;
        });
        print(err.message);
      },
    );

    /// 获取试题列表
    RequestMap.getTestHome(
      ShowLoadingIntercept(this, isInit: true),
      formData,
    ).listen((data) {
      setState(() {
        testHomeData = data.data!.testManageList!;
      });
    }, onError: (err) {});
  }

  @override
  void onCreate() {
    setAppBarVisible(true);
    _getHomeData();
  }

  @override
  void onClickErrorWidget() {
    _getHomeData();
  }

  @override
  void onPause() {}

  @override
  void onResume() {}

  // 计算垂直边距
  @override
  double getVerticalMargin() {
    return ScreenUtil.L(50) + // 导航栏高度
        (ScreenUtil.statusBarHeight ?? 0.0) + // 状态栏高度
        (ScreenUtil.bottomBarHeight ?? 0.0); // 底部栏高度
  }

  // 用于存储课程数据
  String kechengData = null;

  // EasyRefresh的key
  final GlobalKey<EasyRefreshState> _easyRefreshKey =
      GlobalKey<EasyRefreshState>();
  final GlobalKey<RefreshHeaderState> _headerKey =
      GlobalKey<RefreshHeaderState>();
  final GlobalKey<RefreshFooterState> _footerKey =
      GlobalKey<RefreshFooterState>();

  /// 课程点播页面
  Widget _kechengWidget() {
    return Container(
      color: KColorConstant.appBgColor,
      padding: EdgeInsets.only(top: ScreenUtil.L(5)),
      child: EasyRefresh(
        key: _easyRefreshKey,
        autoControl: false,
        onRefresh: () async {
          await _getHomeData();
        },
        refreshHeader: ClassicsHeader(
          key: _headerKey,
          refreshText: '下拉刷新',
          refreshReadyText: '释放刷新',
          refreshingText: '正在刷新...',
          refreshedText: '刷新结束',
          moreInfo: '更新于 %T',
          bgColor: Colors.transparent,
          textColor: Colors.black87,
          moreInfoColor: Colors.black54,
          showMore: true,
        ),
        refreshFooter: ClassicsFooter(
          key: _footerKey,
          loadText: '上拉加载',
          loadReadyText: '释放加载',
          loadingText: '正在加载',
          loadedText: '加载完成',
          noMoreText: '没有更多数据',
          bgColor: Colors.transparent,
          textColor: Colors.black87,
          moreInfoColor: Colors.black54,
          showMore: true,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SwiperWidget(images: data.bannerManageList),
              TypeWidget(ctypeData: data.subjectManageList, ct: context),
              _listTitleWidget("热门课程"),
              Wrap(children: _kechengItems()),
              _listTitleWidget("热门视频"),
              Container(
                margin: EdgeInsets.only(
                  left: ScreenUtil.L(10),
                  bottom: ScreenUtil.L(30),
                ),
                child: Wrap(
                  children: _videoItems(),
                  spacing: ScreenUtil.L(10),
                  runSpacing: ScreenUtil.L(12),
                  crossAxisAlignment: WrapCrossAlignment.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 我要刷题页面
  Widget _shuatiWidget() {
    return Container(
      color: KColorConstant.appBgColor,
      padding: EdgeInsets.only(top: ScreenUtil.L(5)),
      child: EasyRefresh(
        key: _easyRefreshKey,
        autoControl: false,
        onRefresh: () async {
          await _getHomeData();
        },
        refreshHeader: ClassicsHeader(
          key: _headerKey,
          refreshText: '下拉刷新',
          refreshReadyText: '释放刷新',
          refreshingText: '正在刷新...',
          refreshedText: '刷新结束',
          moreInfo: '更新于 %T',
          bgColor: Colors.transparent,
          textColor: Colors.black87,
          moreInfoColor: Colors.black54,
          showMore: true,
        ),
        refreshFooter: ClassicsFooter(
          key: _footerKey,
          loadText: '上拉加载',
          loadReadyText: '释放加载',
          loadingText: '正在加载',
          loadedText: '加载完成',
          noMoreText: '没有更多数据',
          bgColor: Colors.transparent,
          textColor: Colors.black87,
          moreInfoColor: Colors.black54,
          showMore: true,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SwiperWidget(images: data.bannerManageList),
              Container(
                margin: EdgeInsets.all(ScreenUtil.L(10)),
                child: Row(
                  children: <Widget>[
                    // 随机刷题按钮
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectPage(type: "随机刷题"),
                          ),
                        );
                      },
                      child: SizedBox(
                        width:
                            (ScreenUtil.screenWidth - ScreenUtil.L(25)) / 2 - 1,
                        child: Image.asset("images/shuatitop1.png"),
                      ),
                    ),
                    // 错题练习按钮
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectPage(type: "错题练习"),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: ScreenUtil.L(5)),
                        width:
                            (ScreenUtil.screenWidth - ScreenUtil.L(25)) / 2 + 1,
                        child: Image.asset("images/shuatitop2.png"),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: ScreenUtil.L(12)),
                child: Text("试题分科", style: KFontConstant.blackTextBig_bold()),
              ),
              _warpContent(_setWidgets1()),
              _listTitleWidget("热门试题"),
              _shitiItems(),
              Container(margin: EdgeInsets.only(bottom: ScreenUtil.L(30))),
            ],
          ),
        ),
      ),
    );
  }

  // 生成试题列表项
  _shitiItems() {
    if (testHomeData.isEmpty) {
      return baseStatueWidget(LoadingWidgetStatue.DATAEMPTY);
    }
    List<Widget> widgets = List();
    for (int i = 0; i < testHomeData.length; i++) {
      widgets.add(
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => XuanzhetiWidget("${testHomeData[i].id}"),
              ),
            );
          },
          child: ShitiItem(data: testHomeData[i]),
        ),
      );
    }
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      children: widgets,
    );
  }

  // 生成课程列表项
  _kechengItems() {
    List<Widget> widgets = List();
    for (int i = 0; i < data.courseManageList.length; i++) {
      widgets.add(KechengItem(data: data.courseManageList[i]));
    }
    return widgets;
  }

  // 生成视频列表项
  _videoItems() {
    List<Widget> widgets = List();
    for (int i = 0; i < data.videoManageList.length; i++) {
      widgets.add(VideoItem(data.videoManageList[i]));
    }
    return widgets;
  }

  /// 列表标题布局
  Widget _listTitleWidget(String title) {
    return Container(
      margin: EdgeInsets.all(ScreenUtil.L(10)),
      padding: EdgeInsets.only(left: ScreenUtil.L(3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[Text(title, style: KFontConstant.blackTextBig())],
      ),
    );
  }
}
