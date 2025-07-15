import 'dart:core';

import 'package:bayes/base/build_config.dart';
import 'package:bayes/base/common_function%20copy.dart';
import 'package:bayes/constant/color.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/constant/style.dart';
import 'package:bayes/dialog/loading_dialog.dart';
import 'package:bayes/dialog/share_dialog.dart';
import 'package:bayes/loginRegister/login_page.dart';
import 'package:bayes/network/intercept/showloading_intercept.dart';
import 'package:bayes/network/requestUtil.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

/// base 类 常用的一些工具类 ， 放在这里就可以了
abstract mixin class BaseFunction {
  late State _stateBaseFunction;
  late BuildContext _contextBaseFunction;

  bool _isTopBarShow = false; //状态栏是否显示
  bool _isAppBarShow = true; //导航栏是否显示

  Color _topBarColor = KColorConstant.white;
  Color _appBarContentColor = KColorConstant.white;
  String _backIcon = "images/left_go.png";

  late String _appBarTitle;

  //小标题信息
  late String _appBarRightTitle;

  double bottomVsrtical = 0; //作为内部页面距离底部的高度

  String noDataString = "暂无数据";
  String errorString = "加载错误，请稍后再试";

  void initBaseCommon(State state, BuildContext context) {
    _stateBaseFunction = state;
    _contextBaseFunction = context;
    if (BuildConfig.isDebug) {
      _appBarTitle = getClassName();
      _appBarRightTitle = "";
    }
  }

  void setNoDataString(String value) {
    // ignore: invalid_use_of_protected_member
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      noDataString = value;
    });
  }

  void setErrorString(String value) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      errorString = value;
    });
  }

  Widget getBaseView(BuildContext context) {
    return Column(
      children: <Widget>[
        _getBaseTopBar(),
        _getBaseAppBar(),
        Container(
          width: getScreenWidth(),
          height: getMainWidgetHeight(),
          color: KColorConstant.appBgColor, //背景颜色，可自己变更
          child: buildWidget(context),
        ),
      ],
    );
  }

  bool floatingShow = true;

  setFloatingShow(bool value) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      floatingShow = value;
    });
  }

  //悬浮按钮
  // ignore: non_constant_identifier_names
  Widget? FloatingAction() {
    if (floatingShow == false) {
      return null;
    } else {
      return Container(
        margin: EdgeInsets.only(bottom: ScreenUtil.L(50)),
        child: FloatingActionButton(
          child: Text("吐槽", style: KFontConstant.whiteTextBig()),
          onPressed: () {
            goTucao();
          },
        ),
      );
    }
  }

  goTucao() {
    getUserInfo();
  }

  ///获取用户信息
  getUserInfo() {
    var formData = {"page": "1"};
    RequestMap.getUserInfo(
      ShowLoadingIntercept(this as BaseFuntion, isInit: true),
      formData,
    ).listen(
      (data) {
        if (data.data.state == "1") {
          showToast("您的账号没有权限，详情前往消息中心查看", length: Toast.LENGTH_LONG);
          return;
        } else {
          _checkPersmission();
        }
      },
      onError: (err) {
        showToast(err.message);
      },
    );
  }

  void _checkPersmission() async {
    bool hasPermission = await Permission.storage.request().isGranted;
    if (!hasPermission) {
      showToast("您拒绝了我们获取储存权限，请前往[设置-应用管理-权限获取]打开权限再进行吐槽");
      return;
    }
    //前往吐槽界面
    Navigator.push(
      // ignore: use_build_context_synchronously
      _contextBaseFunction,
      MaterialPageRoute(
        builder: (context) =>
            // ComplaintsReleasePage()
            Text("wth"),
      ),
    );
  }

  Widget _getBaseTopBar() {
    return Offstage(offstage: !_isTopBarShow, child: getTopBar());
  }

  Widget _getBaseAppBar() {
    return Offstage(offstage: !_isAppBarShow, child: getAppBar());
  }

  ///设置状态栏，可以自行重写拓展成其他的任何形式
  Widget getTopBar() {
    return Container(
      height: getTopBarHeight(),
      width: double.infinity,
      color: _topBarColor,
    );
  }

  ///点击错误页面后展示内容
  void onClickErrorWidget() {}

  ///导航栏appBar中间部分 ，不满足可以自行重写
  Widget getAppBarCenter() {
    return Text(_appBarTitle, style: KFontConstant.appBarTiltleBigBold());
  }

  ///导航栏appBar中间部分 ，不满足可以自行重写
  Widget getAppBarRight() {
    return Text(
      _appBarRightTitle,
      style: TextStyle(fontSize: 14, color: _appBarContentColor),
    );
  }

  ///导航栏appBar左边部分 ，不满足可以自行重写
  Widget getAppBarLeft() {
    return InkWell(
      onTap: clickAppBarBack,
      child: Container(
        height: ScreenUtil.L(40),
        width: ScreenUtil.L(40),
        margin: EdgeInsets.only(top: ScreenUtil.L(5)),
        padding: EdgeInsets.only(
          left: ScreenUtil.L(12),
          right: ScreenUtil.L(8),
        ),
        child: Image.asset(_backIcon),
      ),
    );
  }

  void clickAppBarBack() {
    if (Navigator.canPop(_contextBaseFunction)) {
      Navigator.pop(_contextBaseFunction);
    } else {
      //说明已经没法回退了 ， 可以关闭了
      finishDartPageOrApp();
    }
  }

  ///返回中间可绘制区域，也就是 我们子类 buildWidget 可利用的空间高度
  double getMainWidgetHeight() {
    double screenHeight = getScreenHeight() - bottomVsrtical;
    if (_isTopBarShow) {
      screenHeight = screenHeight - getTopBarHeight();
    }
    if (_isAppBarShow) {
      screenHeight = screenHeight - getAppBarHeight();
    }
    return screenHeight;
  }

  ///返回屏幕高度
  double getScreenHeight() {
    return MediaQuery.of(_contextBaseFunction).size.height;
  }

  ///返回状态栏高度
  double getTopBarHeight() {
    return MediaQuery.of(_contextBaseFunction).padding.top;
  }

  ///返回appbar高度，也就是导航栏高度
  double getAppBarHeight() {
    return ScreenUtil.L(50);
  }

  ///返回屏幕宽度
  double getScreenWidth() {
    return MediaQuery.of(_contextBaseFunction).size.width;
  }

  ///关闭最后一个 flutter 页面 ， 如果是原生跳过来的则回到原生，否则关闭app
  void finishDartPageOrApp() {
    SystemNavigator.pop();
  }

  ///加载中展示的布局
  Widget getLoadingWidget() {
    return SizedBox(
      height: ScreenUtil.screenHeight! - ScreenUtil.L(400),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  ///数据为空时展示的布局
  Widget getEmptyWidget() {
    return SizedBox(
      height: ScreenUtil.screenHeight! - ScreenUtil.L(400),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/dataempty.png", width: ScreenUtil.L(120)),
            Text(noDataString, style: KFontConstant.grayText()),
          ],
        ),
      ),
    );
  }

  ///加载出错时展示的布局
  Widget getLoadingErroeWidget() {
    return InkWell(
      onTap: () {
        onClickErrorWidget();
      },
      child: SizedBox(
        height: ScreenUtil.screenHeight! - ScreenUtil.L(400),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset("images/loadingerror.png", width: ScreenUtil.L(120)),
              Text(errorString, style: KFontConstant.grayText()),
            ],
          ),
        ),
      ),
    );
  }

  ///导航栏 appBar 可以重写
  Widget getAppBar() {
    return Container(
      height: getAppBarHeight(),
      width: double.infinity,
      color: _appBarContentColor,
      child: Stack(
        alignment: FractionalOffset(0, 0.5),
        children: <Widget>[
          Align(
            alignment: FractionalOffset(0.5, 0.5),
            child: getAppBarCenter(),
          ),
          Align(
            //左边返回导航 的位置，可以根据需求变更
            alignment: FractionalOffset(0.00, 0.0),
            child: getAppBarLeft(),
          ),
          Align(
            alignment: FractionalOffset(0.98, 0.5),
            child: getAppBarRight(),
          ),
        ],
      ),
    );
  }

  ///设置状态栏隐藏或者显示
  void setTopBarVisible(bool isVisible) {
    // ignore: invalid_use_of_protected_member
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _isTopBarShow = isVisible;
    });
  }

  ///默认这个状态栏下，设置颜色
  void setTopBarBackColor(Color color) {
    // ignore: invalid_use_of_protected_member
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _topBarColor = color;
    });
  }

  ///设置导航栏的字体以及图标颜色
  void setAppBarContentColor(Color contentColor) {
    // ignore: invalid_use_of_protected_member
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _appBarContentColor = contentColor;
    });
  }

  ///设置导航栏隐藏或者显示
  void setAppBarVisible(bool isVisible) {
    // ignore: invalid_use_of_protected_member
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _isAppBarShow = isVisible;
    });
  }

  ///默认这个导航栏下，设置颜色
  void setAppBarBackColor(Color color) {
    // ignore: invalid_use_of_protected_member
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {});
  }

  void setAppBarTitle(String title) {
    // ignore: invalid_use_of_protected_member
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _appBarTitle = title;
    });
  }

  void setAppBarRightTitle(String title) {
    // ignore: invalid_use_of_protected_member
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _appBarRightTitle = title;
    });
  }

  bool dialogShowIng = false;

  ///显示dialog isVisible 是否显示
  void showDiaolog(bool isVisible, bool init) {
    if (init) {
      dialogShowIng = false;
      return;
    }

    if (isVisible) {
      if (dialogShowIng) {
        Navigator.pop(_contextBaseFunction);
        dialogShowIng = false;
      }

      showDialog<Null>(
        context: _contextBaseFunction, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadingDialog(
            //调用对话框
            text: '正在加载...',
          );
        },
      );
      dialogShowIng = true;
    } else {
      Navigator.pop(_contextBaseFunction); //关闭dialog
      dialogShowIng = false;
    }
  }

  void setBackIcon({String backIcon = "images/back.png"}) {
    // ignore: invalid_use_of_protected_member
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _backIcon = backIcon;
    });
  }

  ///初始化一些变量 相当于 onCreate ， 放一下 初始化数据操作
  void onCreate();

  ///相当于onResume, 只要页面来到栈顶， 都会调用此方法，网络请求可以放在这个方法
  void onResume();

  ///页面被覆盖,暂停
  void onPause();

  ///返回UI控件 相当于setContentView()
  Widget buildWidget(BuildContext context);

  ///app切回到后台
  void onBackground() {
    log("回到后台");
  }

  ///app切回到前台
  void onForeground() {
    log("回到前台");
  }

  ///页面注销方法
  void onDestory() {
    log("destory");
  }

  void log(String content) {
    // ignore: avoid_print, prefer_interpolation_to_compose_strings
    print(getClassName() + "------:" + content);
  }

  String getClassName() {
    String className = _contextBaseFunction.toString();
    if (className.indexOf("(") <= 0) {
      return className;
    }
    className = className.substring(0, className.indexOf("("));
    return className;
  }

  ///弹吐司
  void showToast(
    String content, {
    Toast length = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.CENTER,
    Color backColor = Colors.black87,
    Color textColor = KColorConstant.white,
  }) {
    if (content.isNotEmpty) {
      Fluttertoast.showToast(
        msg: content,
        toastLength: length,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: backColor,
        textColor: textColor,
        fontSize: 13.0,
      );
    }
  }

  ///根据不同的状态返回不同的widget，全部居中显示
  Widget? baseStatueWidget(LoadingWidgetStatue pageStatue) {
    if (pageStatue == LoadingWidgetStatue.LOADING) {
      return Center(child: getLoadingWidget());
    }
    if (pageStatue == LoadingWidgetStatue.ERROR) {
      return Center(child: getLoadingErroeWidget());
    }
    if (pageStatue == LoadingWidgetStatue.DATAEMPTY) {
      return Center(child: getEmptyWidget());
    }
    return null;
  }

  ///判断错误是否是取消请求
  bool httpNoCancle(err) {
    return !(err.message == "DioError [DioErrorType.CANCEL]: ");
  }

  String millsTime2Time(String millisTime) {
    if (millisTime.length < 5) {
      return "--";
    }
    //带毫秒的时间
    String time = DateTime.fromMillisecondsSinceEpoch(
      int.parse(millisTime),
    ).toString();
    return time.substring(0, time.length - 4);
  }

  bool isShowlogin = true;

  ///登录过期，重新登录
  toLoginPage() {
    if (isShowlogin) {
      isShowlogin = false;
      showToast("登录过期了，重新登录");
      Navigator.push(
        _contextBaseFunction,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  /// 根据图片宽高比计算图片实际高度
  double getImageHeight(double imageWidth, double imageHeight, double width) {
    return (imageHeight / imageWidth) * width;
  }

  ///通用下一步按钮
  Widget raisedNextButton(String text, {int buttonTag = 0}) {
    return ElevatedButton(
      onPressed: () {
        btnNext(buttonTag);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent, // 移除textColor改用样式控制
        padding: EdgeInsets.zero, // 整合padding到样式
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        minimumSize: Size(0, 40), // 控制最小高度
      ),
      child: Container(
        height: ScreenUtil.L(40),
        decoration: buttonTag == 0
            ? KBoxStyle.nextBtn()
            : KBoxStyle.nextBtnGray(),
        child: Container(
          alignment: Alignment.center,
          child: Text(text, style: KFontConstant.whiteTextBig()),
        ),
      ),
    );
  }

  //下一步点击事件
  void btnNext(int buttonTag) {}

  ///统一输入框样式
  InputDecoration inputDecoration({
    required String label,
    required String errorString,
    bool error = false,
  }) {
    if (error) {
      return InputDecoration(labelText: label, errorText: errorString);
    } else {
      return InputDecoration(labelText: label);
    }
  }

  showShareDialog({
    required String title,
    required String type,
    required String id,
    required String videoType,
  }) {
    showDialog<int>(
      context: _contextBaseFunction, //BuildContext对象
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ShareDialog(
          title: title,
          type: type,
          id: id,
          videoType: videoType,
          url: '',
        );
      },
    );
  }
}

// ignore: constant_identifier_names
enum LoadingWidgetStatue { NONE, LOADING, ERROR, DATAEMPTY, NOTLOGIN }
