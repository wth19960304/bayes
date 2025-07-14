import 'package:bayes/constant/color.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/network/requestUtil.dart';
import 'package:bayes/utils/fluwx_util.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluwx/fluwx.dart';
import 'package:tencent_kit/tencent_kit.dart';

///分享dialog
// ignore: must_be_immutable
class ShareDialog extends StatelessWidget {
  String url = "";
  String title = "";
  String type = "";
  String id = "";
  String videoType = "";

  ShareDialog({
    super.key,
    required this.title,
    required this.url,
    required this.type,
    this.id = "",
    this.videoType = "",
  });

  @override
  Widget build(BuildContext context) {
    Duration insetAnimationDuration = const Duration(milliseconds: 100);
    Curve insetAnimationCurve = Curves.decelerate;

    RoundedRectangleBorder defaultDialogShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    );
    if (id == "null") {
      id = "";
    }
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Container(
          alignment: Alignment.bottomLeft,
          child: SizedBox(
            width: ScreenUtil.screenWidth,
            height: ScreenUtil.L(160),
            child: Material(
              elevation: 24.0,
              color: Theme.of(context).dialogTheme.backgroundColor,
              type: MaterialType.card,
              //-------------上面是dialog的内容布局--------------
              shape: defaultDialogShape,
              //---------------下面是dialog布局----------------
              child: Container(
                decoration: ShapeDecoration(
                  color: Color(0xffffffff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        top: ScreenUtil.L(18),
                        left: ScreenUtil.L(20),
                        bottom: ScreenUtil.L(15),
                      ),
                      child: Text(
                        "分享给好友",
                        style: KFontConstant.blackTextBigBold(),
                      ),
                    ),
                    Container(height: 0.5, color: KColorConstant.lineColor),
                    Container(
                      padding: EdgeInsets.only(
                        left: ScreenUtil.L(25),
                        right: ScreenUtil.L(25),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _lisetWidget(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _lisetWidget(context) {
    List<Widget> listWidget = [];
    listWidget.add(_widgetItem("微信好友", "images/weixin_huihua.png"));
    listWidget.add(_widgetItem("朋友圈", "images/wx_pyq.png"));
    listWidget.add(_widgetItem("QQ好友", "images/qq_huihua.png"));
    listWidget.add(_widgetItem("QQ动态", "images/qq_pyq.png"));
    return listWidget;
  }

  Future<Uint8List> _loadImageData(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    return data.buffer.asUint8List();
  }

  ///单个item
  _widgetItem(String titles, String images) {
    return GestureDetector(
      onTap: () async {
        if (kDebugMode) {
          // ignore: unnecessary_null_comparison
          print(id == null ? url1 : "$url2?id=$id&videoType=$videoType");
        }
        final Uint8List thumbData = await _loadImageData('images/logo.png');
        if (titles == "微信好友") {
          if (!(await FluwxUtil.instance.isWeChatInstalled)) {
            showToast("请安装微信");
            return;
          }

          FluwxUtil.instance
              .share(
                WeChatShareWebPageModel(
                  // ignore: unnecessary_null_comparison
                  id == null
                      ? url1
                      : "$url2?id=$id&videoType=$videoType", // 改用webPage参数
                  title: title,
                  thumbData: thumbData,
                  scene: WeChatScene.session,
                ),
              )
              .then((result) {
                showToast(result ? "分享成功" : "分享失败");
              });
        } else if (titles == "朋友圈") {
          if (!(await FluwxUtil.instance.isWeChatInstalled)) {
            showToast("请安装微信");
            return;
          }
          FluwxUtil.instance.share(
            WeChatShareWebPageModel(
              // ignore: unnecessary_null_comparison
              id == null ? url1 : "$url2?id=$id&videoType=$videoType",
              title: title,
              thumbData: thumbData,
              scene: WeChatScene.timeline,
            ),
          );
        } else if (titles == "QQ好友") {
          if (!(await TencentKitPlatform.instance.isQQInstalled())) {
            showToast("请安装QQ");
            return;
          }
          _handleShareToQQ();
        } else if (titles == "QQ动态") {
          if (!(await TencentKitPlatform.instance.isQQInstalled())) {
            showToast("请安装QQ");
            return;
          }
          _handleShareToQZone();
        }
        //记录分享数量
        RequestMap.addShareRecordLog(null, formData: {"": ""});
        showToast("分享到$titles");
      },
      child: Container(
        color: KColorConstant.white,
        padding: EdgeInsets.only(
          top: ScreenUtil.L(15),
          bottom: ScreenUtil.L(15),
        ),
        child: Column(
          children: <Widget>[
            Container(
              width: ScreenUtil.L(35),
              height: ScreenUtil.L(35),
              margin: EdgeInsets.only(bottom: ScreenUtil.L(10)),
              child: Image.asset(images),
            ),
            Text(titles, style: KFontConstant.defaultText()),
          ],
        ),
      ),
    );
  }

  String url1 = "http://101.132.125.164:8080/learn/index1.html";
  String url2 = "http://101.132.125.164:8080/learn";

  Future<Null> _handleShareToQQ() async {
    await TencentKitPlatform.instance.registerApp(appId: "101887594");
    // ShareQQContent shareContent = ShareQQContent(
    //   title: "贝叶斯数学",
    //   // ignore: unnecessary_null_comparison
    //   targetUrl: id == null ? url1 : "$url2?id=$id&videoType=$videoType",
    //   summary: title,
    //   imageUrl: "http://101.132.125.164:8080/bys/1.png",
    //   //      imageUrl: "http://inews.gtimg.com/newsapp_bt/0/876781763/1000",
    // );
    // try {
    //   var qqResult = await FlutterQq.shareToQQ(shareContent);
    //   String output;
    //   if (qqResult.code == 0) {
    //     output = "分享成功";
    //   } else if (qqResult.code == 1) {
    //     output = "分享失败" + qqResult.message;
    //   } else {
    //     output = "用户取消";
    //   }
    //   showToast(output);
    // } catch (error) {
    //   print("flutter_plugin_qq_example:$error");
    // }
    await TencentKitPlatform.instance.shareWebpage(
      scene: TencentScene.kScene_QQ,
      title: '贝叶斯数学',
      // ignore: unnecessary_null_comparison
      targetUrl: id == null ? url1 : "$url2?id=$id&videoType=$videoType",
    );
  }

  Future<Null> _handleShareToQZone() async {
    // FlutterQq.registerQQ('101887594');
    // ShareQzoneContent shareContent = ShareQzoneContent(
    //   title: "贝叶斯数学",
    //   targetUrl: id == null ? url1 : "$url2?id=$id&videoType=$videoType",
    //   summary: title,
    //   imageUrl: "http://101.132.125.164:8080/bys/1.png",
    // );
    // try {
    //   var qqResult = await FlutterQq.shareToQzone(shareContent);
    //   String output;
    //   if (qqResult.code == 0) {
    //     output = "分享成功";
    //   } else if (qqResult.code == 1) {
    //     output = "分享失败" + qqResult.message;
    //   } else {
    //     output = "用户取消";
    //   }
    //   showToast(output);
    // } catch (error) {
    //   print("flutter_plugin_qq_example:$error");
    // }
    print("test");
  }

  ///弹吐司
  void showToast(
    String content, {
    Toast length = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.CENTER,
    Color backColor = Colors.black87,
    Color textColor = KColorConstant.white,
  }) {
    if (content.isNotEmpty) {
      Fluttertoast.showToast(
        msg: content,
        toastLength: length,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: backColor,
        textColor: textColor,
        fontSize: 13.0,
      );
    }
  }
}
