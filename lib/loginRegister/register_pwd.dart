import 'package:bayes/base/base_widget.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/network/intercept/showloading_intercept.dart';
import 'package:bayes/network/requestUtil.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:flutter/material.dart';

///密码输入
// ignore: must_be_immutable
class RegisterPwdPage extends BaseWidget {
  String? phone;

  String? openId, nickname, headImg;
  bool? isQQ;

  RegisterPwdPage({
    super.key,
    this.phone,
    this.openId,
    this.nickname,
    this.headImg,
    this.isQQ,
  });

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _RegisterPwdPageState();
  }
}

class _RegisterPwdPageState extends BaseWidgetState<RegisterPwdPage> {
  TextEditingController pwdController1 = TextEditingController();
  TextEditingController pwdController2 = TextEditingController();

  bool pwd2Error = false;
  bool pwd1Error = false;

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "images/regi_bg.png",
          height: getImageHeight(750, 404, ScreenUtil.screenWidth ?? 0),
          width: ScreenUtil.screenWidth,
          fit: BoxFit.fill,
        ),
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: ScreenUtil.L(24)),
              alignment: Alignment.topLeft,
              child: getAppBarLeft(),
            ),
            Container(
              margin: EdgeInsets.only(
                left: ScreenUtil.L(30),
                top: ScreenUtil.L(15),
              ),
              alignment: Alignment.topLeft,
              child: Text("设置密码", style: KFontConstant.blackBigBigText()),
            ),
            Container(
              margin: EdgeInsets.only(
                left: ScreenUtil.L(30),
                top: ScreenUtil.L(10),
              ),
              alignment: Alignment.topLeft,
              child: Text(
                "密码长度为6-16位，不能包含特殊字符",
                style: KFontConstant.grayText(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: ScreenUtil.L(30),
                right: ScreenUtil.L(30),
                top: ScreenUtil.L(30),
                bottom: ScreenUtil.L(20),
              ),
              child: TextField(
                style: KFontConstant.blackTextBig(),
                controller: pwdController1,
                obscureText: true,
                maxLength: 16,
                decoration: inputDecoration(
                  label: "请输入密码",
                  errorString: "密码长度为6-16位",
                  error: pwd1Error,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: ScreenUtil.L(30),
                right: ScreenUtil.L(30),
                bottom: ScreenUtil.L(30),
              ),
              child: TextField(
                obscureText: true,
                maxLength: 16,
                style: KFontConstant.blackTextBig(),
                controller: pwdController2,
                decoration: inputDecoration(
                  label: "请再次输入密码",
                  errorString: "两次密码不一致",
                  error: pwd2Error,
                ),
              ),
            ),
            Container(
              // ignore: sort_child_properties_last
              child: raisedNextButton("提交"),
              margin: EdgeInsets.only(
                left: ScreenUtil.L(50),
                right: ScreenUtil.L(50),
                top: ScreenUtil.L(10),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void btnNext(int buttonTag) {
    super.btnNext(buttonTag);
    //两次密码是否一致
    setState(() {
      pwd2Error = !(pwdController2.text == pwdController1.text);
    });
    //密码长度是否符合规范
    setState(() {
      pwd1Error =
          !(pwdController1.text.length >= 6 &&
              pwdController1.text.length <= 16);
    });

    if (!pwd2Error && !pwd1Error) _userRegist();
  }

  ///提交注册
  _userRegist() {
    var formData = {
      "phoneNum": "${widget.phone}",
      "password": pwdController2.text,
      "nickname": "${widget.nickname}",
    };
    if (widget.isQQ ?? false) {
      formData['qqOpenId'] = "${widget.openId}";
      formData['headImg'] = '[{"url":"${widget.headImg}","name":"touxiang"}]';
    } else {
      formData['openid'] = "${widget.openId}";
    }
    print(formData.toString());
    RequestMap.userRegist(ShowLoadingIntercept(this), formData).listen(
      (da) {
        showToast("注册账号成功");
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('/login');
      },
      onError: (error) {
        print("${error.message}");
      },
    );
  }

  @override
  void onCreate() {
    setAppBarVisible(false);
    setFloatingShow(false);
  }

  @override
  void onPause() {}

  @override
  void onResume() {}
}
