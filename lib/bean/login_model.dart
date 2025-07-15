class LoginBean {
  int? state;
  String? message;
  Data? data; // 将data标记为可空

  LoginBean({this.state, this.message, this.data});

  LoginBean.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = state;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;
  String? token;
  String? openId;
  String? nickname;
  String? headImg;

  Data({this.user, this.token, this.openId, this.nickname, this.headImg});

  Data.fromJson(Map<String, dynamic> json) {
    user = (json['user'] != null ? User.fromJson(json['user']) : null)!;
    token = json['token'];
    openId = json['openid'];
    nickname = json['nickname'];
    headImg = json['headImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user?.toJson();
    data['token'] = token;
    data['openid'] = openId;
    data['nickname'] = nickname;
    data['headImg'] = headImg;
    return data;
  }
}

class User {
  int? id;
  String? password;
  String? phoneNum;
  String? nickname;
  String? sex;
  String? grade;
  String? userType;
  String? division;
  String? mathScores;
  String? provincialId;
  String? provincialName;
  String? cityId;
  String? cityName;
  String? areaId;
  String? areaName;
  String? position;
  String? state;
  String? addTime;
  String? createBy;
  String? createTime;
  String? updateBy;
  String? updateTime;

  User({
    this.id,
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
    this.updateTime,
  });

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['password'] = password;
    data['phoneNum'] = phoneNum;
    data['nickname'] = nickname;
    data['sex'] = sex;
    data['grade'] = grade;
    data['userType'] = userType;
    data['division'] = division;
    data['mathScores'] = mathScores;
    data['provincialId'] = provincialId;
    data['provincialName'] = provincialName;
    data['cityId'] = cityId;
    data['cityName'] = cityName;
    data['areaId'] = areaId;
    data['areaName'] = areaName;
    data['position'] = position;
    data['state'] = state;
    data['addTime'] = addTime;
    data['createBy'] = createBy;
    data['createTime'] = createTime;
    data['updateBy'] = updateBy;
    data['updateTime'] = updateTime;
    return data;
  }
}
