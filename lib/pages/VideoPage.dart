import 'dart:io';

import 'package:bayes/base/base_widget.dart';
import 'package:bayes/base/common_function.dart';
import 'package:bayes/bean/CommentBean.dart';
import 'package:bayes/bean/VideoDetailBean.dart';
import 'package:bayes/constant/color.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/constant/style.dart';
import 'package:bayes/dialog/BottomInputDialog.dart';
import 'package:bayes/network/intercept/showloading_intercept.dart';
import 'package:bayes/network/requestUtil.dart';
import 'package:bayes/pages/playerKongJian.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:bayes/utils/sp_constant.dart';
import 'package:bayes/widget/CommentItem.dart';
import 'package:dio/dio.dart';
import 'package:fijkplayer_plus/fijkplayer_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

///视频播放
// ignost_be_immutable
// ignore: must_be_immutable
class VideoPage extends BaseWidget {
  int? id;

  VideoPage({super.key, this.id}) {
    id = id;
  }

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _VideoPageState();
  }
}

class _VideoPageState extends BaseWidgetState<VideoPage> {
  late VideoDetailBean data;
  LoadingWidgetStatue pageStatue = LoadingWidgetStatue.LOADING;
  final FijkPlayer player = FijkPlayer();

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
              child: Column(children: <Widget>[_title(), _complaintsWidget()]),
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
                        return BottomInputDialog(id: widget.id, type: 1);
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
    RequestMap.getVideoManage(
      ShowLoadingIntercept(this, isInit: true),
      formData,
    ).listen((data) {
      setState(() {
        pageStatue = LoadingWidgetStatue.NONE;
        this.data = data;
      });
      _setPlaySource();
    }, onError: (err) {});
  }

  bool haveHuanCun = false;

  _setPlaySource() async {
    //    await player.setOption(FijkOption.hostCategory, "request-screen-on", 1);
    //    await player.setOption(FijkOption.hostCategory, "request-audio-focus", 1);
    String playPath = "";
    for (String pa in filePaths) {
      var path = pa.split("/");
      if (data.data?.name == path[path.length - 1].split(".")[0]) {
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
      showToast("正在加载缓存视频");
      haveHuanCun = true;
      await player.setDataSource(playPath, autoPlay: false);
      await player.prepareAsync();
      setState(() {});
    } else {
      await player.setDataSource("${data.data?.url}", autoPlay: false);
      //      await player.start();
      //      await player?.setOption(FijkOption.playerCategory, "cover-after-prepared", 1);
      await player.prepareAsync();
    }
    await player.start();
  }

  List<String> filePaths = [];

  _getDataPath() async {
    // 打印出test文件夹下文件的路径
    sDCardDir = (await getExternalStorageDirectory())!.path;
    Directory directory = Directory('$sDCardDir/videoBys');
    filePaths.clear();
    directory.listSync().forEach((file) {
      print(file.path);
      filePaths.add(file.path);
    });
    setState(() {});
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
              "${data.data?.name}",
              style: KFontConstant.blackTextBig(),
            ),
          ),
          _jiaohuWidget(),
        ],
      ),
    );
  }

  _topWidget() {
    double? width = ScreenUtil.screenWidth;
    double height = ScreenUtil.screenWidth! / 16 * 9;

    return SizedBox(
      width: width,
      height: height,
      child: FijkView(
        player: player,
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
      ),
    );
  }

  //交互widget
  _jiaohuWidget() {
    return Container(
      width: ScreenUtil.screenWidth,
      margin: EdgeInsets.only(left: ScreenUtil.L(30), right: ScreenUtil.L(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _jiaohuItem(
            data.data!.likeNum,
            data.data?.isLike == "1"
                ? "images/dianzhan_true.png"
                : "images/dianzhan_false.png",
            "点赞",
          ),
          _jiaohuItem(
            data.data?.dislikeNum,
            data.data?.isDisLike == "1"
                ? "images/diancai_true.png"
                : "images/diancai_false.png",
            "点踩",
          ),
          _jiaohuItem(
            data.data?.collectNum,
            data.data?.isCollect == "1"
                ? "images/shoucang_true.png"
                : "images/shoucang_false.png",
            "收藏",
          ),
          _jiaohuItem("分享", "images/fenxiang_true.png", "分享"),
          _jiaohuItem(
            haveHuanCun ? "已缓存" : "缓存",
            "images/xiazai_true.png",
            "下载",
          ),
        ],
      ),
    );
  }

  _jiaohuItem(String? num, String? image, String? tag) {
    return InkWell(
      onTap: () {
        _jiaohuClick(tag!);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: ScreenUtil.L(5)),
            width: ScreenUtil.L(35),
            height: ScreenUtil.L(35),
            padding: EdgeInsets.all(ScreenUtil.L(3)),
            child: Image.asset("$image"),
          ),
          Text("$num", style: KFontConstant.grayText()),
        ],
      ),
    );
  }

  _jiaohuClick(String tag) {
    if (tag == "点赞") {
      if (data.data?.isDisLike == "1") {
        showToast("您已点踩，不能点赞");
        return;
      }
      setState(() {
        if (data.data?.isLike != "1") {
          data.data?.likeNum = "${int.parse(data.data?.likeNum ?? '') + 1}";
          data.data?.isLike = "1";
        } else {
          data.data?.likeNum = "${int.parse(data.data?.likeNum ?? '') - 1}";
          data.data?.isLike = "0";
        }
      });
      _likeOrDisLike(true);
    } else if (tag == "点踩") {
      if (data.data!.isLike == "1") {
        showToast("您已点赞，不能点踩");
        return;
      }
      setState(() {
        if (data.data!.isDisLike != "1") {
          data.data?.dislikeNum =
              "${int.parse(data.data!.dislikeNum ?? '') + 1}";
          data.data?.isDisLike = "1";
        } else {
          data.data?.dislikeNum =
              "${int.parse(data.data?.dislikeNum ?? '') - 1}";
          data.data?.isDisLike = "0";
        }
      });
      _likeOrDisLike(false);
    } else if (tag == "分享") {
      showShareDialog(
        title: "贝叶斯数学，内容全免费哟，快来下载和我一起学习吧！",
        type: "app",
        id: "${data.data?.id}",
        videoType: "2",
      );
    } else if (tag == "收藏") {
      _topicCollect();
      setState(() {
        if (data.data?.isCollect != "1") {
          data.data?.collectNum =
              "${int.parse(data.data!.collectNum ?? '') + 1}";
          data.data?.isCollect = "1";
        } else {
          data.data?.collectNum =
              "${int.parse(data.data?.collectNum ?? '') - 1}";
          data.data?.isCollect = "0";
        }
      });
    } else if (tag == "下载") {
      if (haveHuanCun) {
        return;
      }
      showToast("开始下载...");
      var name = data.data?.url?.split("/");
      start(name![name.length - 1], data.data!.url ?? '');
    }
  }

  ///点赞和点踩
  _likeOrDisLike(bool like) {
    var formData = {
      "topicId": "${widget.id}",
      "topicType": "4000", //主题类型（评论：1000，吐槽：2000  试题：3000  视频：4000  课程视频：5000）
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

  late List<CommentContent> listContent;

  ///获取视频评论列表
  _getCommentList() {
    var formData = {
      "pageNum": "1",
      "pageSize": "20",
      "topicType": "1", //主题类型 0 : 吐槽评论  1：视频评论 2：试题评论
      "topicId": "${widget.id}",
    };
    RequestMap.getCommentList(
      ShowLoadingIntercept(this, isInit: true),
      formData,
    ).listen((data) {
      setState(() {
        listContent = data.data!.content!;
      });
    }, onError: (err) {});
  }

  String sDCardDir = "";

  start(String name, String url) async {
    if (sDCardDir == "")
      sDCardDir = (await getExternalStorageDirectory())!.path;

    var savePath = "$sDCardDir/videoBys/$name";
    File f = File("$sDCardDir/videoBys");
    if (!await f.exists()) {
      Directory("$sDCardDir/videoBys").createSync();
    }

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
            }
          },
        )
        .then(
          (value) => () {
            showToast("下载完成");
            // ignore: argument_type_not_assignable_to_error_handler
          },
          onError: () {
            showToast("下载失败");
          },
        );
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
    // ignore: unnecessary_null_comparison, prefer_is_empty
    if (listContent == null || listContent.length == 0) {
      return baseStatueWidget(LoadingWidgetStatue.DATAEMPTY);
    }
    List<Widget> widgets = [];
    for (int i = 0; i < listContent.length; i++) {
      widgets.add(CommentItem(content: listContent[i]));
    }

    return Wrap(children: widgets);
  }

  ///用户收藏
  _topicCollect() {
    var formData = {
      "topicId": "${widget.id}",
      "topicType": "4000", //主题类型（评论：1000，吐槽：2000  试题：3000  视频：4000  课程视频：5000）
    };
    RequestMap.topicCollect(
      null,
      formData,
    ).listen((data) {}, onError: (err) {});
  }

  @override
  void onCreate() {
    setAppBarVisible(true);
    setTopBarVisible(true);
    WakelockPlus.enable();
    SpConstanst().setVideoSpeed(1.0);
    setAppBarTitle("视频播放");
    _getDataPath();
    _getVideoManage();
    _getCommentList();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    player.release();
    super.dispose();
  }

  @override
  void onPause() {
    player.pause();
  }

  @override
  void onResume() {}

  @override
  void onBackground() {
    player.pause();
    super.onBackground();
  }

  @override
  goTucao() {
    player.pause();
    super.goTucao();
  }
}
