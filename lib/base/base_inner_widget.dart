import 'package:flutter/material.dart';

import 'common_function.dart';

///通常是和 viewpager 联合使用  ， 类似于Android 中的 fragment
/// 不过生命周期 还需要在容器父类中根据tab切换来完善
// ignore: must_be_immutable
abstract class BaseInnerWidget extends StatefulWidget {
  late BaseInnerWidgetState baseInnerWidgetState;
  late int index;

  BaseInnerWidget({super.key});

  @override
  // ignore: no_logic_in_create_state
  BaseInnerWidgetState createState() {
    baseInnerWidgetState = getState();
    index = setIndex();
    return baseInnerWidgetState;
  }

  ///作为内部页面 ， 设置是第几个页面 ，也就是在list中的下标 ， 方便 生命周期的完善
  int setIndex();

  BaseInnerWidgetState getState();

  String getStateName() {
    return baseInnerWidgetState.getClassName();
  }
}

abstract class BaseInnerWidgetState<T extends BaseInnerWidget> extends State<T>
    with AutomaticKeepAliveClientMixin, BaseFunction {
  @override
  void initState() {
    initBaseCommon(this, context);
    setTopBarVisible(false);
    setAppBarVisible(false);
    onCreate();
    onResume();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    bottomVsrtical = getVerticalMargin();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: getBaseView(context),
    );
  }

  @override
  void dispose() {
    onDestory();
    //    HttpManager.cancelHttp(getClassName()); //取消网络请求
    super.dispose();
  }

  ///返回作为内部页面，垂直方向 头和底部 被占用的 高度
  double getVerticalMargin();

  @override
  bool get wantKeepAlive => true;

  ///为了完善生命周期而特意搞得 方法 ， 手动调用 onPause 和onResume
  void changePageVisible(int index, int preIndex) {
    if (index != preIndex) {
      if (preIndex == widget.index) {
        onPause();
      } else if (index == widget.index) {
        onResume();
      }
    }
  }
}
