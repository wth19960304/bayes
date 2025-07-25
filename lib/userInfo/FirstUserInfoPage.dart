import 'dart:io';

import 'package:bayes/base/base_widget.dart';
import 'package:bayes/base/common_function.dart';
import 'package:bayes/bean/NianjiBean.dart';
import 'package:bayes/bean/UserInfoBean.dart';
import 'package:bayes/constant/color.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/dialog/cityselect_dialog.dart';
import 'package:bayes/dialog/select_dialog.dart';
import 'package:bayes/home/MainPage.dart';
import 'package:bayes/network/intercept/showloading_intercept.dart';
import 'package:bayes/network/requestUtil.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:bayes/utils/sp_constant.dart';
import 'package:bayes/utils/sp_utils.dart';
import 'package:bayes/widget/image_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:permission_handler/permission_handler.dart';

///用户资料完善
// ignore: must_be_immutable
class FirstUserInfoPage extends BaseWidget {
  bool login;

  FirstUserInfoPage({super.key, this.login = false});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _FirstUserInfoPageState();
  }
}

class _FirstUserInfoPageState extends BaseWidgetState<FirstUserInfoPage> {
  TextEditingController txtController1 = TextEditingController();
  // ignore: avoid_init_to_null
  UserInfoData? data;

  @override
  Widget buildWidget(BuildContext context) {
    // ignore: unnecessary_null_comparison

    // ignore: unnecessary_null_comparison
    if (data == null) {
      return baseStatueWidget(LoadingWidgetStatue.LOADING);
    }
    return Stack(
      children: <Widget>[
        Image.asset(
          "images/regi_bg.png",
          height: getImageHeight(750, 404, ScreenUtil.screenWidth ?? 0),
          width: ScreenUtil.screenWidth,
          fit: BoxFit.fill,
        ),
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: ScreenUtil.L(24)),
              alignment: Alignment.topLeft,
              child: getAppBarLeft(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        _selectOnTap(tag: 99);
                      },
                      child: Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(
                          left: ScreenUtil.L(35),
                          top: ScreenUtil.L(10),
                          bottom: ScreenUtil.L(5),
                        ),
                        // ignore: prefer_is_empty
                        child: data?.headImg?.length == 0
                            ? Image.asset(
                                "images/user_header.png",
                                height: ScreenUtil.L(55),
                                width: ScreenUtil.L(55),
                                fit: BoxFit.cover,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil.L(30)),
                                ),
                                child: CachedNetworkImage(
                                  height: ScreenUtil.L(55),
                                  width: ScreenUtil.L(55),
                                  imageUrl: "${data?.headImg?[0].url}",
                                  placeholder: (context, url) =>
                                      ImageLoadingPage(width: 20.0),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: ScreenUtil.L(30)),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "点击修改头像",
                        style: KFontConstant.grayTextSmall(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: ScreenUtil.L(30),
                        top: ScreenUtil.L(15),
                      ),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "完善个人资料",
                        style: KFontConstant.blackBigBigText(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: ScreenUtil.L(30),
                        top: ScreenUtil.L(5),
                      ),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "注：分科半年内只能修改一次",
                        style: KFontConstant.themeText(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: ScreenUtil.L(30),
                        right: ScreenUtil.L(30),
                        top: ScreenUtil.L(30),
                        bottom: ScreenUtil.L(25),
                      ),
                      child: TextField(
                        style: KFontConstant.blackTextBig(),
                        controller: txtController1,
                        decoration: inputDecoration(
                          label: "昵称",
                          errorString: "",
                          error: false,
                        ),
                      ),
                    ),
                    selectWidget(
                      tag: 1,
                      title: "请选择身份",
                      selectString: (data?.userType!.length ?? 0) < 2
                          ? "请选择"
                          : data?.userType ?? "",
                    ),
                    selectWidget(
                      tag: 2,
                      title: "性别",
                      selectString: data?.sex ?? "",
                    ),
                    Visibility(
                      visible: data?.userType != "老师",
                      child: selectWidget(
                        tag: 3,
                        title: "年级",
                        selectString: (data?.grade!.length ?? 0) < 2
                            ? "请选择"
                            : data?.grade ?? "",
                      ),
                    ),
                    Visibility(
                      visible: data?.userType != "老师",
                      child: selectWidget(
                        tag: 4,
                        title: "分科",
                        selectString: (data?.division!.length ?? 0) < 2
                            ? "请选择"
                            : data?.division ?? "",
                      ),
                    ),
                    Visibility(
                      visible: data?.userType != "老师",
                      child: selectWidget(
                        tag: 5,
                        title: "数学成绩",
                        selectString: (data?.mathScores!.length ?? 0) < 2
                            ? "请选择"
                            : data?.mathScores ?? "",
                      ),
                    ),
                    selectWidget(
                      tag: 6,
                      title: "学校地区",
                      selectString: (data?.position!.length ?? 0) < 2
                          ? "请选择"
                          : data?.position ?? "",
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: ScreenUtil.L(50),
                        right: ScreenUtil.L(50),
                        top: ScreenUtil.L(10),
                        bottom: ScreenUtil.L(30),
                      ),
                      child: raisedNextButton("保存修改"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _selectOnTap({required int tag}) {
    FocusScope.of(context).requestFocus(FocusNode());
    switch (tag) {
      case 1:
        var type = ["学生", "家长", "老师"];
        showDialog<int>(
          context: context, //BuildContext对象
          barrierDismissible: true,
          builder: (BuildContext context) {
            int index = -1;
            for (int i = 0; i < type.length; i++) {
              if (type[i] == data?.userType) {
                index = i;
              }
            }
            return SelectDialog(index, type, "设置身份");
          },
        ).then((value) {
          if (value != null) {
            setState(() {
              data?.userType = type[value];
            });
          }
        });
        break;
      case 2:
        showDialog<int>(
          context: context, //BuildContext对象
          barrierDismissible: true,
          builder: (BuildContext context) {
            return SelectDialog(
              data?.sex == "男" ? 0 : (data?.sex == "女" ? 1 : -1),
              ["男", "女"],
              "设置性别",
            );
          },
        ).then((value) {
          if (value != null) {
            setState(() {
              data?.sex = value == 0 ? "男" : "女";
            });
          }
        });
        break;
      case 3:
        List<String> type = [];
        for (int i = 0; i < nianjiData.length; i++) {
          type.add(nianjiData[i].gradeName ?? "");
        }
        showDialog<int>(
          context: context, //BuildContext对象
          barrierDismissible: true,
          builder: (BuildContext context) {
            int index = -1;
            return SelectDialog(index, type, "设置年级");
          },
        ).then((value) {
          if (value != null) {
            setState(() {
              data?.grade = type[value];
            });
          }
        });
        break;
      case 4:
        var type = ["文科", "理科", "其它"];
        showDialog<int>(
          context: context, //BuildContext对象
          barrierDismissible: true,
          builder: (BuildContext context) {
            int index = -1;
            return SelectDialog(index, type, "设置分科");
          },
        ).then((value) {
          if (value != null) {
            setState(() {
              data?.division = type[value];
            });
          }
        });
        break;
      case 5:
        var type = [
          "0~10",
          "11~20",
          "21~30",
          "31~40",
          "41~50",
          "51~60",
          "61~70",
          "71~80",
          "81~90",
          "91~100",
          "101~110",
          "111~120",
          "121~130",
          "131~140",
          "141~150",
        ];
        showDialog<int>(
          context: context, //BuildContext对象
          barrierDismissible: true,
          builder: (BuildContext context) {
            int index = -1;
            return SelectDialog(index, type, "设置分科");
          },
        ).then((value) {
          if (value != null) {
            setState(() {
              data?.mathScores = type[value];
            });
          }
        });
        break;
      case 6:
        show();
        break;
      case 99:
        _checkPersmission();
        break;
    }
  }

  void _checkPersmission() async {
    if (kIsWeb) {
      return;
    }
    bool hasPermission = await Permission.storage.request().isGranted;
    if (!hasPermission) {
      showToast("您拒绝了我们获取储存权限，请先前往[设置-应用管理-权限获取]打开权限");
      return;
    }
    // _selectedImage();
  }

  ///获取图片
  void _selectedImage() {
    // PhotoPicker.pickAsset(
    //   context: context,
    //   themeColor: KColorConstant.greyColor,
    //   padding: 1.0,
    //   dividerColor: Colors.grey,
    //   disableColor: Colors.grey.shade300,
    //   itemRadio: 0.88,
    //   maxSelected: 1,
    //   provider: I18nProvider.chinese,
    //   rowCount: 3,
    //   textColor: KColorConstant.white,
    //   thumbSize: 250,
    //   sortDelegate: SortDelegate.common,
    //   checkBoxBuilderDelegate: DefaultCheckBoxBuilderDelegate(
    //     activeColor: KColorConstant.white,
    //     unselectedColor: KColorConstant.white,
    //     checkColor: Colors.blue,
    //   ),
    //   badgeDelegate: const DefaultBadgeDelegate(),

    //   pickType: PickType.onlyImage, // all/image/video
    // ).then((value) {
    //   if (value == null) return;
    //   value[0].file.then((file) {
    //     _setOneImage(file);
    //   });
    // });
  }

  int maxImageSize = 3;

  ///修改头像
  _setOneImage(File imageFile) {
    FlutterNativeImage.compressImage(
      imageFile.path,
      quality: 70,
      percentage: 50,
    ).then((file) async {
      imageFile.path.substring(
        imageFile.path.lastIndexOf("/") + 1,
        imageFile.path.length,
      );
      var formData = {
        "file": await MultipartFile.fromFile(
          imageFile.path,
          filename:
              "${SpUtils().getString(SpConstanst.USER_ID)}${DateTime.now().microsecondsSinceEpoch}",
        ),
      };
      //上传单张图片
      RequestMap.resourcesSaves(ShowLoadingIntercept(this), formData).listen(
        (da) {
          //更改头像
          setState(() {
            HeadImg ima = HeadImg(name: da.data?[0].name, url: da.data?[0].url);
            data?.headImg?.clear();
            data?.headImg?.add(ima);
          });
        },
        onError: (err) {
          print(err.message);
        },
      );
    });
  }

  show() async {
    //启动底部弹窗
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CitySelectDialog();
      },
    ).then((value) {
      //处理弹窗返回的参数
      if (value == null) {
        return;
      }
      data?.provincialId = value['sheng'];
      data?.cityId = value['shi'];
      data?.areaId = value['qu'];
      setState(() {
        data?.position = value['name'];
      });
    });
  }

  ///通用下拉选择布局
  Widget selectWidget({
    required int tag,
    required String title,
    String selectString = "请选择",
  }) {
    return InkWell(
      onTap: () {
        _selectOnTap(tag: tag);
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: ScreenUtil.L(25),
          left: ScreenUtil.L(30),
          right: ScreenUtil.L(30),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(title, style: KFontConstant.grayText()),
                Row(
                  children: <Widget>[
                    Text(selectString, style: KFontConstant.blackTextBig()),
                    Container(
                      margin: EdgeInsets.only(left: ScreenUtil.L(5)),
                      child: Image.asset(
                        "images/right_go.png",
                        height: ScreenUtil.L(18),
                        width: ScreenUtil.L(15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil.L(15)),
              width: ScreenUtil.screenWidth,
              height: ScreenUtil.L(0.5),
              color: KColorConstant.lineColor,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void btnNext(int buttonTag) {
    super.btnNext(buttonTag);

    if (txtController1.text.isEmpty) {
      showToast("请输入昵称");
      return;
    }
    if (data?.position == "") {
      showToast("请选择学校地区");
      return;
    }
    if (data?.userType == "") {
      showToast("请选择身份");
      return;
    }

    String content = "[";
    for (int i = 0; i < (data?.headImg!.length ?? 0); i++) {
      content +=
          "{\"name\":\"${data?.headImg?[i].name}\",\"url\":\"${data?.headImg?[i].url}\"}";
      if (i != data!.headImg!.length - 1) {
        content += ",";
      }
    }
    content += "]";
    if (data?.userType != "老师") {
      if (data?.grade == "") {
        showToast("请选择年级");
        return;
      }
      if (data?.division == "") {
        showToast("请选择分科");
        return;
      }
      if (data?.mathScores == "") {
        showToast("请选择数学成绩");
        return;
      }
    }

    ///提交修改

    Map<String, dynamic> map = {
      "nickname": txtController1.text,
      "sex": "${data?.sex}",
      "headImg": content,
      "grade": "${data?.grade}",
      "userType": "${data?.userType}",
      "division": "${data?.division}",
      "mathScores": "${data?.mathScores}",
      "provincialName": data?.position?.split(" ")[0],
      "cityName": data?.position?.split(" ")[1],
      "areaName": data?.position?.split(" ")[2],
      "position": "${data?.position}", //地区
      "provincialId": "${data?.provincialId}",
      "cityId": "${data?.cityId}",
      "areaId": "${data?.areaId}",
    };
    print(map.toString());
    RequestMap.insertUserInfo(ShowLoadingIntercept(this), map).listen(
      (data) {
        showToast("保存修改成功");
        Navigator.pop(context);
        if (widget.login) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
          );
        }
      },
      onError: (err) {
        showToast(err.message);
      },
    );
  }

  late String path;

  @override
  void onCreate() {
    setAppBarVisible(false);
    floatingShow = false;
    _getNianji();
    _getUserInfo();
  }

  late List<Data> nianjiData;

  _getNianji() {
    ///获取年级列表
    var formData = {"page": "1"};
    RequestMap.getNameList(
      ShowLoadingIntercept(this, isInit: true),
      formData,
    ).listen(
      (data) {
        nianjiData = data.data!.cast<Data>();
      },
      onError: (err) {
        showToast(err.message);
      },
    );
  }

  ///获取用户信息
  _getUserInfo() {
    var formData = {"page": "1"};
    RequestMap.getUserInfo(
      ShowLoadingIntercept(this, isInit: true),
      formData,
    ).listen(
      (data) {
        txtController1.text =
            ((data.data?.nickname == null || data.data?.nickname == "null")
            ? ""
            : data.data?.nickname)!;
        setState(() {
          this.data = data.data!;
        });
      },
      onError: (err) {
        print(err.message);
        showToast(err.message);
      },
    );
  }

  @override
  void onPause() {}

  @override
  void onResume() {}
}
