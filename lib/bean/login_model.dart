class LoginBean {
  int state;
  String message;
  Data data;

  LoginBean({this.state, this.message, this.data});

  LoginBean.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  User user;
  String token;
  String openId;
  String nickname;
  String headImg;

  Data({this.user, this.token, this.openId, this.nickname, this.headImg});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
    openId = json['openid'];
    nickname = json['nickname'];
    headImg = json['headImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['token'] = this.token;
    data['openid'] = this.openId;
    data['nickname'] = this.nickname;
    data['headImg'] = this.headImg;
    return data;
  }
}

class User {
  int id;
  String password;
  String phoneNum;
  String nickname;
  String sex;
  String grade;
  String userType;
  String division;
  String mathScores;
  String provincialId;
  String provincialName;
  String cityId;
  String cityName;
  String areaId;
  String areaName;
  String position;
  String state;
  String addTime;
  String createBy;
  String createTime;
  String updateBy;
  String updateTime;

  User(
      {this.id,
      this.password,
      this.phoneNum,
      this.nickname,
      this.sex,
      this.grade,
      this.userType,
      this.division,
      this.mathScores,
      this.provincialId,
      this.provincialName,
      this.cityId,
      this.cityName,
      this.areaId,
      this.areaName,
      this.position,
      this.state,
      this.addTime,
      this.createBy,
      this.createTime,
      this.updateBy,
      this.updateTime});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    password = json['password'];
    phoneNum = json['phoneNum'];
    nickname = json['nickname'];
    sex = json['sex'];
    grade = json['grade'];
    userType = json['userType'];
    division = json['division'];
    mathScores = json['mathScores'];
    provincialId = json['provincialId'];
    provincialName = json['provincialName'];
    cityId = json['cityId'];
    cityName = json['cityName'];
    areaId = json['areaId'];
    areaName = json['areaName'];
    position = json['position'];
    state = json['state'];
    addTime = json['addTime'];
    createBy = json['createBy'];
    createTime = json['createTime'];
    updateBy = json['updateBy'];
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['password'] = this.password;
    data['phoneNum'] = this.phoneNum;
    data['nickname'] = this.nickname;
    data['sex'] = this.sex;
    data['grade'] = this.grade;
    data['userType'] = this.userType;
    data['division'] = this.division;
    data['mathScores'] = this.mathScores;
    data['provincialId'] = this.provincialId;
    data['provincialName'] = this.provincialName;
    data['cityId'] = this.cityId;
    data['cityName'] = this.cityName;
    data['areaId'] = this.areaId;
    data['areaName'] = this.areaName;
    data['position'] = this.position;
    data['state'] = this.state;
    data['addTime'] = this.addTime;
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['updateBy'] = this.updateBy;
    data['updateTime'] = this.updateTime;
    return data;
  }
}
