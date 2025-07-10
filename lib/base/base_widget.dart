import 'package:bayes/base/common_function.dart';
import 'package:bayes/base/navigator_manger.dart';
import 'package:bayes/constant/length.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
abstract class BaseWidget extends StatefulWidget {
  late BaseWidgetState baseWidgetState;

  BaseWidget({super.key});

  @override
  // ignore: no_logic_in_create_state
  BaseWidgetState createState() {
    baseWidgetState = getState();
    return baseWidgetState;
  }

  BaseWidgetState getState();

  String getStateName() {
    return baseWidgetState.getClassName();
  }
}

abstract class BaseWidgetState<T extends BaseWidget> extends State<T>
    with WidgetsBindingObserver, BaseFunction {
  //平台信息
  //  bool isAndroid = Platform.isAndroid;

  bool _onResumed = false; //页面展示标记
  bool _onPause = false; //页面暂停标记

  @override
  void initState() {
    initBaseCommon(this, context);
    NavigatorManger().addWidget(this);
    WidgetsBinding.instance.addObserver(this);
    onCreate();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    if (NavigatorManger().isSecondTop(this)) {
      if (!_onPause) {
        onPause();
        _onPause = true;
      } else {
        onResume();
        _onPause = false;
      }
    } else if (NavigatorManger().isTopPage(this)) {
      if (!_onPause) {
        onPause();
      }
    }
    super.deactivate();
  }

  late DateTime lastPopTime;

  @override
  Widget build(BuildContext context) {
    if (!_onResumed) {
      //说明是 初次加载
      if (NavigatorManger().isTopPage(this)) {
        _onResumed = true;
        onResume();
      }
    }
    if (getClassName() == "LoginPage" || getClassName() == "MainPage") {
      // 新代码
      return PopScope(
        canPop: true,
        // ignore: deprecated_member_use
        onPopInvoked: (bool didPop) async {
          if (DateTime.now().difference(lastPopTime) > Duration(seconds: 2)) {
            lastPopTime = DateTime.now();
            showToast("再按一次退出");
          } else {
            lastPopTime = DateTime.now();
            // 退出应用
            await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: getBaseView(context),
          floatingActionButton: FloatingAction(),
        ),
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: getBaseView(context),
      floatingActionButton: FloatingAction(),
    );
  }

  @override
  void dispose() {
    onDestory();
    WidgetsBinding.instance.removeObserver(this);
    _onResumed = false;
    _onPause = false;
    //把该页面 从 页面列表中 去除
    NavigatorManger().removeWidget(this);
    //此处需要取消网络请求
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //此处可以拓展 是不是从前台回到后台
    if (state == AppLifecycleState.resumed) {
      //on resume
      if (NavigatorManger().isTopPage(this)) {
        onForeground();
        onResume();
      }
    } else if (state == AppLifecycleState.paused) {
      //onpause
      if (NavigatorManger().isTopPage(this)) {
        onBackground();
        onPause();
      }
    }
    super.didChangeAppLifecycleState(state);
  }
}
