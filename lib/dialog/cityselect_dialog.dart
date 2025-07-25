import 'package:bayes/bean/city_model.dart';
import 'package:bayes/constant/color.dart';
import 'package:bayes/constant/font.dart';
import 'package:bayes/dialog/item_city.dart';
import 'package:bayes/network/requestUtil.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///省市区选择控件
// ignore: use_key_in_widget_constructors
class CitySelectDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<CitySelectDialog> {
  //记录选中的下标
  List<int> selectIndex = [-1, -1, -1];
  String selectString = "请选择地址";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: KColorConstant.appBgColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () {
                  btnClick("取消");
                },
                child: Container(
                  // ignore: sort_child_properties_last
                  child: Text(
                    "取消",
                    style: KFontConstant.myTextStyle(
                      color: KColorConstant.greyColor,
                      bold: true,
                    ),
                  ),
                  padding: EdgeInsets.all(ScreenUtil.L(15)),
                ),
              ),
              Text(
                selectString,
                style: KFontConstant.myTextStyle(
                  color: Colors.black,
                  bold: true,
                ),
              ),
              InkWell(
                onTap: () {
                  btnClick("确定");
                },
                child: Container(
                  // ignore: sort_child_properties_last
                  child: Text(
                    "确定",
                    style: KFontConstant.myTextStyle(bold: true),
                  ),
                  padding: EdgeInsets.all(ScreenUtil.L(15)),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              _listItem(citys: citys1, listIndex: 0),
              _listItem(citys: citys2, listIndex: 1),
              _listItem(citys: citys3, listIndex: 2),
            ],
          ),
        ),
      ],
    );
  }

  Widget _listItem({required List<City> citys, required int listIndex}) {
    return SizedBox(
      width: ScreenUtil.L(120),
      child: ListView.builder(
        padding: EdgeInsets.only(top: ScreenUtil.L(0)),
        itemCount: citys.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              if (selectIndex[listIndex] == index) {
                return;
              }
              setState(() {
                selectIndex[listIndex] = index;
              });
              if (listIndex == 0) {
                //清除市区的选项
                selectIndex[1] = -1;
                selectIndex[2] = -1;
                citys2.clear();
                citys3.clear();
                //获取市的数据
                _getCityData(
                  index: listIndex + 1,
                  parentId: citys[index].id ?? 0,
                );
              }
              if (listIndex == 1) {
                //清除区的选项
                selectIndex[2] = -1;
                citys3.clear();
                //获取区的数据
                _getCityData(
                  index: listIndex + 1,
                  parentId: citys[index].id ?? 0,
                );
              }
              if (selectIndex[0] != -1) {
                selectString = "${citys1[selectIndex[0]].districtName}";
              }
              if (selectIndex[1] != -1) {
                selectString += " ${citys2[selectIndex[1]].districtName}";
              }
              if (selectIndex[2] != -1) {
                selectString += " ${citys3[selectIndex[2]].districtName}";
              }
            },
            child: CityItem(
              isSelect: selectIndex[listIndex] == index,
              name: "${citys[index].districtName}",
            ),
          );
        },
        //设置回弹效果
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //获取省数据
    _getCityData(index: 0, parentId: 1);
  }

  //三级城市列表
  List<City> citys1 = [];
  List<City> citys2 = [];
  List<City> citys3 = [];

  void _getCityData({required int index, required int parentId}) async {
    print("$parentId");
    var formData = {"parentId": "$parentId"};
    //获取省市区数据
    RequestMap.getAreaListByParentId(null, formData: formData).listen(
      (da) {
        setState(() {
          switch (index) {
            case 0:
              citys1.clear();
              citys1.addAll(da.data as Iterable<City>);
              break;
            case 1:
              citys2.clear();
              citys2.addAll(da.data as Iterable<City>);
              break;
            case 2:
              citys3.clear();
              citys3.addAll(da.data as Iterable<City>);
              break;
          }
        });
      },
      onError: (err) {
        print(err.message);
      },
    );
  }

  //按钮点击事件
  void btnClick(String text) {
    switch (text) {
      case "确定":
        if (selectIndex.contains(-1)) {
          showToast("请选择完整地址");
          return;
        }
        Navigator.pop(context, {
          "name": selectString,
          "sheng": "${citys1[selectIndex[0]].id}",
          "shi": "${citys2[selectIndex[1]].id}",
          "qu": "${citys3[selectIndex[2]].id}",
        });
        break;
      case "取消":
        Navigator.pop(context);
        break;
    }
  }

  @override
  void getData() {
    // TODO: implement getData
  }

  ///弹吐司
  void showToast(
    String content, {
    Toast length = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.CENTER,
    Color backColor = Colors.black87,
    Color textColor = Colors.white,
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
