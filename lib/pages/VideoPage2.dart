import 'dart:io';

import 'package:bayes/base/base_widget.dart';
import 'package:bayes/base/common_function.dart';
import 'package:bayes/bean/CommentBean.dart';
import 'package:bayes/bean/CourseVideoDetailBean.dart';
import 'package:bayes/constant/color.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/constant/style.dart';
import 'package:bayes/dialog/BottomInputDialog.dart';
import 'package:bayes/network/intercept/showloading_intercept.dart';
import 'package:bayes/network/requestUtil.dart';
import 'package:bayes/pages/OtherVideoItem.dart';
import 'package:bayes/pages/SelectPage.dart';
import 'package:bayes/pages/playerKongJian.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:bayes/utils/sp_constant.dart';
import 'package:bayes/widget/CommentItem.dart';
import 'package:dio/dio.dart';
import 'package:fijkplayer_plus/fijkplayer_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

///课程视频播放
// ignore: must_be_immutable
class VideoPage2 extends BaseWidget {
  int? id;
  int? videoId;
  int? videoHaveNum;

  VideoPage2({super.key, this.id, this.videoId, this.videoHaveNum = 0});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _VideoPageState2();
  }
}

class _VideoPageState2 extends BaseWidgetState<VideoPage2> {
  late CourseVideoDetailData data;
  LoadingWidgetStatue pageStatue = LoadingWidgetStatue.LOADING;
  final FijkPlayer player = FijkPlayer();

  int selectIndex = 0;
  String playUrl = "";

  @override
  Widget buildWidget(BuildContext context) {
    if (pageStatue != LoadingWidgetStatue.NONE) {
      return baseStatueWidget(pageStatue);
    }
    return Container(
      color: KColorConstant.appBgColor,
      child: Column(
        children: <Widget>[
          _topWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _title(),
                  _videoListWidget(),
                  _otherVideoWidgets(),
                  _complaintsWidget(),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              ///获取用户信息
              var formData = {"page": "1"};
              RequestMap.getUserInfo(
                ShowLoadingIntercept(this, isInit: true),
                formData,
              ).listen(
                (data) {
                  if (data.data?.state == "1") {
                    showToast("您的账号没有权限，详情前往消息中心查看", length: Toast.LENGTH_LONG);
                    return;
                  } else {
                    showDialog<int>(
                      context: context, //BuildContext对象
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return BottomInputDialog(
                          id: this.data.courseVideos![selectIndex].id ?? 0,
                          type: 3,
                          parentId: widget.id ?? 0,
                        );
                      },
                    ).then((va) {
                      _getCommentList();
                    });
                  }
                },
                onError: (err) {
                  showToast(err.message);
                },
              );
            },
            child: Container(
              color: KColorConstant.appBgColor,
              width: ScreenUtil.screenWidth,
              padding: EdgeInsets.all(ScreenUtil.L(10)),
              height: ScreenUtil.L(50),
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: KBoxStyle.btnYuanBgcolor(),
                padding: EdgeInsets.only(left: ScreenUtil.L(10)),
                child: Text("说点什么吧...", style: KFontConstant.grayText()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getVideoManage() {
    var formData = {"id": "${widget.id}"};
    RequestMap.getCourseVideoManage(
      ShowLoadingIntercept(this, isInit: true),
      formData,
    ).listen(
      (data) {
        pageStatue = LoadingWidgetStatue.NONE;
        this.data = data.data!;

        for (int i = 0; i < (data.data?.courseVideos?.length ?? 0); i++) {
          if (widget.videoId == data.data?.courseVideos?[i].id) {
            selectIndex = i;
          }
        }
        playUrl = data.data?.courseVideos?[selectIndex].url ?? '';
        _setPlaySource(
          playUrl,
          data.data?.courseVideos![selectIndex].name ?? '',
        );
        setState(() {});
        _getCommentList();
      },
      onError: (err) {
        print("${err.message}");
        setState(() {
          pageStatue = LoadingWidgetStatue.ERROR;
        });
      },
    );
  }

  _title() {
    return Container(
      color: KColorConstant.white,
      padding: EdgeInsets.all(ScreenUtil.L(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: ScreenUtil.L(10)),
            child: Text(
              "课程名称:${data.courseName}",
              style: KFontConstant.themTitleBigBold(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: ScreenUtil.L(10)),
            child: Text(
              "正在播放:${data.courseVideos?[selectIndex].name}",
              style: KFontConstant.grayText(),
            ),
          ),
          _jiaohuWidget(data.courseVideos![selectIndex]),
        ],
      ),
    );
  }

  _topWidget() {
    return FijkView(
      player: player,
      fit: FijkFit.ar16_9,
      width: ScreenUtil.L(360),
      height: ScreenUtil.L(200),
      panelBuilder:
          (
            FijkPlayer player,
            FijkData data,
            BuildContext context,
            Size viewSize,
            Rect texturePos,
          ) {
            /// 使用自定义的布局
            return CustomFijkWidgetBottom(
              player: player,
              buildContext: context,
              viewSize: viewSize,
              texturePos: texturePos,
            );
          },
    );
  }

  //交互widget
  _jiaohuWidget(CourseVideos data) {
    return Container(
      width: ScreenUtil.screenWidth,
      margin: EdgeInsets.only(left: ScreenUtil.L(30), right: ScreenUtil.L(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _jiaohuItem(
            data,
            data.likeNum ?? '',
            data.isLike == "1"
                ? "images/dianzhan_true.png"
                : "images/dianzhan_false.png",
            "点赞",
          ),
          _jiaohuItem(
            data,
            data.dislikeNum ?? '',
            data.isDisLike == "1"
                ? "images/diancai_true.png"
                : "images/diancai_false.png",
            "点踩",
          ),
          _jiaohuItem(
            data,
            data.collectNum ?? '',
            data.isCollect == "1"
                ? "images/shoucang_true.png"
                : "images/shoucang_false.png",
            "收藏",
          ),
          _jiaohuItem(data, "分享", "images/fenxiang_true.png", "分享"),
          _jiaohuItem(
            data,
            haveHuanCun
                ? "已缓存"
                : loading
                ? "缓存中"
                : "缓存",
            "images/xiazai_true.png",
            "下载",
          ),
        ],
      ),
    );
  }

  _jiaohuItem(CourseVideos data, String num, String image, String tag) {
    return InkWell(
      onTap: () {
        _jiaohuClick(data, tag);
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

  _jiaohuClick(CourseVideos data, String tag) {
    if (tag == "点赞") {
      if (data.isDisLike == "1") {
        showToast("您已点踩，不能点赞");
        return;
      }
      setState(() {
        if (data.isLike != "1") {
          data.likeNum = "${int.parse(data.likeNum ?? '') + 1}";
          data.isLike = "1";
        } else {
          data.likeNum = "${int.parse(data.likeNum ?? '') - 1}";
          data.isLike = "0";
        }
      });
      _likeOrDisLike(true);
    } else if (tag == "点踩") {
      if (data.isLike == "1") {
        showToast("您已点赞，不能点踩");
        return;
      }
      setState(() {
        if (data.isDisLike != "1") {
          data.dislikeNum = "${int.parse(data.dislikeNum ?? '') + 1}";
          data.isDisLike = "1";
        } else {
          data.dislikeNum = "${int.parse(data.dislikeNum ?? '') - 1}";
          data.isDisLike = "0";
        }
      });
      _likeOrDisLike(false);
    } else if (tag == "分享") {
      showShareDialog(
        title: "贝叶斯数学，内容全免费哟，快来下载和我一起学习吧！",
        type: "app",
        id: "${data.id}",
        videoType: "1",
      );
    } else if (tag == "收藏") {
      _topicCollect();
      setState(() {
        if (data.isCollect != "1") {
          data.collectNum = "${int.parse(data.collectNum ?? '') + 1}";
          data.isCollect = "1";
        } else {
          data.collectNum = "${int.parse(data.collectNum ?? '') - 1}";
          data.isCollect = "0";
        }
      });
    } else if (tag == "下载") {
      if (haveHuanCun) {
        return;
      }
      showToast("开始下载...");
      var name = data.url?.split("/");
      start(name![name.length - 1], data.url ?? '');
    }
  }

  String sDCardDir = "";
  bool loading = false;

  start(String name, String url) async {
    if (sDCardDir == "")
      // ignore: curly_braces_in_flow_control_structures
      sDCardDir = (await getExternalStorageDirectory())?.path ?? '';
    var savePath = "$sDCardDir/videoBys/$name";
    File f = File("$sDCardDir/videoBys");
    if (!await f.exists()) {
      Directory("$sDCardDir/videoBys").createSync();
    }
    loading = true;
    setState(() {});

    double currentProgress = 0.0;

    ///创建DIO
    Dio dio = Dio();

    ///参数一 文件的网络储存URL
    ///参数二 下载的本地目录文件
    ///参数三 下载监听
    dio
        .download(
          url,
          savePath,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              ///当前下载的百分比例
              print("${(received / total * 100).toStringAsFixed(0)}%");
              // CircularProgressIndicator(value: currentProgress,) 进度 0-1
              currentProgress = received / total;
            }
          },
        )
        .then(
          (value) => () {
            haveHuanCun = true;
            setState(() {});
            showToast("下载完成");
          },
          onError: () {
            loading = false;
            setState(() {});
            showToast("下载失败");
          },
        );
  }

  @override
  Widget FloatingAction() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: ScreenUtil.L(10)),
          child: InkWell(
            child: Container(
              width: ScreenUtil.L(50),
              height: ScreenUtil.L(50),
              decoration: KBoxStyle.nextBtn(),
              alignment: Alignment.center,
              child: Text("课后\n练习", style: KFontConstant.whiteTextBig()),
            ),
            onTap: () {
              //              Navigator.of(context).pop();
              player.pause();
              //前往课后练习
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectPage(
                    type: "课后练习",
                    id: data.courseVideos?[selectIndex].id,
                    subject: data.subject,
                    thematic: data.thematic,
                  ),
                ),
              );
            },
          ),
        ),
        // Container(
        //   margin: EdgeInsets.only(bottom: ScreenUtil.L(50)),
        //   width: ScreenUtil.L(50),
        //   height: ScreenUtil.L(50),
        //   alignment: Alignment.center,
        //   decoration: KBoxStyle.nextBtn(),
        //   child: InkWell(
        //     child: Text("吐槽", style: KFontConstant.whiteTextBig()),
        //     onTap: () {
        //       player.pause();
        //       //前往发布吐槽
        //       goTucao();
        //     },
        //   ),
        // ),
      ],
    );
  }

  ///点赞和点踩
  _likeOrDisLike(bool like) {
    var formData = {
      "topicId": "${data.courseVideos?[selectIndex].id}",
      "topicType": "5000", //主题类型（评论：1000，吐槽：2000  试题：3000  视频：4000  课程视频：5000）
    };
    if (like)
      // ignore: curly_braces_in_flow_control_structures
      RequestMap.topicLike(null, formData).listen(
        (data) {},
        onError: (err) {
          print(err.message);
        },
      );
    else
      // ignore: curly_braces_in_flow_control_structures
      RequestMap.topicDisLike(
        null,
        formData,
      ).listen((data) {}, onError: (err) {});
  }

  List<CommentContent>? listContent;

  ///获取视频评论列表
  _getCommentList() {
    var formData = {
      "pageNum": "1",
      "pageSize": "20",
      "topicType": "3", //主题类型 0 : 吐槽评论  1：视频评论 2：试题评论 3：课程评论
      "topicId": "${data.courseVideos?[selectIndex].id}",
      "courseManageId": "${widget.id}",
    };
    RequestMap.getCommentList(
      ShowLoadingIntercept(this, isInit: true),
      formData,
    ).listen((data) {
      setState(() {
        listContent = data.data?.content;
      });
    }, onError: (err) {});
  }

  //评论列表
  _complaintsWidget() {
    return Container(
      decoration: KBoxStyle.whiteItemStyle(),
      margin: EdgeInsets.only(top: ScreenUtil.L(15), bottom: ScreenUtil.L(30)),
      padding: EdgeInsets.only(bottom: ScreenUtil.L(20)),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(
              left: ScreenUtil.L(20),
              top: ScreenUtil.L(15),
            ),
            child: Text("精彩评论", style: KFontConstant.blackTextBigBold()),
          ),
          _pinglunContent(),
        ],
      ),
    );
  }

  //评论的布局
  _pinglunContent() {
    if (listContent?.isEmpty ?? false) {
      return baseStatueWidget(LoadingWidgetStatue.DATAEMPTY);
    }
    List<Widget> widgets = [];
    for (int i = 0; i < (listContent?.length ?? 0); i++) {
      widgets.add(CommentItem(content: listContent?[i]));
    }
    return Wrap(children: widgets);
  }

  ///用户收藏
  _topicCollect() {
    var formData = {
      "topicId": "${data.courseVideos?[selectIndex].id}",
      "topicType": "6000", //主题类型（评论：1000，吐槽：2000  试题：3000  视频：4000  课程视频：5000）
    };
    RequestMap.topicCollect(null, formData).listen(
      (data) {},
      onError: (err) {
        print("${err.message}");
      },
    );
  }

  @override
  void onCreate() {
    setAppBarVisible(true);
    setTopBarVisible(true);
    WakelockPlus.enable();
    setAppBarTitle("课程视频");

    SpConstanst().setVideoSpeed(1.0);
    _getDataPath();
    _getVideoManage();
    //    _getCommentList();
  }

  @override
  void onPause() {
    player.pause();
  }

  @override
  void onResume() {
    //    player.start();
  }

  final Null _controller = null;

  ///课程视频列表
  _videoListWidget() {
    // ignore: prefer_is_empty
    if (data.courseVideos?.length == 0) {
      return Container();
    }
    return Container(
      color: KColorConstant.white,
      width: ScreenUtil.screenWidth,
      padding: EdgeInsets.only(top: ScreenUtil.L(15)),
      margin: EdgeInsets.only(top: ScreenUtil.L(15)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _controller,
        padding: EdgeInsets.only(
          left: ScreenUtil.L(15),
          right: ScreenUtil.L(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _videosList(),
        ),
      ),
    );
  }

  List<Widget> _videosList() {
    List<Widget> listWidget = [];
    for (var i = 0; i < (data.courseVideos?.length ?? 0); i++) {
      listWidget.add(_videoItemUI(i));
    }
    return listWidget;
  }

  Widget _videoItemUI(int index) {
    return Container(
      margin: EdgeInsets.only(
        bottom: ScreenUtil.L(15),
        right: ScreenUtil.L(15),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            selectIndex = index;
          });
          //切换播放视频
          player.reset().then((value) {
            playUrl = data.courseVideos![selectIndex].url!;
            _setPlaySource(playUrl, data.courseVideos![selectIndex].name ?? '');
          });
          _getCommentList();
        },
        child: Container(
          height: ScreenUtil.L(100),
          width: ScreenUtil.L(180),
          decoration: KBoxStyle.grayBgStyle(),
          child: Container(
            padding: EdgeInsets.all(ScreenUtil.L(10)),
            height: ScreenUtil.L(100),
            alignment: Alignment.center,
            child: Text(
              "${data.courseVideos?[index].name}",
              style: index == selectIndex
                  ? KFontConstant.themTitleBigBold()
                  : KFontConstant.blackTextBig(),
            ),
          ),
        ),
      ),
    );
  }

  List<String> filePaths = [];

  _getDataPath() async {
    // 打印出test文件夹下文件的路径
    sDCardDir = (await getExternalStorageDirectory())?.path ?? '';
    Directory directory = Directory('$sDCardDir/videoBys');
    directory.listSync().forEach((file) {
      print(file.path);
      filePaths.add(file.path);
    });
    setState(() {});
  }

  bool haveHuanCun = false;

  _setPlaySource(String url, String name) async {
    String playPath = "";
    for (String pa in filePaths) {
      var path = pa.split("/");
      if (name == path[path.length - 1].split(".")[0]) {
        playPath = pa;
        break;
      }
    }
    await player.setOption(1, "analyzemaxduration", 100);
    await player.setOption(1, "probesize", 1024 * 10);
    await player.setOption(1, "flush_packets", 1);
    await player.setOption(4, "packet-buffering", 0);
    await player.setOption(4, "framedrop", 5);

    await player.setOption(FijkOption.formatCategory, "analyzeduration", 1);
    await player.setOption(
      FijkOption.playerCategory,
      "enable-accurate-seek",
      10,
    );
    //设置缓冲区大小
    await player.setOption(
      FijkOption.playerCategory,
      "max-buffer-size",
      1024 * 100,
    );
    //设置seekTo能够快速seek到指定位置并播放
    await player.setOption(FijkOption.formatCategory, "fflags", "fastseek");

    await player.setOption(FijkOption.playerCategory, "soundtouch", 1);

    await player.setOption(
      FijkOption.playerCategory,
      "cover-after-prepared",
      1,
    );

    if (playPath != "") {
      showToast("正在播放缓存视频");
      haveHuanCun = true;
      await player.setDataSource(playPath, autoPlay: false);
      await player.prepareAsync();
    } else {
      haveHuanCun = false;
      await player.setDataSource(url, autoPlay: false);
      await player.prepareAsync();
    }
    await player.start();
    setState(() {});
  }

  ///相关知识点展示
  _otherVideoWidgets() {
    List<AboutVideolist>? aboutVideolist =
        data.courseVideos![selectIndex].aboutVideolist;
    if (aboutVideolist?.isEmpty ?? true) {
      return Container();
    }
    List<Widget> widgets = [];
    widgets.add(
      Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(
          left: ScreenUtil.L(20),
          top: ScreenUtil.L(15),
          bottom: ScreenUtil.L(5),
        ),
        child: Text("相关知识点", style: KFontConstant.blackTextBigBold()),
      ),
    );
    for (int i = 0; i < (aboutVideolist?.length ?? 0); i++) {
      widgets.add(
        OtherVideoItem(
          index: i,
          name: aboutVideolist?[i].name ?? '',
          id: aboutVideolist?[i].cvId,
          time: aboutVideolist?[i].time,
          videoId: aboutVideolist?[i].cvId,
          itemClick: () {
            player.pause();
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (_) => VideoPage2(
                  id: aboutVideolist?[i].cmId,
                  videoId: aboutVideolist?[i].cvId,
                ),
              ),
            );
          },
        ),
      );
    }
    return Container(
      decoration: KBoxStyle.whiteItemStyle(),
      padding: EdgeInsets.only(bottom: ScreenUtil.L(15)),
      margin: EdgeInsets.only(top: ScreenUtil.L(15)),
      child: Column(children: widgets),
    );
  }

  @override
  void dispose() {
    super.dispose();
    WakelockPlus.disable();

    player.release();
  }

  @override
  void onBackground() {
    player.pause();
    super.onBackground();
  }
}
