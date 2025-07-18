import 'dart:async';

import 'package:bayes/base/base_widget.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/loginRegister/register_pwd.dart';
import 'package:bayes/network/intercept/showloading_intercept.dart';
import 'package:bayes/network/requestUtil.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:bayes/widget/CellInput.dart';
import 'package:flutter/material.dart';

///验证验证码
// ignore: must_be_immutable
class RegisterCodePage extends BaseWidget {
  String? phone;
  String? openId, nickname, headImg;
  bool? isQQ, isBind;

  RegisterCodePage(
    this.phone, {
    super.key,
    required this.openId,
    this.nickname,
    this.headImg,
    this.isQQ,
    this.isBind,
  });

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _RegisterCodePageState(phone);
  }
}

class _RegisterCodePageState extends BaseWidgetState<RegisterCodePage> {
  TextEditingController userController = TextEditingController();
  late String phone;

  _RegisterCodePageState(String? phone) {
    this.phone = phone!;
  }

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
              child: Text("验证码已发送至", style: KFontConstant.blackBigBigText()),
            ),
            Container(
              margin: EdgeInsets.only(
                left: ScreenUtil.L(30),
                top: ScreenUtil.L(10),
                right: ScreenUtil.L(30),
              ),
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(phone, style: KFontConstant.blackTextBig()),
                  InkWell(
                    onTap: () {
                      if (_codeCountdownStr == ("获取验证码")) {
                        _sendCode(phone);
                      }
                    },
                    child: Text(
                      _codeCountdownStr,
                      style: KFontConstant.blackTextBig(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(ScreenUtil.L(40)),
              child: CellInput(controller: userController, key: UniqueKey()),
            ),
            Container(
              margin: EdgeInsets.only(
                left: ScreenUtil.L(50),
                right: ScreenUtil.L(50),
              ),
              child: raisedNextButton("下一步"),
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
      "type": widget.isQQ != null ? (widget.isQQ! ? "3" : "2") : "2",
    };
    RequestMap.sendCode(ShowLoadingIntercept(this), formData).listen(
      (da) {
        widget.isBind = da.data == "1";
        showToast("验证码发送成功");
        reGetCountdown();
      },
      onError: (error) {
        showToast("${error.message}");
      },
    );
  }

  ///校验验证码
  _codeCheck(String phone, String code) {
    var formData = {"phoneNum": phone, "code": code};
    RequestMap.checkCode(ShowLoadingIntercept(this), formData).listen(
      (da) {
        if (widget.isBind != null && !widget.isBind!) {
          //前往注册
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterPwdPage(
                phone: phone,
                openId: widget.openId,
                nickname: widget.nickname,
                headImg: widget.headImg,
                isQQ: widget.isQQ,
              ),
            ),
          );
        } else {
          //绑定手机号码
          _bindPhone();
        }
      },
      onError: (error) {
        showToast("${error.message}");
      },
    );
  }

  @override
  void btnNext(int buttonTag) {
    super.btnNext(buttonTag);
    if (userController.text.length < 4) {
      showToast("验证码格式不正确");
      return;
    }
    _codeCheck(phone, userController.text);
  }

  ///绑定第三方登录账号
  _bindPhone() {
    var formData = {"phoneNum": phone};
    if (widget.isQQ ?? false) {
      formData['qqOpenId'] = "${widget.openId}";
    } else {
      formData['openid'] = "${widget.openId}";
    }
    print(formData);
    RequestMap.bindPhone(ShowLoadingIntercept(this), formData).listen(
      (da) {
        Navigator.of(context).pop();
        showToast("绑定成功");
      },
      onError: (error) {
        showToast("${error.message}");
      },
    );
  }

  Timer? _countdownTimer;
  String _codeCountdownStr = '获取验证码';
  int _countdownNum = 59;

  void reGetCountdown() {
    if (_countdownTimer != null && _countdownTimer!.isActive) {
      return;
    }
    print("1111111111111111111111");
    setState(() {
      // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
      _codeCountdownStr = '${_countdownNum--}S重新获取';
      _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (_countdownNum > 0) {
            _codeCountdownStr = '${_countdownNum--}S';
          } else {
            _codeCountdownStr = '获取验证码';
            _countdownNum = 59;
            _countdownTimer?.cancel();
            _countdownTimer = null;
          }
        });
      });
    });
  }

  @override
  void onDestory() {
    super.onDestory();
    _countdownTimer?.cancel();
  }

  @override
  void onCreate() {
    setAppBarVisible(false);
    setFloatingShow(false);
    reGetCountdown();
  }

  @override
  void onPause() {}

  @override
  void onResume() {}
}
