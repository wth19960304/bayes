import 'package:bayes/base/base_widget.dart';
import 'package:bayes/base/common_function.dart';
import 'package:bayes/constant/color.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/constant/style.dart';
import 'package:bayes/pages/KechengVideoSearchPage.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:bayes/utils/sp_constant.dart';
import 'package:bayes/utils/sp_utils.dart';
import 'package:flutter/material.dart';

import 'ShitiSearchPage.dart';

///搜索界面
// ignore: must_be_immutable
class SearchPage extends BaseWidget {
  String name;

  SearchPage({super.key, required this.name});

  @override
  BaseWidgetState<BaseWidget> getState() {
    // TODO: implement getState
    return _SearchPageState();
  }
}

class _SearchPageState extends BaseWidgetState<SearchPage> {
  TextEditingController editingController = TextEditingController(text: '');

  late List<String> searchList;

  LoadingWidgetStatue statue = LoadingWidgetStatue.LOADING;

  @override
  Widget buildWidget(BuildContext context) {
    if (statue != LoadingWidgetStatue.NONE) {
      return baseStatueWidget(statue);
    }
    return Column(children: <Widget>[_titleWidget(), _listWidget()]);
  }

  @override
  Widget getAppBar() {
    return Container(
      padding: EdgeInsets.only(right: ScreenUtil.L(15)),
      height: ScreenUtil.L(50),
      width: double.infinity,
      color: KColorConstant.appBgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: clickAppBarBack,
            child: Container(
              height: ScreenUtil.L(46),
              width: ScreenUtil.L(46),
              padding: EdgeInsets.only(
                top: ScreenUtil.L(15),
                bottom: ScreenUtil.L(15),
                right: ScreenUtil.L(15),
                left: ScreenUtil.L(15),
              ),
              child: Image.asset("images/left_go.png"),
            ),
          ),
          Container(
            height: ScreenUtil.L(30),
            padding: EdgeInsets.only(left: 10),
            width: ScreenUtil.L(230),
            decoration: KBoxStyle.btnYuanBgcolor(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: ScreenUtil.L(15),
                  width: ScreenUtil.L(20),
                  child: Image.asset("images/search_icon.png"),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: ScreenUtil.L(5)),
                    child: TextField(
                      //                        controller: controller,
                      style: KFontConstant.defaultText(),
                      decoration: null,
                      controller: editingController,
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              _goSearch();
            },
            child: Container(
              margin: EdgeInsets.only(left: ScreenUtil.L(10)),
              decoration: KBoxStyle.selectTrue(),
              height: ScreenUtil.L(28),
              width: ScreenUtil.L(50),
              child: Center(
                child: Text("搜索", style: KFontConstant.whiteText()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///搜索
  _goSearch() {
    if (editingController.text.isEmpty) {
      showToast("搜索内容不能为空");
      return;
    }
    setState(() {
      statue = LoadingWidgetStatue.NONE;
      searchList.remove(editingController.text);
      searchList.insert(0, editingController.text);
      String searchListString = "";
      for (int i = 0; i < searchList.length; i++) {
        if (searchListString == "") {
          searchListString += searchList[i];
        } else {
          searchListString += "&&&${searchList[i]}";
        }
      }
      SpUtils().setString(SpConstanst.SEARCH_LIST, searchListString);
    });
    if (widget.name == "课程搜索") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              KeChengVideoSearchPage(text: editingController.text),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ShitiSearchPage(text: editingController.text),
        ),
      );
    }
  }

  @override
  void onCreate() {
    searchList =
        SpUtils().getString(SpConstanst.SEARCH_LIST)?.split("&&&") ?? [];
    searchList.remove("");
    if (searchList.isEmpty) {
      statue = LoadingWidgetStatue.DATAEMPTY;
    } else {
      statue = LoadingWidgetStatue.NONE;
    }
    setNoDataString("暂无搜索记录");
    setTopBarVisible(true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    editingController.dispose();
  }

  @override
  void onPause() {}

  @override
  void onResume() {}

  ///历史记录+删除按钮
  _titleWidget() {
    return Container(
      padding: EdgeInsets.all(ScreenUtil.L(10)),
      decoration: KBoxStyle.bottomLineStyle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("历史搜索", style: KFontConstant.defaultTextBold()),
          InkWell(
            onTap: () {
              _deleteAll();
            },
            child: Container(
              height: ScreenUtil.L(25),
              width: ScreenUtil.L(25),
              padding: EdgeInsets.all(7),
              child: Image.asset("images/shanchu.png"),
            ),
          ),
        ],
      ),
    );
  }

  ///删除所有的搜索记录
  _deleteAll() {
    setState(() {
      searchList.clear();
      statue = LoadingWidgetStatue.DATAEMPTY;
      SpUtils().setString(SpConstanst.SEARCH_LIST, "");
    });
  }

  ///历史搜索列表
  _listWidget() {
    return Expanded(
      child: ListView(padding: EdgeInsets.only(top: 0), children: _listItems()),
    );
  }

  _listItems() {
    List<Widget> widgets = [];
    for (int i = 0; i < searchList.length; i++) {
      widgets.add(
        InkWell(
          onTap: () {
            if (widget.name == "课程搜索") {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      KeChengVideoSearchPage(text: searchList[i]),
                ),
              );
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ShitiSearchPage(text: searchList[i]),
                ),
              );
            }
          },
          child: Container(
            padding: EdgeInsets.all(ScreenUtil.L(15)),
            decoration: KBoxStyle.bottomLineStyle(),
            child: Text(searchList[i], style: KFontConstant.defaultText()),
          ),
        ),
      );
    }
    return widgets;
  }
}
