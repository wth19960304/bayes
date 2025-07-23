//单选选题Widget

import 'package:dio/dio.dart';
import 'package:erp_music/base/base_widget.dart';
import 'package:erp_music/base/common_function.dart';
import 'package:erp_music/bean/TestSelectBean.dart';
import 'package:erp_music/constant/font.dart';
import 'package:erp_music/constant/index_constant.dart';
import 'package:erp_music/network/intercept/showloading_intercept.dart';
import 'package:erp_music/network/requestUtil.dart';
import 'package:erp_music/utils/screen_util.dart';
import 'package:flutter/rendering.dart';

import 'XuanzhetiWidget2.dart';

class SelectPage extends BaseWidget {
  String type;
  String subject;
  String thematic;
  int id;

  SelectPage({this.type, this.id, this.subject, this.thematic});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _SelectPageState();
  }
}

class _SelectPageState extends BaseWidgetState<SelectPage> {
  LoadingWidgetStatue pageStatue = LoadingWidgetStatue.LOADING;

  @override
  Widget buildWidget(BuildContext context) {
    if (pageStatue != LoadingWidgetStatue.NONE) {
      return baseStatueWidget(pageStatue);
    }
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: ScreenUtil().L(20)),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: ScreenUtil().L(15), right: ScreenUtil().L(15), top: ScreenUtil().L(10)),
            child: Image.asset("images/shiti_bg.png"),
          ),
          widget.type == "课后练习"
              ? Container()
              : Container(
                  margin: EdgeInsets.all(ScreenUtil().L(15)),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "科目分类(多选)",
                    style: KFontConstant.blackTextBig_bold(),
                  ),
                ),
          widget.type == "课后练习" ? Container() : _warpContent(_setWidgets1()),
          widget.type == "课后练习"
              ? Container()
              : Container(
                  margin: EdgeInsets.all(ScreenUtil().L(15)),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "专题选择(多选)",
                    style: KFontConstant.blackTextBig_bold(),
                  ),
                ),
          widget.type == "课后练习" ? Container() : _warpContent(_setWidgets2()),
          Container(
            margin: EdgeInsets.all(ScreenUtil().L(15)),
            alignment: Alignment.centerLeft,
            child: Text(
              "难易度选择(多选)",
              style: KFontConstant.blackTextBig_bold(),
            ),
          ),
          _warpContent(_setWidgets3()),
          Container(
            child: raisedNextButton("开始刷题"),
            margin: EdgeInsets.only(left: ScreenUtil().L(50), right: ScreenUtil().L(50), top: ScreenUtil().L(40)),
          )
        ],
      ),
    );
  }

  //科目分类选择
  List<String> selectIndex1 = new List();
  List<String> selectIndex2 = new List();
  List<String> selectIndex3 = new List();

  List<Widget> _setWidgets1() {
    List<Widget> widgets = new List();
    for (int i = 0; i < testSelectData.subjectManageList.length; i++) {
      widgets.add(_warpItem(testSelectData.subjectManageList[i].subjectName, 1));
    }

    return widgets;
  }

  List<Widget> _setWidgets2() {
    List<Widget> widgets = new List();
    for (int i = 0; i < testSelectData.thematicManageList.length; i++) {
      if (selectIndex1.contains(testSelectData.thematicManageList[i].subjectName)) {
        widgets.add(_warpItem(testSelectData.thematicManageList[i].thematicName, 2));
      }
    }
    if (widgets.length == 0) {
      widgets.add(Container(child: Text("请先选择科目分类", style: KFontConstant.myTextStyle(size: 14, color: Colors.black))));
    }
    return widgets;
  }

  List<Widget> _setWidgets3() {
    List<Widget> widgets = new List();
    for (int i = 0; i < testSelectData.testLevelManageList.length; i++) {
      widgets.add(_warpItem(testSelectData.testLevelManageList[i].testLevelName, 3));
    }
    return widgets;
  }

  _warpContent(List<Widget> widgets) {
    return Container(
      width: ScreenUtil.screenWidth,
      margin: EdgeInsets.only(left: ScreenUtil().L(15), right: ScreenUtil().L(15)),
      padding: EdgeInsets.all(ScreenUtil().L(20)),
      color: KColorConstant.white,
      child: Wrap(
        spacing: ScreenUtil().L(20),
        runSpacing: ScreenUtil().L(15),
        children: widgets,
      ),
    );
  }

  _warpItem(String content, int type) {
    bool isSelect = false;
    if (type == 1) {
      isSelect = selectIndex1.contains(content);
    }
    if (type == 2) {
      isSelect = selectIndex2.contains(content);
    }
    if (type == 3) {
      isSelect = selectIndex3.contains(content);
    }
    return InkWell(
      onTap: () {
        if (type == 1) {
          if (selectIndex1.contains(content)) {
            selectIndex1.remove(content);
          } else {
            selectIndex1.add(content);
          }
        }
        if (type == 2) {
          if (selectIndex2.contains(content)) {
            selectIndex2.remove(content);
          } else {
            selectIndex2.add(content);
          }
        }
        if (type == 3) {
          if (selectIndex3.contains(content)) {
            selectIndex3.remove(content);
          } else {
            selectIndex3.add(content);
          }
        }
        setState(() {});
      },
      child: Container(
        decoration: isSelect ? KBoxStyle.select_true() : KBoxStyle.select_false(),
        padding: EdgeInsets.only(left: ScreenUtil().L(15), right: ScreenUtil().L(15), top: ScreenUtil().L(5), bottom: ScreenUtil().L(5)),
        child: Text("$content", style: isSelect ? KFontConstant.whiteTextBig() : KFontConstant.greyTextBig()),
      ),
    );
  }

  @override
  void onResume() {
    _getCourseManage();
  }

  TestSelectData testSelectData;

  //获取首页数据
  _getCourseManage() {
    var formData = {
      "page": "1",
    };
    RequestMap.getTestSelect(ShowLoadingIntercept(this, isInit: true), formData).listen((data) {
      testSelectData = data.data;
      setState(() {
        pageStatue = LoadingWidgetStatue.NONE;
      });
    }, onError: (err) {});
  }

  //下一步点击事件
  void btnNext(int buttonTag) {
    _beginTest();
  }

//开始刷题
  _beginTest() {
    if (selectIndex3.length == 0) {
      showToast("请选择难易度");
      return;
    }
    if (widget.type != "课后练习") {
      if (selectIndex1.length == 0) {
        showToast("请选择科目");
        return;
      }
      if (selectIndex2.length == 0) {
        showToast("请选择专题");
        return;
      }
    }
    var map = {
      "testLevel": selectIndex3.toString(),
      "recordName": "${widget.type}",
      "recordType": "${widget.type}",
      "videoId": "${widget.id}",
    };

    if (widget.type != "课后练习") {
      map.addAll({
        "subject": selectIndex1.toString(),
        "thematic": selectIndex2.toString(),
      });
    } else {
      map.addAll({
        "subject": "[${widget.subject}]",
        "thematic": "[${widget.thematic}]",
      });
    }
    print(map);
    RequestMap.beginTest(ShowLoadingIntercept(this), map).listen((data) {
      Navigator.of(context).pop();
      Navigator.push(context, new MaterialPageRoute(builder: (context) => new XuanzhetiWidget2(data.data, 0)));
    }, onError: (err) {
      showToast(err.message);
      print(err.message);
    });
  }

  @override
  void onCreate() {
    setTopBarVisible(true);
    setAppBarTitle("试题选择");
  }

  @override
  void onPause() {}
}
