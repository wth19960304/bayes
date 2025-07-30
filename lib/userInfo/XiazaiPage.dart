import 'dart:io';

import 'package:bayes/base/base_widget.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/pages/VideoPlayPage.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

//我的缓存列表
class XiazaiPage extends BaseWidget {
  const XiazaiPage({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _XiazaiPageState();
  }
}

class _XiazaiPageState extends BaseWidgetState<XiazaiPage> {
  String sDCardDir = "";

  @override
  Widget buildWidget(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: ScreenUtil.L(0), bottom: ScreenUtil.L(30)),
      itemCount: filePaths.length,
      itemBuilder: (BuildContext context, int index) {
        var path = filePaths[index].split("/");
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoPlayPage(path: filePaths[index]),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(ScreenUtil.L(10)),
            margin: EdgeInsets.only(top: ScreenUtil.L(1)),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    path[path.length - 1],
                    style: KFontConstant.blackTextBigBold(),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _deleteFile(File(filePaths[index]));
                  },
                  child: Container(
                    padding: EdgeInsets.all(ScreenUtil.L(10)),
                    child: Text("删除", style: KFontConstant.themeText()),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _deleteFile(File file) async {
    //  //删除文件
    await file.delete();
    _getData();
  }

  List<String> filePaths = [];

  _getData() async {
    // 打印出test文件夹下文件的路径
    sDCardDir = (await getExternalStorageDirectory())?.path ?? '';
    Directory directory = Directory('$sDCardDir/videoBys');
    filePaths.clear();
    directory.listSync().forEach((file) {
      print(file.path);
      filePaths.add(file.path);
    });
    setState(() {});
  }

  @override
  void onCreate() {
    setTopBarVisible(true);
    setAppBarTitle("我的缓存");
    _getData();
  }

  @override
  void onPause() {}

  @override
  void onResume() {}
}
