import 'package:bayes/base/base_widget.dart';
import 'package:bayes/constant/color.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:flutter/material.dart';

//我的消息
class MyMessagePage extends BaseWidget {
  const MyMessagePage({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _MyMessagePageState();
  }
}

class _MyMessagePageState extends BaseWidgetState<MyMessagePage> {
  final _controller = PageController();
  late List<Widget> _pages;

  static const _kDuration = Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  @override
  Widget buildWidget(BuildContext context) {
    _pages = <Widget>[
      // MessagePage(),
      // MessagePage2(),
      // MessagePage3(),
    ];

    // ignore: avoid_unnecessary_containers
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: ScreenUtil.L(0.8)),
              color: KColorConstant.white,
              child: Column(
                children: <Widget>[
                  _selectTitle(),
                  Expanded(
                    child: PageView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _topage() {
    _controller.animateToPage(pageSelect, duration: _kDuration, curve: _kCurve);
  }

  _selectTitle() {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil.L(5),
        left: ScreenUtil.L(35),
        right: ScreenUtil.L(35),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _carShopItem(),
      ),
    );
  }

  Widget _gridViewItemUI({
    required String title,
    required bool isSelect,
    required int index,
  }) {
    return Container(
      height: ScreenUtil.L(35),
      padding: EdgeInsets.only(top: ScreenUtil.L(5)),
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
            SizedBox(
              height: ScreenUtil.L(20),
              child: Center(
                child: Text(
                  title,
                  style: isSelect
                      ? KFontConstant.blackTextBigBold()
                      : KFontConstant.greyTextBig(),
                ),
              ),
            ),
            Container(
              height: ScreenUtil.L(2),
              width: ScreenUtil.L(30),
              margin: EdgeInsets.only(top: ScreenUtil.L(5)),
              color: isSelect ? KColorConstant.themeColor : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }

  int pageSelect = 0;

  List<Widget> _carShopItem() {
    List<Widget> listWidget = [];
    listWidget.add(
      _gridViewItemUI(title: "系统消息", isSelect: pageSelect == 0, index: 0),
    );
    listWidget.add(
      _gridViewItemUI(title: "我的评论", isSelect: pageSelect == 1, index: 1),
    );
    listWidget.add(
      _gridViewItemUI(title: "收到的评论和点赞", isSelect: pageSelect == 2, index: 2),
    );
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
