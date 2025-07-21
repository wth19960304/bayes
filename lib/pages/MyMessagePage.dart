import 'package:erp_music/base/base_widget.dart';
import 'package:erp_music/base/common_function.dart';
import 'package:erp_music/bean/CourseMangeModel.dart';
import 'package:erp_music/constant/color.dart';
import 'package:erp_music/constant/font.dart';
import 'package:erp_music/constant/index_constant.dart';
import 'package:erp_music/ui/UserInfo/message/MessagePage1.dart';
import 'package:erp_music/utils/screen_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'message/MessagePage2.dart';
import 'message/MessagePage3.dart';

//我的消息
class MyMessagePage extends BaseWidget {
  @override
  BaseWidgetState<BaseWidget> getState() {
    return _MyMessagePageState();
  }
}

class _MyMessagePageState extends BaseWidgetState<MyMessagePage> {
  final _controller = new PageController();
  List<Widget> _pages;

  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  @override
  Widget buildWidget(BuildContext context) {
    _pages = <Widget>[
      MessagePage(),
      MessagePage2(),
      MessagePage3(),
    ];

    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: ScreenUtil().L(0.8)),
              color: KColorConstant.white,
              child: Column(
                children: <Widget>[
                  _selectTitle(),
                  Expanded(
                    child: PageView.builder(
                      physics: new AlwaysScrollableScrollPhysics(),
                      controller: _controller,
                      itemBuilder: (BuildContext context, int index) {
                        return _pages[index];
                      },
                      //条目个数
                      itemCount: _pages.length,
                      onPageChanged: (index) {
                        if (index != pageSelect) {
                          setState(() {
                            pageSelect = index;
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _topage() {
    _controller.animateToPage(
      pageSelect,
      duration: _kDuration,
      curve: _kCurve,
    );
  }

  _selectTitle() {
    return Container(
      padding: EdgeInsets.only(top: ScreenUtil().L(5), left: ScreenUtil().L(35), right: ScreenUtil().L(35)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _carShopItem(),
      ),
    );
  }

  Widget _gridViewItemUI({String title, bool isSelect, int index}) {
    return Container(
      height: ScreenUtil().L(35),
      padding: EdgeInsets.only(top: ScreenUtil().L(5)),
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          setState(() {
            pageSelect = index;
          });
          _topage();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: ScreenUtil().L(20),
              child: Center(
                child: Text(
                  "$title",
                  style: isSelect ? KFontConstant.blackTextBig_bold() : KFontConstant.greyTextBig(),
                ),
              ),
            ),
            Container(
              height: ScreenUtil().L(2),
              width: ScreenUtil().L(30),
              margin: EdgeInsets.only(top: ScreenUtil().L(5)),
              color: isSelect ? KColorConstant.themeColor : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }

  int pageSelect = 0;

  List<Widget> _carShopItem() {
    List<Widget> listWidget = List();
    listWidget.add(_gridViewItemUI(title: "系统消息", isSelect: pageSelect == 0, index: 0));
    listWidget.add(_gridViewItemUI(title: "我的评论", isSelect: pageSelect == 1, index: 1));
    listWidget.add(_gridViewItemUI(title: "收到的评论和点赞", isSelect: pageSelect == 2, index: 2));
    return listWidget;
  }

  @override
  void onCreate() {
    setTopBarVisible(true);
    setAppBarTitle("消息中心");
  }

  @override
  void onPause() {}

  @override
  void onResume() {}
}
