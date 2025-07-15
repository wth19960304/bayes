//请求地址管理
class NWApi {
  ///本地域名
  // static final baseApi = "http://192.168.199.211:8030/";//卢凤玉

  // static final baseApi = "http://192.168.199.237:8030/"; //文志华

//  /域名
  static final baseApi = "http://101.132.125.164:8060/";

  ///登录
  static final loginIn = "login/in";

  ///隐藏登录-首页调用
  static final addRecordLog = "app/addRecordLog";

  ///微信登录
  static final weChatLogin = "login/weChatLogin";

  ///QQ登录
  static final qqLogin = "login/qqLogin";

  ///发送验证码
  static final sendCode = "send/sendCode";

  ///校验验证码
  static final checkCode = "user/check";

  ///提交注册
  static final userRegist = "user/regist";

  ///绑定第三方信息
  static final bindPhone = "login/bindingQQorWx";

  ///上传文件
  static final resourcesSaves = "resource/updateAli";

  ///上传文件 - 多文件
  static final uploads = "resource/updateAlis";

  ///发布吐槽
  static final complainInsert = "complain/insert";

  ///吐槽列表
  static final complainList = "app/getComplainList";

  ///首页数据
  static final getStudyHome = "app/getStudyHome";

  ///首页数据
  static final getTestHome = "app/getTestHome";

  ///评论列表
  static final getCommentList = "app/getCommentList";

  ///视频详情
  static final getVideoManage = "app/getVideoManage";

  ///点踩
  static final topicDisLike = "dislike/topicDisLike";

  ///点赞
  static final topicLike = "like/topicLike";

  ///发布评论
  static final commentInsert = "comment/insert";

  ///收藏
  static final topicCollect = "collect/topicCollect";

  ///课程详情
  static final getCourseManage = "app/getCourseManage";

  ///课程详情 - 播放视频
  static final getCourseVideoManage = "app/getCourseVideoManage";

  ///题目类型筛选
  static final getTestSelect = "app/getTestSelect";

  ///开始刷题
  static final beginTest = "app/beginTest";

  ///获取一道题
  static final getTestByTerm = "testRecord/getTestByTerm";

  ///提交答案
  static final submitTest = "testRecord/submitTest";

  ///结束刷题
  static final endTest = "testRecord/endTest";

  ///获取答题结果
  static final getTestRecord = "testRecord/getTestRecord";

  ///练习记录列表
  static final getRecordList = "testRecord/getRecordList";

  ///获取用户详情
  static final getUserInfo = "user/getUserInfoApp";

  ///完善用户信息
  static final insertUserInfo = "user/insertUserInfo";

  ///获取年级列表
  static final getNameList = "gradeManage/getNameList";

  ///获取课程列表
  static final getListCourseManage = "courseManage/getListApp";

  ///获取课程列表
  static final getListKeChengShiPinApp = "courseManage/getListKeChengShiPinApp";

  ///获取课程列表
  static final getListAppListManage = "testManage/getListApp";

  ///获取我的评论
  static final getListMessage = "message/getList";

  ///获取系统消息
  static final getListRemind = "remind/getList";

  ///获取我的收藏
  static final myCollect = "collect/myCollect";

  ///成就列表
  static final getListAchieve = "achieve/getListUserAchieve";

  ///学习记录
  static final getStudyRecord = "achieve/getStudyRecord";

  ///学习统计
  static final getListvideos = "studyRecord/getListvideos";

  ///收到的评论与赞
  static final getListMis = "message/getListMis";

  ///收到的评论与赞
  static final getWeekList = "studyRecord/getWeekList";

  static final getTestManage = "testManage/getTestManageAPP";

  ///获取省市区
  static final getAreaListByParentId = "user/getAreaListByParentId";

  ///获取省市区
  static final addShareRecordLog = "app/addShareRecordLog";
}
