import 'package:bayes/base/base_widget.dart';
import 'package:bayes/constant/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class MeInfoPage extends BaseWidget {
  MeInfoPage({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _MeInfoPageState();
  }
}

class _MeInfoPageState extends BaseWidgetState {
  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().L(15)),
      child: Text(
        "承诺：<贝叶斯数学>包含高中数学全部三阶课程（基础篇+题型篇+冲刺篇）永久免费\n\n"
        " 如果有意见，请发送到邮箱：luojunfuture@gmail.com\n\n"
        "****注意事项****\n\n"
        "1：不可发布、传送、传播、储存违反国家法律、危害国家安全统一、社会稳定、公序良俗、社会公德以及侮辱、诽谤、淫秽、暴力的内容；\n\n"
        "2：不可发布、传送、传播、储存侵害他人名誉权、肖像权、知识产权、商业秘密等合法权利的内容；\n\n"
        "3：禁止虚构事实、隐瞒真相以误导、欺骗他人；\n\n"
        "4：禁止发表、传送、传播广告信息及垃圾信息；\n\n"
        "5：禁止其他违反法律法规、政策及公序良俗、社会公德等的行为。\n\n",
        style: KFontConstant.defaultText(),
      ),
    );
  }

  @override
  void onCreate() {
    setTopBarVisible(true);
    setAppBarVisible(true);
    setAppBarTitle("使用协议");
  }

  @override
  void onPause() {}

  @override
  void onResume() {}
}
