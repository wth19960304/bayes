import 'package:bayes/base/base_widget.dart';
import 'package:bayes/base/common_function.dart';
import 'package:bayes/bean/StudyHomeBean.dart';
import 'package:bayes/constant/color.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/constant/style.dart';
import 'package:bayes/network/intercept/showloading_intercept.dart';
import 'package:bayes/network/requestUtil.dart';
import 'package:bayes/pages/KechengItem.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

///搜索结果以及分类选择界面
// ignore: must_be_immutable
class KeChengSearchPage extends BaseWidget {
  String? text; //搜索内容
  String? id; //分类id
  String? typeName;

  KeChengSearchPage({super.key, this.text, this.id, this.typeName});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _GoodsListPageState();
  }
}

class _GoodsListPageState extends BaseWidgetState<KeChengSearchPage> {
  late TextEditingController editingController;

  late double deviceWidth;

  LoadingWidgetStatue pageStatue = LoadingWidgetStatue.LOADING;

  int pageNum = 1;
  int pageSize = 10;

  @override
  Widget buildWidget(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    if (pageStatue != LoadingWidgetStatue.NONE) {
      return baseStatueWidget(pageStatue);
    }
    return Column(
      children: <Widget>[
        Expanded(
          child: EasyRefresh(
            onRefresh: () async {
              pageNum = 1;
              await _getGoods();
            },
            // loadMore: () async {
            //   pageNum++;
            //   await _getGoods();
            // },
            header: ClassicalHeader(
              refreshText: '下拉刷新',
              refreshReadyText: '释放刷新',
              refreshingText: '正在刷新...',
              refreshedText: '刷新结束',
              // moreInfo: '更新于 %T',
              bgColor: Colors.transparent,
              textColor: Colors.black87,
              infoColor: Colors.black54,
              showInfo: true,
            ),
            footer: ClassicalFooter(
              loadText: '上拉加载',
              loadReadyText: '释放加载',
              loadingText: '正在加载',
              loadedText: '加载完成',
              noMoreText: '没有更多数据',
              bgColor: Colors.transparent,
              textColor: Colors.black87,
              infoColor: Colors.black54,
              showInfo: true,
            ),
            child: _listWidget(),
          ),
        ),
      ],
    );
  }

  @override
  Widget getAppBar() {
    if (widget.text == null) {
      return super.getAppBar();
    }
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
    _getGoods(isInit: true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getGoods(isInit: true);
  }

  @override
  void onCreate() {
    setNoDataString("未搜索到相关课程");
    setTopBarVisible(true);
    if (widget.id != null) {
      setAppBarTitle(widget.typeName ?? '');
      setAppBarRightTitle("");
    } else {
      editingController = TextEditingController(text: widget.text);
    }
  }

  @override
  void onPause() {}

  @override
  void onResume() {}

  List<CourseManageList> data = [];

  ///历史搜索列表
  _listWidget() {
    return ListView.builder(
      padding: EdgeInsets.only(top: ScreenUtil.L(20)),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        //Widget Function(BuildContext context, int index)
        return KechengItem(data: data[index]);
      },
    );
  }

  _getGoods({bool isInit = true}) {
    var formData = {
      "pageNum": pageNum,
      "pageSize": "20",
      "subject": "${widget.typeName}", //科目
      "thematic": "", //专题
      "courseLabel": "", //标签
      "courseName": editingController != null
          ? editingController.text
          : "", //搜索内容
    };
    RequestMap.getListCourseManage(
      ShowLoadingIntercept(this, isInit: isInit),
      formData,
    ).listen(
      (data) {
        // if (_easyRefreshKey.currentState != null) {
        //   _easyRefreshKey.currentState.callRefreshFinish();
        //   _easyRefreshKey.currentState.callLoadMoreFinish();
        // }
        if (data.data?.total == 0) {
          setState(() {
            pageStatue = LoadingWidgetStatue.DATAEMPTY;
          });
          return;
        }
        setState(() {
          if (pageNum == 1) {
            this.data = data.data!.content!;
          } else {
            if (this.data.length >= (data.data!.total ?? 0)) {
              return;
            }
            this.data.addAll(data.data?.content as Iterable<CourseManageList>);
          }
          pageStatue = LoadingWidgetStatue.NONE;
        });
      },
      onError: (err) {
        // if (_easyRefreshKey.currentState != null) {
        //   _easyRefreshKey.currentState.callRefreshFinish();
        //   _easyRefreshKey.currentState.callLoadMoreFinish();
        // }
        setState(() {
          pageStatue = LoadingWidgetStatue.ERROR;
        });
      },
    );
  }

  @override
  void dispose() {
    editingController.dispose();
    super.dispose();
  }
}
