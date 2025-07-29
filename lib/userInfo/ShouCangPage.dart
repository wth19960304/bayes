import 'package:bayes/base/base_widget.dart';
import 'package:bayes/constant/color.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/userInfo/ShouCangPage1.dart';
import 'package:bayes/userInfo/ShouCangPage2.dart';
import 'package:bayes/userInfo/ShouCangPage3.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:flutter/material.dart';

//我的收藏列表
class ShouCangPage extends BaseWidget {
  const ShouCangPage({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return _ShouCangPageState();
  }
}

class _ShouCangPageState extends BaseWidgetState<ShouCangPage> {
  final _controller = PageController();
  late List<Widget> _pages;

  static const _kDuration = Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  @override
  Widget buildWidget(BuildContext context) {
    _pages = <Widget>[ShouCangPage1(), ShouCangPage2(), ShouCangPage3()];

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
        left: ScreenUtil.L(55),
        right: ScreenUtil.L(55),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _carShopItem(),
      ),
    );
  }

  Widget _gridViewItemUI({String? title, bool? isSelect, int? index}) {
    return Container(
      width: ScreenUtil.L(65),
      height: ScreenUtil.L(35),
      padding: EdgeInsets.only(top: ScreenUtil.L(5)),
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          setState(() {
            pageSelect = index ?? 0;
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
                  "$title",
                  style: isSelect ?? false
                      ? KFontConstant.blackTextBigBold()
                      : KFontConstant.greyTextBig(),
                ),
              ),
            ),
            Container(
              height: ScreenUtil.L(2),
              width: ScreenUtil.L(30),
              margin: EdgeInsets.only(top: ScreenUtil.L(5)),
              color: isSelect ?? false
                  ? KColorConstant.themeColor
                  : Colors.transparent,
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
      _gridViewItemUI(title: "课程", isSelect: pageSelect == 0, index: 0),
    );
    listWidget.add(
      _gridViewItemUI(title: "视频", isSelect: pageSelect == 1, index: 1),
    );
    listWidget.add(
      _gridViewItemUI(title: "试题", isSelect: pageSelect == 2, index: 2),
    );
    return listWidget;
  }

  @override
  void onCreate() {
    setTopBarVisible(true);
    setAppBarTitle("我的收藏");
  }

  @override
  void onPause() {}

  @override
  void onResume() {}
}
