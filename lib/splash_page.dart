import 'dart:async';

import 'package:bayes/constant/color.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/constant/style.dart';
import 'package:bayes/dialog/yinshi_diaolog.dart';
import 'package:bayes/home/MainPage.dart';
import 'package:bayes/loginRegister/login_page.dart';
import 'package:bayes/pages/tv_page.dart';
import 'package:bayes/userInfo/MeInfoPage.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:bayes/utils/sp_constant.dart';
import 'package:bayes/utils/sp_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashPage> {
  // 是否为第一次打开应用的标记
  bool isFirst = false;
  // 是否同意隐私政策的标记
  bool select = true;

  // 处理启动页导航逻辑的方法
  void navigationPage() {
    setState(() {
      // 检查是否为第一次打开应用
      isFirst = SpUtils().getString("noFirstApp") != "true";
    });
    // 第一次打开APP，显示隐私提醒对话框
    if (isFirst) {
      showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return YinShiDialog();
        },
      ).then((value) {
        if (value != null && value == "right") {
          // 用户同意隐私政策，设置标记并继续导航
          SpUtils().setString("noFirstApp", "true");
          navigationPage();
        } else {
          // 用户拒绝，退出应用
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
      });
      return;
    }
    // 非第一次打开，检查用户是否已登录
    Navigator.of(context).pop();
    if (SpUtils().getString(SpConstanst.USER_TOKEN)?.isEmpty ?? true) {
      // 未登录，跳转到登录页面
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      // 已登录，跳转到主页面
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => MainPage()));
    }
  }

  @override
  void initState() {
    super.initState();

    // 启动时开始倒计时
    startTime();
  }

  // 设置启动页显示时间
  startTime() async {
    var duration = Duration(seconds: 1);

    return Timer(duration, navigationPage);
  }

  @override
  Widget build(BuildContext context) {
    // 初始化屏幕适配工具
    final ScreenUtil screenUtil = ScreenUtil.instance;
    screenUtil.init(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // 显示启动页背景图片
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: ScreenUtil.L(100)),
            child: Image.asset(
              'images/logo.png',
              fit: BoxFit.cover,
              width: ScreenUtil.L(100),
            ),
          ),
          // 隐私政策提示框，仅在第一次打开时显示
          Offstage(
            offstage: !isFirst,
            child: Align(
              alignment: FractionalOffset(0.5, 1),
              child: Container(
                color: Colors.transparent,
                height: ScreenUtil.L(140),
                child: Column(
                  children: <Widget>[
                    // 立即体验按钮
                    Container(
                      width: ScreenUtil.L(180),
                      margin: EdgeInsets.only(bottom: ScreenUtil.L(20)),
                      child: _raisedNextButtom(),
                    ),
                    // 隐私政策和用户协议链接
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        // 同意 checkbox
                        InkWell(
                          onTap: () {
                            setState(() {
                              select = !select;
                            });
                          },
                          child: Image.asset(
                            select
                                ? "images/icon_check_true.png"
                                : "images/icon_check_false.png",
                            width: ScreenUtil.L(30),
                          ),
                        ),
                        Text("我已阅读并同意"),
                        // 用户协议链接
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MeInfoPage(),
                              ),
                            );
                          },
                          child: Text(
                            "《用户协议》",
                            style: KFontConstant.themTitleBigBold(),
                          ),
                        ),
                        // 隐私政策链接
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => TextPage(),
                              ),
                            );
                          },
                          child: Text(
                            "《隐私政策》",
                            style: KFontConstant.themTitleBigBold(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 创建立即体验按钮
  Widget _raisedNextButtom() {
    return ElevatedButton(
      onPressed: () {
        if (select) {
          SpUtils().setString("noFirstApp", "true");
          navigationPage();
        } else {
          showToast("请阅读并同意以下政策");
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent, // 背景色透明（通过Container装饰控制）
        textStyle: KFontConstant.whiteTextBig(),
        padding: EdgeInsets.zero, // 替代原padding:0
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        elevation: 0, // 去除默认阴影
      ),
      child: Container(
        height: ScreenUtil.L(42),
        decoration: KBoxStyle.nextBtn(),
        padding: const EdgeInsets.all(10.0),
        child: Container(
          alignment: Alignment.center,
          child: Text("立即体验", style: KFontConstant.whiteTextBig()),
        ),
      ),
    );
  }

  // 显示Toast提示信息
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
        backgroundColor: backColor,
        textColor: textColor,
        fontSize: 13.0,
      );
    }
  }
}
