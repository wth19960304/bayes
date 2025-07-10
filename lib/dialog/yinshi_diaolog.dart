import 'package:bayes/constant/color.dart';
import 'package:bayes/constant/font.dart';
import 'package:flutter/material.dart';
import 'package:bayes/utils/screen_util.dart';

/// 隐私对话框
class YinShiDialog extends StatefulWidget {
  const YinShiDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _YinShiDialogState createState() => _YinShiDialogState();
}

/// 隐私对话框的状态管理类
class _YinShiDialogState extends State<YinShiDialog> {
  /// 用户服务协议的选中状态
  bool _select1 = false;

  /// 用户隐私协议的选中状态
  bool _select2 = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding:
          MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: SizedBox(
            width: ScreenUtil.L(260),
            height: ScreenUtil.L(260),
            child: Material(
              elevation: 24.0,
              color: Theme.of(context).dialogTheme.backgroundColor,
              type: MaterialType.card,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Container(
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil.L(8)),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildDialogTitle(),
                    _buildDividerOne(),
                    _buildDialogContent(context),
                    _buildDivider(),
                    _buildDialogButtons(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 构建对话框标题
  Widget _buildDialogTitle() {
    return Container(
      padding: EdgeInsets.all(ScreenUtil.L(15)),
      child: Text(
        "用户服务与隐私协议",
        style: KFontConstant.myTextStyle(size: 15, bold: true),
      ),
    );
  }

  /// 构建分割线
  Widget _buildDividerOne() {
    return Container(height: 0.5, color: KColorConstant.lineColor);
  }

  /// 构建对话框内容
  Widget _buildDialogContent(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(ScreenUtil.L(15)),
          child: Column(
            children: <Widget>[
              Text(
                "欢迎使用《贝叶斯数学》，请查看以下协议，点击[我已同意]按钮,代表您已阅读并同意以下协议。",
                style: KFontConstant.myTextStyle(
                  size: 15,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: ScreenUtil.L(10)),
              _buildCheckBoxRow('《用户服务协议》', () {
                setState(() {
                  _select1 = !_select1;
                });
              }, _select1),
              SizedBox(height: ScreenUtil.L(10)),
              _buildCheckBoxRow('《用户隐私协议》', () {
                setState(() {
                  _select2 = !_select2;
                });
              }, _select2),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建复选框行
  Widget _buildCheckBoxRow(String title, VoidCallback onTap, bool isSelected) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: onTap,
          child: Image.asset(
            isSelected
                ? "images/icon_check_true.png"
                : "images/icon_check_false.png",
            width: ScreenUtil.L(35),
          ),
        ),
        SizedBox(width: ScreenUtil.L(10)),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    // title == '《用户服务协议》' ? MeInfoPage() : TextPage(),
                    Text("22"),
              ),
            );
          },
          child: Text(
            title,
            style: KFontConstant.myTextStyle(
              size: 15,
              color: KColorConstant.themeColor,
            ),
          ),
        ),
      ],
    );
  }

  /// 构建对话框底部按钮
  Widget _buildDialogButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _buildCancelButton(),
        _buildDivider(),
        _buildConfirmButton(),
      ],
    );
  }

  /// 构建取消按钮
  Widget _buildCancelButton() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil.L(115),
        height: ScreenUtil.L(42),
        child: Text("退出app", style: KFontConstant.myTextStyle(size: 15)),
      ),
    );
  }

  /// 构建分割线
  Widget _buildDivider() {
    return Container(
      color: KColorConstant.lineColor,
      width: ScreenUtil.L(0.5),
      height: ScreenUtil.L(42),
    );
  }

  /// 构建确认按钮
  Widget _buildConfirmButton() {
    return InkWell(
      onTap: () {
        if (_select1 && _select2) {
          Navigator.of(context).pop("right");
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil.L(129.5),
        height: ScreenUtil.L(35),
        child: Text(
          "我已同意",
          style: KFontConstant.myTextStyle(
            color: _select1 && _select2
                ? KColorConstant.themeColor
                : KColorConstant.hintTextColor,
            size: 15,
            bold: true,
          ),
        ),
      ),
    );
  }
}
