import 'package:bayes/base/common_function.dart';
import 'package:bayes/base/navigator_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 所有页面的基类，继承自StatefulWidget
/// 提供统一的页面生命周期管理和导航控制
// ignore: must_be_immutable
abstract class BaseWidget extends StatefulWidget {
  const BaseWidget({super.key});

  @override
  // ignore: no_logic_in_create_state
  BaseWidgetState createState() {
    // ignore: no_logic_in_create_state
    return getState(); // 获取子类实现的状态对象
  }

  /// 抽象方法，子类必须实现以返回对应的状态类
  BaseWidgetState getState();
}

/// 页面状态基类，管理页面生命周期和状态
/// [T] 泛型参数，必须是BaseWidget的子类
abstract class BaseWidgetState<T extends BaseWidget> extends State<T>
    with WidgetsBindingObserver, BaseFunction {
  bool _onResumed = false; // 标记页面是否已显示
  bool _onPause = false; // 标记页面是否已暂停
  late DateTime lastPopTime; // 记录最后一次返回按键时间

  @override
  void initState() {
    super.initState();
    initBaseCommon(this, context); // 初始化基础功能
    NavigatorManger().addWidget(this); // 将当前页面添加到导航管理器
    WidgetsBinding.instance.addObserver(this); // 添加应用生命周期观察者
    onCreate(); // 调用页面创建回调
  }

  @override
  // 依赖变化时触发
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    // 组件从树中移除时调用
    // 处理页面切换时的状态变化
    if (NavigatorManger().isSecondTop(this)) {
      if (!_onPause) {
        onPause(); // 页面暂停回调
        _onPause = true;
      } else {
        onResume(); // 页面恢复回调
        _onPause = false;
      }
    } else if (NavigatorManger().isTopPage(this)) {
      if (!_onPause) {
        onPause(); // 页面暂停回调
      }
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    // 初次加载时触发onResume
    if (!_onResumed) {
      if (NavigatorManger().isTopPage(this)) {
        _onResumed = true;
        onResume(); // 页面显示回调
      }
    }

    // 特殊处理LoginPage和MainPage的返回按钮逻辑
    if (getClassName() == "LoginPage" || getClassName() == "MainPage") {
      return PopScope(
        canPop: true,
        // ignore: deprecated_member_use
        onPopInvoked: (bool didPop) async {
          // 双击返回退出应用逻辑
          if (DateTime.now().difference(lastPopTime) > Duration(seconds: 2)) {
            lastPopTime = DateTime.now();
            showToast("再按一次退出");
          } else {
            lastPopTime = DateTime.now();
            // 调用原生方法退出应用
            await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: getBaseView(context), // 获取页面主体内容
          floatingActionButton: FloatingAction(), // 悬浮按钮
        ),
      );
    }

    // 普通页面布局
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: getBaseView(context), // 获取页面主体内容
      floatingActionButton: FloatingAction(), // 悬浮按钮
    );
  }

  @override
  void dispose() {
    onDestory(); // 页面销毁回调
    WidgetsBinding.instance.removeObserver(this); // 移除生命周期观察者
    _onResumed = false;
    _onPause = false;
    NavigatorManger().removeWidget(this); // 从导航管理器移除当前页面
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // 处理应用前后台切换
    if (state == AppLifecycleState.resumed) {
      if (NavigatorManger().isTopPage(this)) {
        onForeground(); // 应用回到前台回调
        onResume(); // 页面恢复回调
      }
    } else if (state == AppLifecycleState.paused) {
      if (NavigatorManger().isTopPage(this)) {
        onBackground(); // 应用进入后台回调
        onPause(); // 页面暂停回调
      }
    }
    super.didChangeAppLifecycleState(state);
  }
}
