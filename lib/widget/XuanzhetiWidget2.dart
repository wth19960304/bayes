import 'dart:core';

import 'package:bayes/base/base_widget.dart';
import 'package:bayes/base/common_function.dart';
import 'package:bayes/bean/TestBean.dart';
import 'package:bayes/constant/color.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/constant/style.dart';
import 'package:bayes/network/intercept/showloading_intercept.dart';
import 'package:bayes/network/requestUtil.dart';
import 'package:bayes/pages/DaTiJg_Page.dart';
import 'package:bayes/pages/OtherVideoItem.dart';
import 'package:bayes/utils/PhotoViewSimpleScreen.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:bayes/widget/image_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//多选题Widget
// ignore: must_be_immutable
class XuanzhetiWidget2 extends BaseWidget {
  String id;
  int index;

  XuanzhetiWidget2(this.id, this.index, {super.key});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _XuanzhetiWidgetState2();
  }
}

class _XuanzhetiWidgetState2 extends BaseWidgetState<XuanzhetiWidget2> {
  ///判断答题结束的状态
  bool overDating = false;

  final List<int> _selectList = [];

  late TestData data;

  TextEditingController controller = TextEditingController();

  ///是否显示推荐视频布局
  _video() {
    if (!overDating) {
      return Container();
    } else {
      return Column(
        children: <Widget>[_VideoListWidget(), _VideoListWidget2()],
      );
    }
  }

  _widgets() {
    List<BoxDecoration> des = [
      KBoxStyle.lvseRound4Bg(),
      KBoxStyle.orangeRound4Bg(),
      KBoxStyle.blueRound4Bg(),
    ];
    List<Widget> widgets = [];
    for (int i = 0; i < data.testLabel!.length; i++) {
      widgets.add(
        Container(
          margin: EdgeInsets.only(left: ScreenUtil.L(10)),
          decoration: des[i % 3],
          padding: EdgeInsets.all(ScreenUtil.L(2)),
          child: Text(
            "${data.testLabel[i].name}",
            style: KFontConstant.defaultText(),
          ),
        ),
      );
    }
    return widgets;
  }

  ///内容布局
  _contentWidget() {
    return Container(
      decoration: KBoxStyle.shadowStyle(),
      margin: EdgeInsets.only(bottom: ScreenUtil.L(20)),
      padding: EdgeInsets.only(
        left: ScreenUtil.L(15),
        top: ScreenUtil.L(15),
        right: ScreenUtil.L(15),
        bottom: ScreenUtil.L(10),
      ),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: ScreenUtil.L(20)),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "随机刷题（第${widget.index + 1}题）",
                      style: KFontConstant.blackTextBigBold(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: ScreenUtil.L(20)),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${data.testTopic}   (${data.typeName != "选择题" ? "${data.typeName}" : (data.selectType == "0" ? "单选题" : "多选题")})",
                      style: KFontConstant.blackTextBig(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: ScreenUtil.L(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "练习正确率：${data.correctRate}%",
                          style: KFontConstant.greyTextSmall(),
                        ),
                        Row(children: _widgets()),
                      ],
                    ),
                  ),
                ],
              ),
              overDating
                  ? Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(ScreenUtil.L(5)),
                      child: Image.asset(
                        isTrue == "false"
                            ? "images/dati_error.png"
                            : "images/dati_success.png",
                        width: ScreenUtil.L(40),
                      ),
                    )
                  : Container(),
            ],
          ),
          // ignore: prefer_is_empty
          data.testImg?.length == 0
              ? Container()
              : InkWell(
                  onTap: () {
                    //展示大图
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PhotoViewSimpleScreen(
                          imageProvider: NetworkImage(
                            "${data.testImg?[0].url}",
                          ),
                          heroTag: 'simple',
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: ScreenUtil.L(290),
                    child: ClipRRect(
                      child: CachedNetworkImage(
                        imageUrl: "${data.testImg?[0].url}",
                        placeholder: (context, url) =>
                            ImageLoadingPage(width: 20.0),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil.L(8),
              bottom: ScreenUtil.L(8),
            ),
            child: Wrap(spacing: ScreenUtil.L(10), children: _selectWidget()),
          ),
          (overDating)
              ? Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                    bottom: ScreenUtil.L(10),
                    left: ScreenUtil.L(5),
                  ),
                  child: Text(zhengQueDA, style: KFontConstant.themeText()),
                )
              : Container(),
          (overDating && isTrue == "false")
              ? Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                    bottom: ScreenUtil.L(10),
                    left: ScreenUtil.L(5),
                  ),
                  child: Text("该题已加入您的错题集", style: KFontConstant.redTextBold()),
                )
              : Container(),
          _jiaohuWidget(),
        ],
      ),
    );
  }

  ///展示题目
  _selectWidget() {
    List<Widget> listWidget = [];
    if (data.typeName == "选择题") {
      for (int i = 0; i < data.testOptionsList.length; i++) {
        listWidget.add(_widgetSlectItem(data.testOptionsList[i], i));
      }
    } else if (data.typeName == "填空题") {
      listWidget.add(
        Container(
          decoration: KBoxStyle.btnYuanBgcolor(),
          padding: EdgeInsets.all(ScreenUtil.L(10)),
          child: TextField(
            controller: controller,
            //禁止输入
            enabled: !overDating,
            style: KFontConstant.defaultText(),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "请输入您的答案",
            ),
            maxLines: 2,
          ),
        ),
      );
    } else if (data.typeName == "判断题") {
      listWidget.add(_panduantiWidget("正确", 0));
      listWidget.add(_panduantiWidget("错误", 1));
    }
    return listWidget;
  }

  var numIndex = ["A", "B", "C", "D", "E", "F", "G", "H"];

  ///单个选择题按钮
  _widgetSlectItem(TestOptionsList content, int index) {
    return GestureDetector(
      onTap: () {
        if (overDating) {
          return;
        }
        if (data.selectType != "1") {
          //单选
          setState(() {
            _selectList.clear();
            _selectList.add(index);
          });
        } else {
          //多选
          setState(() {
            if (_selectList.contains(index)) {
              _selectList.remove(index);
            } else {
              _selectList.add(index);
            }
          });
        }
      },
      child: Container(
        color: KColorConstant.white,
        width: ScreenUtil.L(140),
        padding: EdgeInsets.only(
          top: ScreenUtil.L(15),
          bottom: ScreenUtil.L(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: ScreenUtil.L(18),
                  margin: EdgeInsets.only(right: ScreenUtil.L(10)),
                  child: Image.asset(
                    _selectList.contains(index)
                        ? "images/select_true.png"
                        : "images/select_false.png",
                  ),
                ),
                SizedBox(
                  width: ScreenUtil.L(110),
                  child: Text(
                    "${numIndex[index]}：${content.optionName}",
                    style: KFontConstant.defaultText(),
                  ),
                ),
              ],
            ),
            // ignore: prefer_is_empty
            content.optionImg?.length == 0
                ? Container()
                : Container(
                    margin: EdgeInsets.only(top: ScreenUtil.L(10)),
                    child: _imageWidget(content.optionImg![0].url ?? ''),
                  ),
          ],
        ),
      ),
    );
  }

  String panduanDaAn = "";

  _panduantiWidget(String content, int index) {
    bool isSelect = false;
    if (index == 0 && panduanDaAn == "true") {
      isSelect = true;
    } else if (index == 1 && panduanDaAn == "false") {
      isSelect = true;
    }
    return GestureDetector(
      onTap: () {
        if (overDating) {
          return;
        }
        setState(() {
          if (index == 0) {
            panduanDaAn = "true";
          } else
            // ignore: curly_braces_in_flow_control_structures
            panduanDaAn = "false";
        });
      },
      child: Container(
        color: KColorConstant.white,
        width: ScreenUtil.screenWidth,
        padding: EdgeInsets.only(
          top: ScreenUtil.L(15),
          bottom: ScreenUtil.L(15),
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: ScreenUtil.L(18),
              margin: EdgeInsets.only(right: ScreenUtil.L(10)),
              child: Image.asset(
                isSelect ? "images/select_true.png" : "images/select_false.png",
              ),
            ),
            Text("${index + 1}：$content", style: KFontConstant.defaultText()),
          ],
        ),
      ),
    );
  }

  //图片  - 点击可查看大图
  _imageWidget(String image) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PhotoViewSimpleScreen(
              imageProvider: NetworkImage(image),
              heroTag: 'simple',
            ),
          ),
        );
      },
      child: SizedBox(
        width: ScreenUtil.L(150),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.L(7))),
          child: CachedNetworkImage(
            imageUrl: image,
            placeholder: (context, url) => ImageLoadingPage(width: 20.0),
          ),
        ),
      ),
    );
  }

  //交互widget
  _jiaohuWidget() {
    if (overDating != true) {
      return Container();
    }
    return Container(
      width: ScreenUtil.screenWidth,
      margin: EdgeInsets.only(left: ScreenUtil.L(10), right: ScreenUtil.L(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _jiaohuItem(
            data.likeNum ?? '',
            data.isLike == "1"
                ? "images/dianzhan_true.png"
                : "images/dianzhan_false.png",
            "点赞",
          ),
          _jiaohuItem(
            data.dislikeNum ?? '',
            data.isDisLike == "1"
                ? "images/diancai_true.png"
                : "images/diancai_false.png",
            "点踩",
          ),
          _jiaohuItem(
            data.collectNum ?? '',
            data.isCollect == "1"
                ? "images/shoucang_true.png"
                : "images/shoucang_false.png",
            "收藏",
          ),
          //          _jiaohuItem(data.commentNum, "images/fenxiang_true.png", "评论"),
          _jiaohuItem("分享", "images/fenxiang_true.png", "分享"),
        ],
      ),
    );
  }

  _jiaohuItem(String num, String image, String tag) {
    return InkWell(
      onTap: () {
        _jiaohuClick(tag);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: ScreenUtil.L(5)),
            width: ScreenUtil.L(35),
            height: ScreenUtil.L(35),
            padding: EdgeInsets.all(ScreenUtil.L(3)),
            child: Image.asset(image),
          ),
          Text(num, style: KFontConstant.grayText()),
        ],
      ),
    );
  }

  _jiaohuClick(String tag) {
    if (tag == "点赞") {
      if (data.isDisLike == "1") {
        showToast("您已点踩，不能点赞");
        return;
      }
      setState(() {
        if (data.isLike == "1") {
          data.likeNum = "${int.parse(data.likeNum ?? '') - 1}";
          data.isLike = "0";
        } else {
          data.likeNum = "${int.parse(data.likeNum ?? '') + 1}";
          data.isLike = "1";
        }
      });
      _likeOrDisLike(true);
    } else if (tag == "点踩") {
      if (data.isLike == "1") {
        showToast("您已点赞，不能点踩");
        return;
      }
      setState(() {
        if (data.isDisLike == "1") {
          data.dislikeNum = "${int.parse(data.dislikeNum ?? '') - 1}";
          data.isDisLike = "0";
        } else {
          data.dislikeNum = "${int.parse(data.dislikeNum ?? '') + 1}";
          data.isDisLike = "1";
        }
      });
      _likeOrDisLike(false);
    } else if (tag == "分享") {
      showShareDialog(
        title: "贝叶斯数学，内容全免费哟，快来下载和我一起学习吧！",
        type: "app",
        id: '',
        videoType: '',
      );
    } else if (tag == "收藏") {
      _topicCollect();
      setState(() {
        if (data.isCollect == "1") {
          data.collectNum = "${int.parse(data.collectNum ?? '') - 1}";
          data.isCollect = "0";
        } else {
          data.collectNum = "${int.parse(data.collectNum ?? '') + 1}";
          data.isCollect = "1";
        }
      });
    } else if (tag == "下载") {}
  }

  ///点赞和点踩
  _likeOrDisLike(bool like) {
    var formData = {
      "topicId": "${data.id}",
      "topicType": "3000", //主题类型（评论：1000，吐槽：2000  试题：3000  视频：4000  课程视频：5000）
    };
    if (like)
      // ignore: curly_braces_in_flow_control_structures
      RequestMap.topicLike(null, formData).listen((data) {}, onError: (err) {});
    else
      // ignore: curly_braces_in_flow_control_structures
      RequestMap.topicDisLike(
        null,
        formData,
      ).listen((data) {}, onError: (err) {});
  }

  ///用户收藏
  _topicCollect() {
    var formData = {
      "topicId": "${data.id}",
      "topicType": "3000", //主题类型（评论：1000，吐槽：2000  试题：3000  视频：4000  课程视频：5000）
    };
    RequestMap.topicCollect(
      null,
      formData,
    ).listen((data) {}, onError: (err) {});
  }

  ///按钮布局
  _btnWidgetList() {
    List<Widget> widgets;
    if (overDating) {
      widgets = <Widget>[
        _btnWidget("结束刷题", "images/shuatibtn1.png"),
        _btnWidget("下一题", "images/shuatibtn2.png"),
      ];
    } else {
      widgets = <Widget>[
        _btnWidget("结束刷题", "images/shuatibtn1.png"),
        _btnWidget("不会做", "images/shuatibtn3.png"),
        _btnWidget("提交", "images/shuatibtn4.png"),
      ];
    }
    return Container(
      margin: EdgeInsets.only(left: ScreenUtil.L(30), right: ScreenUtil.L(30)),
      child: Row(
        mainAxisAlignment: overDating
            ? MainAxisAlignment.spaceEvenly
            : MainAxisAlignment.spaceBetween,
        children: widgets,
      ),
    );
  }

  ///按钮widget
  _btnWidget(String title, String images) {
    return SizedBox(
      width: ScreenUtil.L(85),
      child: InkWell(
        onTap: () {
          _btnNext(title);
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset(images),
            Text(title, style: KFontConstant.whiteTextBig()),
          ],
        ),
      ),
    );
  }

  _btnNext(String tag) {
    if (tag == ("结束刷题")) {
      //结束本次刷题
      _endTest();
    } else if (tag == ("提交")) {
      _tiJiaoDaAn();
    } else if (tag == ("下一题")) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => XuanzhetiWidget2(widget.id, widget.index + 1),
        ),
      );
    } else if (tag == ("不会做")) {
      _tiJiaoDaAn(isNone: true);
    }
  }

  ///讲解视频
  // ignore: non_constant_identifier_names
  _VideoListWidget() {
    // ignore: prefer_is_empty
    if (data.explainVideoName == null || data.explainVideoName!.length < 1) {
      return Container();
    }
    return Container(
      decoration: KBoxStyle.shadowStyle(),
      margin: EdgeInsets.only(bottom: ScreenUtil.L(15)),
      padding: EdgeInsets.only(bottom: ScreenUtil.L(10)),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(
              left: ScreenUtil.L(20),
              top: ScreenUtil.L(15),
              bottom: ScreenUtil.L(15),
            ),
            child: Text("讲解视频", style: KFontConstant.blackTextBigBold()),
          ),
          OtherVideoItem(
            name: data.explainVideoName ?? '',
            id: int.parse(data.explainVideo ?? ''),
            isVideo: true,
          ),
        ],
      ),
    );
  }

  ///相关知识点
  // ignore: non_constant_identifier_names
  _VideoListWidget2() {
    List<Widget> widgets = [];
    widgets.add(
      Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(
          left: ScreenUtil.L(20),
          top: ScreenUtil.L(15),
          bottom: ScreenUtil.L(15),
        ),
        child: Text("相关知识点", style: KFontConstant.blackTextBigBold()),
      ),
    );
    for (int x = 0; x < data.aboutVideos!.length; x++) {
      widgets.add(
        OtherVideoItem(
          index: x,
          name: data.aboutVideos![x].name ?? '',
          id: data.aboutVideos?[x].cmId ?? 0,
          time: data.aboutVideos?[x].time ?? '',
          videoId: data.aboutVideos?[x].cvId ?? 0,
        ),
      );
    }
    return Container(
      decoration: KBoxStyle.shadowStyle(),
      margin: EdgeInsets.only(bottom: ScreenUtil.L(15)),
      padding: EdgeInsets.only(bottom: ScreenUtil.L(10)),
      child: Column(children: widgets),
    );
  }

  @override
  void onCreate() {
    setTopBarVisible(true);
    setAppBarVisible(true);
    setAppBarTitle("练习");
    setFloatingShow(true);
    _beginTest();
  }

  @override
  void onPause() {}

  @override
  void onResume() {}
  LoadingWidgetStatue pageStatue = LoadingWidgetStatue.LOADING;

  @override
  Widget buildWidget(BuildContext context) {
    if (pageStatue != LoadingWidgetStatue.NONE) {
      return baseStatueWidget(pageStatue);
    }
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(ScreenUtil.L(15)),
            child: Column(children: <Widget>[_contentWidget(), _video()]),
          ),
          _btnWidgetList(),
          Container(height: ScreenUtil.L(30)),
        ],
      ),
    );
  }

  ///获取一道题
  _beginTest() {
    var formData = {"id": widget.id};
    print(formData);
    RequestMap.getTestByTerm(
      ShowLoadingIntercept(this, isInit: true),
      formData,
    ).listen(
      (data) {
        setState(() {
          this.data = data.data!;
          pageStatue = LoadingWidgetStatue.NONE;
        });
      },
      onError: (err) {
        print(err.message);
        if (err.message == "您已刷完所有试题") {
          _endTest();
          return;
        }
        showToast(err.message);
      },
    );
  }

  //答案组装
  String daAn = ""; //用户输入或者选择的答案
  String daAnTrue = ""; //正确答案
  String isTrue = "true"; //答案是否正确

  String zhengQueDA = "正确答案为：";

  ///提交答案
  ///isNone是否不会做
  _tiJiaoDaAn({bool isNone = false}) {
    if (data.typeName == "选择题") {
      daAn = _selectList.toString();
      //正确答案组装
      List<int> trueIndex = [];
      for (int i = 0; i < data.testOptionsList!.length; i++) {
        if (data.testOptionsList[i].optionTrue == "true") {
          trueIndex.add(i);
          zhengQueDA += "${numIndex[i]},";
        }
      }
      daAnTrue = trueIndex.toString();
      if (_selectList.length != trueIndex.length) {
        isTrue = "false";
      }
      for (int i = 0; i < _selectList.length; i++) {
        if (!trueIndex.contains(_selectList[i])) {
          isTrue = "false";
          break;
        }
      }
    } else if (data.typeName == "填空题") {
      daAn = controller.text;
      //正确答案组装
      List<String> trueIndex = [];
      for (int i = 0; i < data.testAnswersList!.length; i++) {
        trueIndex.add(data.testAnswersList![i].answer ?? '');
        zhengQueDA += "${data.testAnswersList[i].answer},";
      }
      daAnTrue = trueIndex.toString();
      isTrue = "${trueIndex.contains(daAn)}";
    } else if (data.typeName == "判断题") {
      daAn = panduanDaAn;
      zhengQueDA += "${data.isTrue}";
      daAnTrue = data.isTrue!;
    }
    //不会做
    if (isNone) {
      isTrue = "false";
      daAn = "";
    }
    var formData = {
      "id": "${data.id}",
      "solution": daAn, //输入的答案
      "testRecordId": widget.id,
      "underMark": "${widget.index}",
      "state": "",
      "trueSolution": daAnTrue, //正确答案
      "subject": "${data.subject}",
      "thematic": "${data.thematic}",
      "testLevel": "${data.testLevel}",
      "isTrue": isTrue,
    };
    RequestMap.submitTest(ShowLoadingIntercept(this), formData).listen(
      (data) {
        setState(() {
          overDating = true;
        });
      },
      onError: (err) {
        showToast(err.message);
        setState(() {});
      },
    );
  }

  //结束本次刷题
  _endTest() {
    var formData = {"id": widget.id};
    RequestMap.endTest(ShowLoadingIntercept(this), formData).listen(
      (data) {
        Navigator.of(context).pop();
        //跳转到练习详情界面
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DaTiJgPage(widget.id)),
        );
      },
      onError: (err) {
        if (err.message == "暂未答题") {
          pageStatue = LoadingWidgetStatue.DATAEMPTY;
          setNoDataString("未获取到该类型的试题\n等试题丰富后再来吧~");
          setState(() {});
          return;
        }
        showToast(err.message);
      },
    );
  }
}
