import 'package:bayes/base/base_inner_widget.dart';
import 'package:bayes/base/base_widget.dart';
import 'package:bayes/constant/color.dart';
import 'package:bayes/network/intercept/showloading_intercept.dart';
import 'package:bayes/network/requestUtil.dart';
import 'package:bayes/widget/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

///APP主界面
class MainPage extends BaseWidget {
  const MainPage({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _MainPageState();
  }
}

class _MainPageState extends BaseWidgetState<MainPage> {
  late PageController pageController;
  int currentPage = 0;
  late List<BaseInnerWidget> widgets;

  @override
  Widget buildWidget(BuildContext context) {
    widgets = [
      // StudyPage(), ComplaintsPage(), MinePage()
    ];
    return Scaffold(
      bottomNavigationBar: KKBottomAppBar(
        actviveColor: KColorConstant.themeColorDark,
        onTabSeleted: onTap,
        color: KColorConstant.greyColor,
        items: [
          BottomAppBarItemModal(
            "images/xuexi_noselect.png",
            "images/xuexi_select.png",
            "学习",
          ),
          BottomAppBarItemModal(
            "images/tucao_noselect.png",
            "images/tucao_select.png",
            "吐槽中心",
          ),
          BottomAppBarItemModal(
            "images/mine_noselect.png",
            "images/mine_select.png",
            "个人中心",
          ),
        ],
      ),
      body: IndexedStack(index: currentPage, children: widgets),
    );
  }

  void onTap(int index) {
    //手动调生命周期
    // widgets[currentPage].baseInnerWidgetState.onPause();
    // widgets[index].baseInnerWidgetState.onResume();
    setState(() {
      currentPage = index;
    });
  }

  @override
  void onCreate() {
    setTopBarVisible(true);
    setAppBarVisible(false);
    RequestMap.addRecordLog(ShowLoadingIntercept(this, isInit: true), {"": ""});
    _checkPersmission();
  }

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

  void _checkPersmission() async {
    bool hasPermission = await Permission.storage.request().isGranted;
    if (!hasPermission) {
      showToast("您拒绝了我们获取储存权限，请前往[设置-应用管理-权限获取]打开权限");
      return;
    }
  }
}
