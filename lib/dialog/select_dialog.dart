import 'package:bayes/constant/color.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:flutter/material.dart';

///通用选中dialog  返回下标 index+1
// ignore: must_be_immutable
class SelectDialog extends StatelessWidget {
  //选中的第几个
  // ignore: prefer_final_fields
  late int _select = 0;
  final List<String> _data;
  final String _title;

  SelectDialog(this._select, this._data, this._title, {super.key});

  @override
  Widget build(BuildContext context) {
    Duration insetAnimationDuration = const Duration(milliseconds: 100);
    Curve insetAnimationCurve = Curves.decelerate;

    RoundedRectangleBorder defaultDialogShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    );

    return AnimatedPadding(
      padding:
          MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: SizedBox(
            width: ScreenUtil.L(240),
            height: ScreenUtil.L(
              (60.0 + _data.length * 45 > 360 ? 360 : 60.0 + _data.length * 45),
            ),
            child: Material(
              elevation: 24.0,
              // ignore: deprecated_member_use
              color: Theme.of(context).dialogBackgroundColor,
              type: MaterialType.card,
              //---------------下面是dialog布局----------------
              // ignore: sort_child_properties_last
              child: Container(
                decoration: ShapeDecoration(
                  color: Color(0xffffffff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        top: ScreenUtil.L(18),
                        left: ScreenUtil.L(20),
                        bottom: ScreenUtil.L(15),
                      ),
                      child: Text(
                        _title,
                        style: KFontConstant.blackTextBigBold(),
                      ),
                    ),
                    Container(height: 0.5, color: KColorConstant.lineColor),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _lisetWidget(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //-------------上面是dialog的内容布局--------------
              shape: defaultDialogShape,
            ),
          ),
        ),
      ),
    );
  }

  _lisetWidget(context) {
    List<Widget> listWidget = [];
    for (int i = 0; i < _data.length; i++) {
      listWidget.add(_widgetSlectItem(context, i, _data[i], _select == i));
      if (i != _data.length - 1) {
        listWidget.add(Container(height: 0.5, color: KColorConstant.lineColor));
      }
    }
    return listWidget;
  }

  ///单个item
  _widgetSlectItem(context, backValue, content, bool select) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, backValue);
      },
      child: Container(
        width: ScreenUtil.L(240),
        padding: EdgeInsets.only(
          top: ScreenUtil.L(15),
          bottom: ScreenUtil.L(15),
        ),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                left: ScreenUtil.L(20),
                right: ScreenUtil.L(10),
              ),
              child: Image.asset(
                select ? "images/select_true.png" : "images/select_false.png",
                width: ScreenUtil.L(15),
              ),
            ),
            Text("$content", style: KFontConstant.defaultText()),
          ],
        ),
      ),
    );
  }
}
