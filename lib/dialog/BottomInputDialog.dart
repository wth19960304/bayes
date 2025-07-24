import 'package:bayes/constant/color.dart';
import 'package:bayes/network/requestUtil.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class BottomInputDialog extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  int? id;
  int? parentId;

  //主题类型 0 : 吐槽评论  1：视频评论 2：试题评论 3：课程评论
  int type;

  BottomInputDialog({super.key, this.id, this.parentId = 0, this.type = 0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              child: Container(color: Colors.black38),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            height: ScreenUtil.L(40),
            color: KColorConstant.white,
            child: Wrap(
              children: <Widget>[
                SizedBox(
                  // ignore: sort_child_properties_last
                  child: TextField(
                    controller: controller,
                    autofocus: true,
                    maxLines: 100,
                  ),
                  width: ScreenUtil.screenWidth! - ScreenUtil.L(50),
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
                    // ignore: sort_child_properties_last
                    child: Text("发送"),
                    width: ScreenUtil.L(50),
                    height: ScreenUtil.L(40),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///发布评论
  _sendComment(context) {
    var formData = {
      "content": controller.text,
      "topicType": "$type", //主题类型 0 : 吐槽评论  1：视频评论  2：试题评论 3:课程里面的视频评论
      "topicId": "$id",
      "courseManageId": "$parentId", //课程id
    };
    RequestMap.commentInsert(null, formData).listen((data) {
      Navigator.pop(context);
    }, onError: (err) {});
  }

  ///弹吐司
  void showToast(
    String content, {
    Toast length = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.CENTER,
    Color backColor = Colors.black87,
    Color textColor = KColorConstant.white,
  }) {
    // ignore: unnecessary_null_comparison
    if (content != null) {
      // ignore: unnecessary_null_comparison
      if (content != null && content.isNotEmpty) {
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
}
