import 'package:bayes/base/base_widget.dart';
import 'package:bayes/base/common_function.dart';
import 'package:bayes/bean/CourseMangeModel.dart';
import 'package:bayes/constant/color.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/constant/style.dart';
import 'package:bayes/network/intercept/showloading_intercept.dart';
import 'package:bayes/network/requestUtil.dart';
import 'package:bayes/pages/VideoPage2.dart';
import 'package:bayes/study/CurriclumDetailPage1.dart';
import 'package:bayes/study/CurriclumDetailPage2.dart';
import 'package:bayes/study/CurriclumDetailPage3.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:bayes/widget/SwiperWidget1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//课程详情
// ignore: must_be_immutable
class CurriculumDetailPage extends BaseWidget {
  int? id;

  CurriculumDetailPage({super.key, this.id});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _CurriculumDetailPageState();
  }
}

class _CurriculumDetailPageState extends BaseWidgetState<CurriculumDetailPage> {
  final _controller = PageController();
  late List<Widget> _pages;

  static const _kDuration = Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  LoadingWidgetStatue pageStatue = LoadingWidgetStatue.LOADING;

  @override
  Widget buildWidget(BuildContext context) {
    if (pageStatue != LoadingWidgetStatue.NONE) {
      return baseStatueWidget(pageStatue);
    }
    _pages = <Widget>[
      CurriclumDetailPage1(
        id: widget.id,
        courseVideos: courseData.courseVideos,
      ),
      CurriclumDetailPage2(contentString: courseData.courseContent),
      CurriclumDetailPage3(
        lectorProfile: courseData.lectorProfile,
        name: courseData.lector,
        contentString: "${courseData.lectorProfile}",
        header: "",
      ),
    ];

    return Container(
      color: KColorConstant.appBgColor,
      child: Column(
        children: <Widget>[
          SwiperWidget1(images: courseData.courseImg),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(
              top: ScreenUtil.L(15),
              left: ScreenUtil.L(15),
              right: ScreenUtil.L(15),
            ),
            child: Text(
              "${courseData.courseName}",
              style: KFontConstant.blackTextBigBold(),
              maxLines: 2,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: ScreenUtil.L(15),
              top: ScreenUtil.L(10),
            ),
            child: Row(
              children: <Widget>[
                _jiaohuItem(
                  courseData.isCollect == "1"
                      ? "images/shoucang_true.png"
                      : "images/shoucang_false.png",
                  courseData.isCollect == "1" ? "已收藏" : "收藏",
                ),
                Container(
                  margin: EdgeInsets.only(left: ScreenUtil.L(20)),
                  child: Text(
                    "学习人数：${courseData.studyNum}",
                    style: KFontConstant.blackTextBig(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: KBoxStyle.whiteItemStyle(),
              margin: EdgeInsets.all(ScreenUtil.L(15)),
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
          Visibility(
            visible:
                courseData.courseVideos != null &&
                // ignore: prefer_is_empty
                courseData.courseVideos?.length != 0,
            child: Container(
              margin: EdgeInsets.only(
                left: ScreenUtil.L(40),
                right: ScreenUtil.L(40),
                bottom: ScreenUtil.L(20),
              ),
              child: raisedNextButton("开始学习"),
            ),
          ),
        ],
      ),
    );
  }

  //交互item
  _jiaohuItem(String image, String name) {
    return InkWell(
      onTap: () {
        _topicCollect();
        setState(() {
          if (courseData.isCollect != "1") {
            courseData.isCollect = "1";
          } else {
            courseData.isCollect = "0";
          }
        });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: ScreenUtil.L(5)),
            width: ScreenUtil.L(25),
            height: ScreenUtil.L(25),
            padding: EdgeInsets.all(ScreenUtil.L(3)),
            child: Image.asset(image),
          ),
          Text(name, style: KFontConstant.blackTextBig()),
        ],
      ),
    );
  }

  ///用户收藏
  _topicCollect() {
    var formData = {
      "topicId": "${widget.id}",
      "topicType": "5000", //主题类型（评论：1000，吐槽：2000  试题：3000  视频：4000  课程视频：5000）
    };
    RequestMap.topicCollect(
      null,
      formData,
    ).listen((data) {}, onError: (err) {});
  }

  _topage() {
    _controller.animateToPage(pageSelect, duration: _kDuration, curve: _kCurve);
  }

  late CourseData courseData;

  //获取首页数据
  _getCourseManage() {
    var formData = {"id": "${widget.id}"};
    RequestMap.getCourseManage(
      ShowLoadingIntercept(this, isInit: true),
      formData,
    ).listen((data) {
      courseData = data.data!;
      setState(() {
        pageStatue = LoadingWidgetStatue.NONE;
      });
    }, onError: (err) {});
  }

  @override
  btnNext(int buttonTag) {
    //    前往课程视频播放界面
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_) => VideoPage2(id: widget.id, videoId: -1),
      ),
    );
  }

  _selectTitle() {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil.L(5),
        left: ScreenUtil.L(25),
        right: ScreenUtil.L(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _carShopItem(),
      ),
    );
  }

  Widget _gridViewItemUI({String? title, bool? isSelect, int? index}) {
    return Container(
      height: ScreenUtil.L(35),
      padding: EdgeInsets.only(top: ScreenUtil.L(5)),
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          setState(() {
            pageSelect = index!;
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
                  title ?? '',
                  style: isSelect ?? false
                      ? KFontConstant.blackTextBigBold()
                      : KFontConstant.grayText(),
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
      _gridViewItemUI(title: "课程目录", isSelect: pageSelect == 0, index: 0),
    );
    listWidget.add(
      _gridViewItemUI(title: "课程介绍", isSelect: pageSelect == 1, index: 1),
    );
    listWidget.add(
      _gridViewItemUI(title: "讲师介绍", isSelect: pageSelect == 2, index: 2),
    );
    return listWidget;
  }

  @override
  void onCreate() {
    setTopBarVisible(true);
    setAppBarTitle("课程详情");
  }

  @override
  void onPause() {}

  @override
  void onResume() {
    _getCourseManage();
  }
}
