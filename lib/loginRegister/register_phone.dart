import 'package:bayes/base/base_widget.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/loginRegister/register_code.dart';
import 'package:bayes/network/intercept/showloading_intercept.dart';
import 'package:bayes/network/requestUtil.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:flutter/material.dart';

///手机号码验证
// ignore: must_be_immutable
class RegisterPhonePage extends BaseWidget {
  String? openId, nickname, headImg;
  bool isQQ;

  RegisterPhonePage({
    super.key,
    this.openId,
    this.nickname,
    this.headImg,
    this.isQQ = false,
  });

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _RegisterPhonePageState();
  }
}

class _RegisterPhonePageState extends BaseWidgetState<RegisterPhonePage> {
  TextEditingController? userController = TextEditingController();

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
              child: Text("设置账号", style: KFontConstant.blackBigBigText()),
            ),
            Container(
              margin: EdgeInsets.only(
                left: ScreenUtil.L(30),
                top: ScreenUtil.L(10),
              ),
              alignment: Alignment.topLeft,
              child: Text(
                "请输入您的手机号码，注册/绑定您的APP账号",
                style: KFontConstant.grayText(),
              ),
            ),
            Container(
              margin: EdgeInsets.all(ScreenUtil.L(30)),
              child: TextField(
                style: KFontConstant.blackTextBig(),
                controller: userController,
                maxLength: 11,
                decoration: inputDecoration(
                  label: "手机号码",
                  errorString: "手机号码格式错误",
                  error: false,
                ),
              ),
            ),
            Container(
              // ignore: sort_child_properties_last
              child: raisedNextButton("获取验证码"),
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

  ///发送验证码
  _sendCode(String phone) {
    var formData = {
      "phoneNum": phone,
      "type": widget.isQQ ? "3" : "2",
    }; //1 注册，2绑定微信，3绑定QQ

    RequestMap.sendCode(ShowLoadingIntercept(this), formData).listen(
      (da) {
        Navigator.of(context).pop();
        //前往注册界面
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterCodePage(
              phone,
              openId: widget.openId,
              nickname: widget.nickname,
              headImg: widget.headImg,
              isQQ: widget.isQQ,
              isBind: da.data == "1",
            ),
          ),
        );
      },
      onError: (error) {
        showToast("${error.message}");
      },
    );
  }

  @override
  void btnNext(int buttonTag) {
    super.btnNext(buttonTag);
    if (userController!.text.length < 11) {
      showToast("手机号码格式不正确");
      return;
    }
    _sendCode(userController!.text);
  }

  @override
  void onCreate() {
    setAppBarVisible(false);
    setFloatingShow(false);
  }

  @override
  void onDestory() {
    super.onDestory();
    userController = null;
  }

  @override
  void onPause() {}

  @override
  void onResume() {}
}
