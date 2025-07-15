import 'package:bayes/bean/CourseMangeModel.dart';
import 'package:bayes/bean/ShouChangVideoBean.dart';
import 'package:bayes/bean/XuexiJiluBean.dart';
import 'package:bayes/bean/city_model.dart';
import 'package:bayes/bean/kechengvideo_model.dart';
import 'package:bayes/bean/login_model.dart';
import 'package:bayes/bean/message_model.dart';
import 'package:bayes/network/NWApi.dart';
import 'package:bayes/network/api.dart';
import 'package:rxdart/rxdart.dart';

import 'intercept/base_intercept.dart';

import 'package:bayes/bean/DefaultBean.dart';
import 'package:bayes/bean/StringBean.dart';
import 'package:bayes/bean/ImagePutBean.dart';
import 'package:bayes/bean/ComplainlistBean.dart';
import 'package:bayes/bean/StudyHomeBean.dart';
import 'package:bayes/bean/CommentBean.dart';
import 'package:bayes/bean/VideoDetailBean.dart';
import 'package:bayes/bean/CourseVideoDetailBean.dart';
import 'package:bayes/bean/TestHomeBean.dart';
import 'package:bayes/bean/TestSelectBean.dart';
import 'package:bayes/bean/TestBean.dart';
import 'package:bayes/bean/DatiJlBean.dart';
import 'package:bayes/bean/DatiJlListBean.dart';
import 'package:bayes/bean/UserInfoBean.dart';
import 'package:bayes/bean/NianjiBean.dart';
import 'package:bayes/bean/KeChengListBean.dart';
import 'package:bayes/bean/ShiTiListBean.dart';
import 'package:bayes/bean/WoDePingLunBean.dart';
import 'package:bayes/bean/WoDeShouCangBean.dart';
import 'package:bayes/bean/ChengjiuModel.dart';
import 'package:bayes/bean/XuexiTongjiModel.dart';
import 'package:bayes/bean/GetMessageModel.dart';

///网络请求接口
///EntityFactory需要在该文件添加类名判断

class RequestMap {
  ///登录
  static PublishSubject<LoginBean> loginIn<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<LoginBean>(
      NWApi.loginIn,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///添加登录日志
  static PublishSubject<DefaultBean> addRecordLog<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<DefaultBean>(
      NWApi.addRecordLog,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///登录
  static PublishSubject<LoginBean> weChatLogin<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<LoginBean>(
      NWApi.weChatLogin,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///QQ登录
  static PublishSubject<LoginBean> qqLogin<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<LoginBean>(
      NWApi.qqLogin,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///获取验证码
  static PublishSubject<StringBean> sendCode<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<StringBean>(
      NWApi.sendCode,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///校验验证码
  static PublishSubject<StringBean> checkCode<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<StringBean>(
      NWApi.checkCode,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///校验验证码
  static PublishSubject<StringBean> bindPhone<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<StringBean>(
      NWApi.bindPhone,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///提交注册
  static PublishSubject<DefaultBean> userRegist<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<DefaultBean>(
      NWApi.userRegist,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///上传文件
  static PublishSubject<ImagePutBean> resourcesSaves<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<ImagePutBean>(
      NWApi.resourcesSaves,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///上传文件
  static PublishSubject<ImagePutBean> uploads<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<ImagePutBean>(
      NWApi.uploads,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///新增吐槽
  static PublishSubject<StringBean> complainInsert<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<StringBean>(
      NWApi.complainInsert,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///吐槽列表
  static PublishSubject<ComplainlistBean> complainList<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<ComplainlistBean>(
      NWApi.complainList,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///学习首页
  // ignore: non_constant_identifier_names
  static PublishSubject<StudyHomeBean> StudyHome<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<StudyHomeBean>(
      NWApi.getStudyHome,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///获取评论列表
  static PublishSubject<CommentBean> getCommentList<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<CommentBean>(
      NWApi.getCommentList,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///获取视频详情
  static PublishSubject<VideoDetailBean> getVideoManage<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<VideoDetailBean>(
      NWApi.getVideoManage,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///点踩
  static PublishSubject<StringBean> topicDisLike<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<StringBean>(
      NWApi.topicDisLike,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///点赞
  static PublishSubject<StringBean> topicLike<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<StringBean>(
      NWApi.topicLike,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///发布评论
  static PublishSubject<StringBean> commentInsert<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<StringBean>(
      NWApi.commentInsert,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///收藏
  static PublishSubject<StringBean> topicCollect<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<StringBean>(
      NWApi.topicCollect,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///课程详情
  static PublishSubject<CourseManageModel> getCourseManage<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<CourseManageModel>(
      NWApi.getCourseManage,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///课程视频详情
  static PublishSubject<CourseVideoDetailBean>
  getCourseVideoManage<BaseResponse>(BaseIntercept baseIntercept, formData) {
    return HttpManager().post<CourseVideoDetailBean>(
      NWApi.getCourseVideoManage,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///试题列表
  static PublishSubject<TestHomeBean> getTestHome<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<TestHomeBean>(
      NWApi.getTestHome,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///试题列表
  static PublishSubject<TestSelectBean> getTestSelect<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<TestSelectBean>(
      NWApi.getTestSelect,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///试题列表
  static PublishSubject<StringBean> beginTest<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<StringBean>(
      NWApi.beginTest,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///获取一道试题
  static PublishSubject<TestBean> getTestByTerm<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<TestBean>(
      NWApi.getTestByTerm,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///获取一道试题
  static PublishSubject<TestBean> getTestManage<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<TestBean>(
      NWApi.getTestManage,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///提交答案
  static PublishSubject<StringBean> submitTest<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<StringBean>(
      NWApi.submitTest,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///提交答案
  static PublishSubject<StringBean> endTest<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<StringBean>(
      NWApi.endTest,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///获取答题结果
  static PublishSubject<DatiJlBean> getTestRecord<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<DatiJlBean>(
      NWApi.getTestRecord,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///获取答题记录
  static PublishSubject<DatiJlListBean> getRecordList<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<DatiJlListBean>(
      NWApi.getRecordList,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///获取用户信息
  static PublishSubject<UserInfoBean> getUserInfo<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<UserInfoBean>(
      NWApi.getUserInfo,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///修改用户信息
  static PublishSubject<StringBean> insertUserInfo<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<StringBean>(
      NWApi.insertUserInfo,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///修改用户信息
  static PublishSubject<NianjiBean> getNameList<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<NianjiBean>(
      NWApi.getNameList,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///获取课程列表
  static PublishSubject<KeChengListBean> getListCourseManage<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<KeChengListBean>(
      NWApi.getListCourseManage,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///获取课程列表
  static PublishSubject<KeChengVideoModel>
  getListKeChengShiPinApp<BaseResponse>(BaseIntercept baseIntercept, formData) {
    return HttpManager().post<KeChengVideoModel>(
      NWApi.getListKeChengShiPinApp,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///获取试题列表
  static PublishSubject<ShiTiListBean> getListAppListManage<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<ShiTiListBean>(
      NWApi.getListAppListManage,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///获取我的评论列表
  static PublishSubject<WoDePingLunBean> getListMessage<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<WoDePingLunBean>(
      NWApi.getListMessage,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///获取我的消息列表
  static PublishSubject<MessageListModel> getListRemind<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<MessageListModel>(
      NWApi.getListRemind,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///获取我的收藏列表
  static PublishSubject<WoDeShouCangBean> myCollect<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<WoDeShouCangBean>(
      NWApi.myCollect,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///获取我的收藏列表
  static PublishSubject<ShouCangVideoBean> myCollectVideo<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<ShouCangVideoBean>(
      NWApi.myCollect,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  ///获取我的成就列表
  static PublishSubject<ChengjiuModel> getListAchieve<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<ChengjiuModel>(
      NWApi.getListAchieve,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  static PublishSubject<XuexiJiluModel> getStudyRecord<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<XuexiJiluModel>(
      NWApi.getStudyRecord,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  static PublishSubject<XuexiTongjiModel> getListvideos<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<XuexiTongjiModel>(
      NWApi.getListvideos,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  static PublishSubject<XuexiTongjiModel> getWeekList<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<XuexiTongjiModel>(
      NWApi.getWeekList,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  static PublishSubject<GetMessageModel> getListMis<BaseResponse>(
    BaseIntercept baseIntercept,
    formData,
  ) {
    return HttpManager().post<GetMessageModel>(
      NWApi.getListMis,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  //获取省市区
  static PublishSubject<CityModel> getAreaListByParentId<BaseResponse>(
    BaseIntercept baseIntercept, {
    formData,
  }) {
    return HttpManager().post<CityModel>(
      NWApi.getAreaListByParentId,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }

  //记录分享次数
  static PublishSubject<DefaultBean> addShareRecordLog<BaseResponse>(
    BaseIntercept? baseIntercept, {
    formData,
  }) {
    return HttpManager().post<DefaultBean>(
      NWApi.addShareRecordLog,
      queryParameters: formData,
      baseIntercept: baseIntercept,
    );
  }
}
