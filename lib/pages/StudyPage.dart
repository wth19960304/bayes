import 'package:bayes/base/base_inner_widget.dart';
import 'package:bayes/base/common_function.dart';
import 'package:bayes/bean/StudyHomeBean.dart';
import 'package:bayes/bean/TestHomeBean.dart';
import 'package:bayes/constant/color.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/constant/style.dart';
import 'package:bayes/network/intercept/showloading_intercept.dart';
import 'package:bayes/network/requestUtil.dart';
import 'package:bayes/pages/KechengItem.dart';
import 'package:bayes/pages/MyMessagePage.dart';
import 'package:bayes/pages/SelectPage.dart';
import 'package:bayes/pages/ShitiItem.dart';
import 'package:bayes/pages/ShitiSearchPage.dart';
import 'package:bayes/pages/VideoItem.dart';
import 'package:bayes/pages/search_page.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:bayes/widget/SwiperWidget.dart';
import 'package:bayes/widget/TypeWidget.dart';
import 'package:bayes/widget/XuanzhetiWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

///学习
/// 学习页面，包含课程点播和刷题功能
// ignore: must_be_immutable
class StudyPage extends BaseInnerWidget {
  /// 构造函数，接受父类的 key
  StudyPage({super.key});

  /// 设置索引，返回一个整数
  @override
  int setIndex() {
    return 0;
  }

  /// 获取页面状态对象
  @override
  BaseInnerWidgetState<BaseInnerWidget> getState() {
    return _StudyPageState();
  }
}

/// 学习页面的状态类，管理页面的生命周期和交互
class _StudyPageState extends BaseInnerWidgetState<StudyPage> {
  /// 文本输入控制器，用于管理输入框的状态
  TextEditingController userController = TextEditingController();

  /// 页面状态，用于显示加载、错误等状态
  LoadingWidgetStatue pageStatue = LoadingWidgetStatue.LOADING;

  /// 当前显示的页面索引，0 表示课程点播，1 表示刷题
  int currentPage = 0;

  /// 用户数据对象，存储页面所需的数据
  late Data data;

  // ignore: unused_field
  final PageController _pageController = PageController();

  /// 构建页面 widget
  @override
  Widget buildWidget(BuildContext context) {
    /// 如果页面状态不是 NONE，显示对应的状态组件
    if (pageStatue != LoadingWidgetStatue.NONE) {
      return baseStatueWidget(pageStatue);
    } else {
      /// 显示页面内容，根据 currentPage 切换课程点播或刷题布局
      return Column(
        children: <Widget>[
          _topSelect(),
          // Expanded(
          //   child: currentPage == 0 ? _kechengWidget() : _shuatiWidget(),
          // ),
          Expanded(
            child: IndexedStack(
              index: currentPage,
              children: [_kechengWidget(), _shuatiWidget()],
            ),
          ),
        ],
      );
    }
  }

  /// 创建顶部的切换按钮组件
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
              /// 课程点播按钮
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

              /// 刷题按钮
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

  /// 自定义导航栏
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
          /// 搜索按钮
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
                  Container(
                    height: ScreenUtil.L(18),
                    width: ScreenUtil.L(20),
                    padding: EdgeInsets.all(ScreenUtil.L(1)),
                    margin: EdgeInsets.only(left: ScreenUtil.L(10)),
                    child: Image.asset("images/search_icon.png"),
                  ),
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

          /// 消息按钮
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

  /// 生成科目管理列表的 widget
  List<Widget> _setWidgets1() {
    List<Widget> widgets = [];
    for (int i = 0; i < data.subjectManageList!.length; i++) {
      widgets.add(
        _warpItem(
          "${data.subjectManageList?[i].id}",
          data.subjectManageList![i].subjectName ?? '',
          1,
        ),
      );
    }
    return widgets;
  }

  /// 包装科目管理列表的 widget
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

  /// 创建科目项的 widget
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

  /// 试题管理数据列表
  List<TestManageList>? testHomeData;

  /// 获取首页数据
  _getHomeData() {
    var formData = {"page": "1"};
    RequestMap.StudyHome(
      ShowLoadingIntercept(this, isInit: true),
      formData,
    ).listen(
      (data) {
        setState(() {
          pageStatue = LoadingWidgetStatue.NONE;
          this.data = data.data!;
        });
      },
      onError: (err) {
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

  /// 页面创建时调用，初始化数据
  @override
  void onCreate() {
    setAppBarVisible(true);
    _getHomeData();
  }

  /// 点击错误组件时调用，重新获取数据
  @override
  void onClickErrorWidget() {
    _getHomeData();
  }

  /// 页面暂停时调用
  @override
  void onPause() {}

  /// 页面恢复时调用
  @override
  void onResume() {}

  /// 计算垂直边距
  @override
  double getVerticalMargin() {
    return ScreenUtil.L(50) +
        (ScreenUtil.statusBarHeight ?? 0) +
        (ScreenUtil.bottomBarHeight ?? 0);
  }

  /// 课程数据
  Null kechengData;

  /// 课程点播页面布局
  Widget _kechengWidget() {
    return Container(
      color: KColorConstant.appBgColor,
      padding: EdgeInsets.only(top: ScreenUtil.L(5)),
      child: EasyRefresh(
        onRefresh: () async {
          await _getHomeData();
        },
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 轮播图
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

  /// 我要刷题页面布局
  Widget _shuatiWidget() {
    return Container(
      color: KColorConstant.appBgColor,
      padding: EdgeInsets.only(top: ScreenUtil.L(5)),
      child: EasyRefresh(
        onRefresh: () async {
          await _getHomeData();
        },
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SwiperWidget(images: data.bannerManageList),
              Container(
                margin: EdgeInsets.all(ScreenUtil.L(10)),
                child: Row(
                  children: <Widget>[
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
                            (ScreenUtil.screenWidth! - ScreenUtil.L(25)) / 2 -
                            1,
                        child: Image.asset("images/shuatitop1.png"),
                      ),
                    ),
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
                            (ScreenUtil.screenWidth! - ScreenUtil.L(25)) / 2 +
                            1,
                        child: Image.asset("images/shuatitop2.png"),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: ScreenUtil.L(12)),
                child: Text("试题分科", style: KFontConstant.blackTextBigBold()),
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

  /// 生成试题项的 widget
  _shitiItems() {
    // ignore: prefer_is_empty
    if (testHomeData == null || testHomeData?.length == 0) {
      return baseStatueWidget(LoadingWidgetStatue.DATAEMPTY);
    }
    List<Widget> widgets = [];
    for (int i = 0; i < testHomeData!.length; i++) {
      widgets.add(
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => XuanzhetiWidget("${testHomeData?[i].id}"),
              ),
            );
          },
          child: ShitiItem(data: testHomeData?[i]),
        ),
      );
    }
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      children: widgets,
    );
  }

  /// 生成课程项的 widget
  _kechengItems() {
    List<Widget> widgets = [];
    for (int i = 0; i < data.courseManageList!.length; i++) {
      widgets.add(KechengItem(data: data.courseManageList![i]));
    }
    return widgets;
  }

  /// 生成视频项的 widget
  _videoItems() {
    List<Widget> widgets = [];
    for (int i = 0; i < data.videoManageList!.length; i++) {
      widgets.add(VideoItem(data.videoManageList?[i]));
    }
    return widgets;
  }

  /// 创建列表标题组件
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
