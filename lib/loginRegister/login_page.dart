import 'package:bayes/base/base_widget.dart';

///登录
// ignore: must_be_immutable
class LoginPage extends BaseWidget {
  LoginPage({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends BaseWidgetState<LoginPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  var key;
  bool phoneError = false;

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "images/login_bg.png",
          height: getImageHeight(750, 404, ScreenUtil.screenWidth),
          width: ScreenUtil.screenWidth,
          fit: BoxFit.fill,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                left: ScreenUtil().L(30),
                right: ScreenUtil().L(30),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "images/login_logo.png",
                      height: getImageHeight(202, 255, ScreenUtil().L(100)),
                      width: ScreenUtil().L(100),
                      fit: BoxFit.fill,
                    ),
                    margin: EdgeInsets.only(top: ScreenUtil().L(35)),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    child: Text("欢迎来到贝叶斯数学", style: KFontConstant.grayText()),
                    margin: EdgeInsets.only(top: ScreenUtil().L(10)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: ScreenUtil().L(30)),
                    child: TextField(
                      style: KFontConstant.blackTextBig(),
                      controller: userController,
                      maxLength: 11,
                      decoration: inputDecoration(
                        label: "手机号码",
                        errorString: "手机号码格式错误",
                        error: phoneError,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: ScreenUtil().L(10)),
                    child: TextField(
                      obscureText: true,
                      style: KFontConstant.blackTextBig(),
                      controller: pwdController,
                      decoration: inputDecoration(
                        label: "密码",
                        errorString: "",
                        error: false,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: ScreenUtil().L(30),
                      left: ScreenUtil().L(30),
                      right: ScreenUtil().L(30),
                    ),
                    child: raisedNextButton("登录"),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: ScreenUtil().L(20),
                      left: ScreenUtil().L(30),
                      right: ScreenUtil().L(30),
                    ),
                    child: raisedNextButton("注册", buttonTag: 1),
                  ),
                ],
              ),
            ),
            _wxLoginWidget(),
          ],
        ),
      ],
    );
  }

  bool wxChatInstalled = true;

  //是否安装了微信
  bool isWeChatInstalled = true;
  bool isQQInstalled = true;

  _initFluwx() async {
    await fluwx.registerWxApi(
      appId: "wxa4a5f5d0d85630a2",
      doOnAndroid: true,
      doOnIOS: true,
    );
    //是否安装了微信
    isWeChatInstalled = await fluwx.isWeChatInstalled;
  }

  _initFluQQ() async {
    FlutterQq.registerQQ('101887594');
    isQQInstalled = await FlutterQq.isQQInstalled();
  }

  _fluQQLogin() async {
    try {
      var qqResult = await FlutterQq.login();
      String output;
      if (qqResult.code == 0) {
        output = "登录成功${qqResult.response}";
        _qqLoginHttp(
          openid: qqResult.response['openid'],
          code: qqResult.response['accessToken'],
        );
      } else if (qqResult.code == 1) {
        output = "登录失败" + qqResult.message;
      } else {
        output = "用户取消";
      }
      print(output);
    } catch (error) {
      print("flutter_plugin_qq_example:$error");
    }
  }

  void _wxLogin() {
    //发起用户授权
    fluwx
        .sendWeChatAuth(scope: "snsapi_userinfo", state: "wechat_sdk_demo_test")
        .then((data) {});
  }

  bool select = true;

  ///微信登录
  _wxLoginWidget() {
    //未安装微信时不显示微信登录按钮
    if (!wxChatInstalled) {
      return Container();
    }
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().L(5)),
                child: Text(
                  "------ 其它登录方式 ------",
                  style: KFontConstant.grayText(),
                ),
              ),
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      _weixinLogin();
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: ScreenUtil().L(50),
                          width: ScreenUtil().L(50),
                          padding: EdgeInsets.all(ScreenUtil().L(10)),
                          child: Image.asset("images/icon_wx.png"),
                        ),
                        Text("微信登录", style: KFontConstant.grayText_small()),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: ScreenUtil().L(40)),
                    child: InkWell(
                      onTap: () {
                        _qqLogin();
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: ScreenUtil().L(45),
                            width: ScreenUtil().L(45),
                            padding: EdgeInsets.all(ScreenUtil().L(10)),
                            child: Image.asset("images/icon_qq.png"),
                          ),
                          Text("QQ登录", style: KFontConstant.grayText_small()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(height: ScreenUtil().L(10)),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
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
                      width: ScreenUtil().L(30),
                    ),
                  ),
                  Text("我已阅读并同意"),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MeInfoPage(),
                        ),
                      );
                    },
                    child: Text("《用户协议》", style: KFontConstant.themeText()),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => TextPage()),
                      );
                    },
                    child: Text("《隐私政策》", style: KFontConstant.themeText()),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///微信登录
  _weixinLogin() {
    if (!select) {
      showToast("请阅读并同意用户与隐私协议");
      return;
    }
    _wxLogin();
  }

  ///微信登录
  _loginToWx({String code}) {
    var formData = {"code": code, "type": "APP"};
    RequestMap.weChatLogin(ShowLoadingIntercept(this), formData).listen(
      (da) {
        if (da.data.openId != null && da.data.openId != "") {
          //前往绑定手机号码界面
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterPhonePage(
                openId: "${da.data.openId}",
                nickname: da.data.nickname,
                headImg: da.data.headImg,
              ),
            ),
          );
          return;
        }
        _loginSuncess(da);
      },
      onError: (err) {
        showToast("${err.message}");
      },
    );
  }

  ///QQ登录
  _qqLoginHttp({String code, String openid}) {
    var formData = {"accessToken": code, "openid": openid};
    print(formData);
    RequestMap.qqLogin(ShowLoadingIntercept(this), formData).listen(
      (da) {
        if (da.data.openId != null && da.data.openId != "") {
          //前往绑定手机号码界面
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterPhonePage(
                openId: "${da.data.openId}",
                nickname: da.data.nickname,
                headImg: da.data.headImg,
                isQQ: true,
              ),
            ),
          );
          return;
        }
        _loginSuncess(da);
      },
      onError: (err) {
        showToast("${err.message}");
      },
    );
  }

  _loginSuncess(LoginBean da) {
    SpUtils().setString(SpConstanst.USER_TOKEN, da.data.token);
    SpUtils().setString(SpConstanst.USER_PWD, pwdController.text);
    SpUtils().setString(SpConstanst.USER_NAME, userController.text);
    showToast("登录成功");

    if (da.data.user == null || da.data.user.position == "") {
      //前往完善资料界面
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FirstUserInfoPage(login: true),
        ),
      );
      return;
    }
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainPage()),
    );
  }

  ///QQ登录
  _qqLogin() {
    if (!select) {
      showToast("请阅读并同意用户与隐私协议");
      return;
    }
    _fluQQLogin();
  }

  @override
  btnNext(int buttonTag) {
    if (buttonTag == 0) {
      if (!select) {
        showToast("请阅读并同意用户与隐私协议");
        return;
      }
      _login();
    } else if (buttonTag == 1) {
      //前往注册界面
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterPhonePage()),
      );
    }
  }

  ///登录
  _login() {
    if (pwdController.text.length == 0) {
      showToast("密码不能为空");
      return;
    }
    if (userController.text.length < 11) {
      showToast("账号不能为空");
      setState(() {
        phoneError = true;
      });
      return;
    } else {
      setState(() {
        phoneError = false;
      });
    }
    String phoneNum, password;
    phoneNum = userController.text;
    password = pwdController.text;
    Map<String, dynamic> formData = {
      "phoneNum": phoneNum,
      "password": password,
    };
    print("value -- ${formData.toString()}");

    RequestMap.loginIn(ShowLoadingIntercept(this), formData).listen(
      (da) {
        _loginSuncess(da);
      },
      onError: (err) {
        showToast("${err.message}");
      },
    );
  }

  @override
  void onCreate() {
    setAppBarVisible(false);
    setFloatingShow(false);
    userController.text = SpUtils().getString(SpConstanst.USER_NAME);
    pwdController.text = SpUtils().getString(SpConstanst.USER_PWD);
    SpUtils().setString(SpConstanst.USER_TOKEN, "");
    SpUtils().setString(SpConstanst.USER_ID, "");
    _initFluwx();
    _initFluQQ();
    //监听获取code的回调
    fluwx.weChatResponseEventHandler.distinct((a, b) => a == b).listen((res) {
      if (res is fluwx.WeChatAuthResponse) {
        setState(() {
          if (res.errCode == 0) {
            _loginToWx(code: res.code);
            //            getAccToken(res.code).then((data) {
            //              print(data.toString());
            //              var datas = json.decode(data.toString());
            //              String access_token = datas["access_token"];
            //              String openId = datas["openid"];
            //              SpUtils().setString(SpConstanst.WX_ACCESS_TOKEN, access_token);
            //              showToast("$access_token");
            //            });
          }
        });
      }
    });
  }

  @override
  void onPause() {}

  @override
  void onResume() {}

  @override
  void onDestory() {
    super.onDestory();
    pwdController = null;
    userController = null;
  }
}
