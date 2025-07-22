import 'package:cached_network_image/cached_network_image.dart';
import 'package:erp_music/bean/StudyHomeBean.dart';
import 'package:erp_music/constant/font.dart';
import 'package:erp_music/ui/widget/image_error.dart';
import 'package:erp_music/utils/screen_util.dart';
import 'package:flutter/material.dart';
import '../../widget/image_loading.dart';
import '../KechengSearchPage.dart';

//分类布局
class TypeWidget extends StatelessWidget {
  List<SubjectManageList> ctypeData;
  BuildContext ct;

  TypeWidget({List<SubjectManageList> ctypeData, this.ct}) {
    this.ctypeData = ctypeData;
  }

  Widget _gridViewItemUI(SubjectManageList context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.of(ct).push(MaterialPageRoute(
              builder: (v) => KeChengSearchPage(
                    id: "${context.id}",
                    typeName: "${context.subjectName}",
                  )));
        },
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: ScreenUtil().L(12)),
              height: ScreenUtil().L(80),
              width: ScreenUtil().L(140),
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: "${context.img[0].url}",
                  placeholder: (context, url) => ImageLoadingPage(
                    width: 20.0,
                  ),
                  errorWidget: (context, url, error) => ImageErrorPage(
                    width: 20.0,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().L(5))),
              ),
            ),
            Container(
              height: ScreenUtil().L(20),
              margin: EdgeInsets.all(ScreenUtil().L(5)),
              child: Center(
                child: Text(
                  "${context.subjectName}",
                  style: KFontConstant.blackTextBig_bold(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: ScreenUtil().L(25)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(right: ScreenUtil().L(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _carShopItem(),
        ),
      ),
    );
  }

  List<Widget> _carShopItem() {
    List<Widget> listWidget = List();
    for (var i = 0; i < ctypeData.length; i++) {
      listWidget.add(_gridViewItemUI(ctypeData[i]));
    }
    return listWidget;
  }
}
