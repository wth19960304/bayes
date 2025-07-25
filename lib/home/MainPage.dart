import 'package:bayes/base/base_inner_widget.dart';
import 'package:bayes/base/base_widget.dart';
import 'package:bayes/constant/color.dart';
import 'package:bayes/network/intercept/showloading_intercept.dart';
import 'package:bayes/network/requestUtil.dart';
import 'package:bayes/pages/MinePage.dart';
import 'package:bayes/pages/StudyPage.dart';
import 'package:bayes/widget/bottombar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// APP主界面
class MainPage extends BaseWidget {
  const MainPage({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _MainPageState();
  }
}

/// 主界面的状态管理类
class _MainPageState extends BaseWidgetState<MainPage> {
  /// 用于控制页面切换的PageController
  late PageController pageController;

  /// 当前所在的页面索引
  int currentPage = 0;

  /// 存储各个页面的widget列表
  late List<BaseInnerWidget> widgets;

  @override
  Widget buildWidget(BuildContext context) {
    /// 初始化页面widget列表
    widgets = [StudyPage(), MinePage()];

    /// 返回主界面的Scaffold结构
    return Scaffold(
      /// 底部导航栏配置
      bottomNavigationBar: KKBottomAppBar(
        actviveColor: KColorConstant.themeColorDark,
        onTabSeleted: onTap,
        color: KColorConstant.greyColor,
        items: [
          /// 学习页面的底部导航栏项
          BottomAppBarItemModal(
            "images/xuexi_noselect.png",
            "images/xuexi_select.png",
            "学习",
          ),
          // /// 吐槽中心页面的底部导航栏项（注释掉了）
          // BottomAppBarItemModal(
          //   "images/tucao_noselect.png",
          //   "images/tucao_select.png",
          //   "吐槽中心",
          // ),
          /// 个人中心页面的底部导航栏项
          BottomAppBarItemModal(
            "images/mine_noselect.png",
            "images/mine_select.png",
            "个人中心",
          ),
        ],
      ),

      /// 页面内容区域，使用IndexedStack根据currentPage显示对应的widget
      body: IndexedStack(index: currentPage, children: widgets),
    );
  }

  /// 处理底部导航栏的点击事件，更新当前页面索引
  void onTap(int index) {
    // 手动调生命周期
    // widgets[currentPage].baseInnerWidgetState.onPause();
    // widgets[index].baseInnerWidgetState.onResume();
    setState(() {
      currentPage = index;
    });
  }

  @override
  void onCreate() {
    /// 设置顶部栏可见
    setTopBarVisible(true);

    /// 设置应用栏不可见
    setAppBarVisible(false);

    /// 添加日志请求
    RequestMap.addRecordLog(ShowLoadingIntercept(this, isInit: true), {"": ""});

    /// 检查存储权限
    _checkPersmission();
  }

  /// 是否暂停状态
  bool isPaush = false;

  @override
  void onPause() {
    isPaush = true;
    // widgets[currentPage].baseInnerWidgetState.onPause();
  }

  @override
  void onResume() {
    if (isPaush) {
      // widgets[currentPage].baseInnerWidgetState.onResume();
    }
  }

  /// 检查存储权限
  void _checkPersmission() async {
    /// 如果是Web平台，直接返回
    if (kIsWeb) {
      return;
    }

    /// 请求存储权限
    bool hasPermission = await Permission.storage.request().isGranted;

    /// 如果权限被拒绝，显示提示信息
    if (!hasPermission) {
      showToast("您拒绝了我们获取储存权限，请前往[设置-应用管理-权限获取]打开权限");
      return;
    }
  }
}
