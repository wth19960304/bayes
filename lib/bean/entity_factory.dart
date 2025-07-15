import 'package:bayes/bean/TestBean.dart';
import 'package:bayes/bean/XuexiJiluBean.dart';
import 'package:bayes/bean/XuexiTongjiModel.dart';
import 'package:bayes/bean/message_model.dart';

import 'ChengjiuModel.dart';
import 'CommentBean.dart';
import 'ComplainlistBean.dart';
import 'CourseMangeModel.dart';
import 'CourseVideoDetailBean.dart';
import 'DatiJlListBean.dart';
import 'DatiJlBean.dart';
import 'DefaultBean.dart';
import 'GetMessageModel.dart';
import 'ImagePutBean.dart';
import 'KeChengListBean.dart';
import 'NianjiBean.dart';
import 'ShiTiListBean.dart';
import 'ShouChangVideoBean.dart';
import 'StringBean.dart';
import 'StudyHomeBean.dart';
import 'TestHomeBean.dart';
import 'TestSelectBean.dart';
import 'UserInfoBean.dart';
import 'VideoDetailBean.dart';
import 'WoDeShouCangBean.dart';
import 'WodePinglunBean.dart';
import 'city_model.dart';
import 'kechengvideo_model.dart';
import 'login_model.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (T.toString() == "LoginBean") {
      return LoginBean.fromJson(json) as T;
    } else if (T.toString() == "ComplainlistBean") {
      return ComplainlistBean.fromJson(json) as T;
    } else if (T.toString() == "StringBean") {
      return StringBean.fromJson(json) as T;
    } else if (T.toString() == "StudyHomeBean") {
      return StudyHomeBean.fromJson(json) as T;
    } else if (T.toString() == "CommentBean") {
      return CommentBean.fromJson(json) as T;
    } else if (T.toString() == "VideoDetailBean") {
      return VideoDetailBean.fromJson(json) as T;
    } else if (T.toString() == "CourseManageModel") {
      return CourseManageModel.fromJson(json) as T;
    } else if (T.toString() == "CourseVideoDetailBean") {
      return CourseVideoDetailBean.fromJson(json) as T;
    } else if (T.toString() == "TestHomeBean") {
      return TestHomeBean.fromJson(json) as T;
    } else if (T.toString() == "TestSelectBean") {
      return TestSelectBean.fromJson(json) as T;
    } else if (T.toString() == "TestBean") {
      return TestBean.fromJson(json) as T;
    } else if (T.toString() == "ImagePutBean") {
      return ImagePutBean.fromJson(json) as T;
    } else if (T.toString() == "DatiJlBean") {
      return DatiJlBean.fromJson(json) as T;
    } else if (T.toString() == "DatiJlListBean") {
      return DatiJlListBean.fromJson(json) as T;
    } else if (T.toString() == "UserInfoBean") {
      return UserInfoBean.fromJson(json) as T;
    } else if (T.toString() == "NianjiBean") {
      return NianjiBean.fromJson(json) as T;
    } else if (T.toString() == "KeChengListBean") {
      return KeChengListBean.fromJson(json) as T;
    } else if (T.toString() == "ShiTiListBean") {
      return ShiTiListBean.fromJson(json) as T;
    } else if (T.toString() == "WoDePingLunBean") {
      return WoDePingLunBean.fromJson(json) as T;
    } else if (T.toString() == "WoDeShouCangBean") {
      return WoDeShouCangBean.fromJson(json) as T;
    } else if (T.toString() == "ChengjiuModel") {
      return ChengjiuModel.fromJson(json) as T;
    } else if (T.toString() == "XuexiJiluModel") {
      return XuexiJiluModel.fromJson(json) as T;
    } else if (T.toString() == "XuexiTongjiModel") {
      return XuexiTongjiModel.fromJson(json) as T;
    } else if (T.toString() == "GetMessageModel") {
      return GetMessageModel.fromJson(json) as T;
    } else if (T.toString() == "MessageListModel") {
      return MessageListModel.fromJson(json) as T;
    } else if (T.toString() == "DefaultBean") {
      return DefaultBean.fromJson(json) as T;
    } else if (T.toString() == "KeChengVideoModel") {
      return KeChengVideoModel.fromJson(json) as T;
    } else if (T.toString() == "ShouCangVideoBean") {
      return ShouCangVideoBean.fromJson(json) as T;
    } else if (T.toString() == "CityModel") {
      return CityModel.fromJson(json) as T;
    }

    return DefaultBean.fromJson(json) as T;
  }
}
