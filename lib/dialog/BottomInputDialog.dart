import 'package:dio/dio.dart';
import 'package:erp_music/constant/color.dart';
import 'package:erp_music/network/requestUtil.dart';
import 'package:erp_music/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BottomInputDialog extends StatelessWidget {
  TextEditingController controller = new TextEditingController();
  int id;
  int parentId;

  //主题类型 0 : 吐槽评论  1：视频评论 2：试题评论 3：课程评论
  int type;

  BottomInputDialog({int id, int parentId = 0, int type = 0}) {
    this.id = id;
    this.parentId = parentId;
    this.type = type;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.transparent,
        body: new Column(children: <Widget>[
          Expanded(
              child: new GestureDetector(
            child: new Container(
              color: Colors.black38,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )),
          new Container(
            height: ScreenUtil().L(40),
            color: KColorConstant.white,
            child: Wrap(
              children: <Widget>[
                Container(
                  child: TextField(
                    controller: controller,
                    autofocus: true,
                    maxLines: 100,
                  ),
                  width: ScreenUtil.screenWidth - ScreenUtil().L(50),
                ),
                InkWell(
                  onTap: () {
                    if (controller.text.length < 5) {
                      showToast("最少评论5个字符~");
                      return;
                    }
                    _sendComment(context);
                  },
                  child: Container(
                    color: KColorConstant.themeColor,
                    alignment: Alignment.center,
                    child: Text("发送"),
                    width: ScreenUtil().L(50),
                    height: ScreenUtil().L(40),
                  ),
                ),
              ],
            ),
          )
        ]));
  }

  ///发布评论
  _sendComment(context) {
    var formData = {
      "content": "${controller.text}",
      "topicType": "$type", //主题类型 0 : 吐槽评论  1：视频评论  2：试题评论 3:课程里面的视频评论
      "topicId": "$id",
      "courseManageId": "$parentId",//课程id
    };
    RequestMap.commentInsert(null, formData).listen((data) {
      Navigator.pop(context);
    }, onError: (err) {});
  }

  ///弹吐司
  void showToast(String content,
      {Toast length = Toast.LENGTH_SHORT,
      ToastGravity gravity = ToastGravity.CENTER,
      Color backColor = Colors.black87,
      Color textColor = KColorConstant.white}) {
    if (content != null) {
      if (content != null && content.isNotEmpty) {
        Fluttertoast.showToast(
            msg: content,
            toastLength: length,
            gravity: gravity,
            timeInSecForIos: 1,
            backgroundColor: backColor,
            textColor: textColor,
            fontSize: 13.0);
      }
    }
  }
}
