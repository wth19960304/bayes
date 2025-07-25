class UserInfoBean {
  int? state;
  String? message;
  UserInfoData? data;

  UserInfoBean({this.state, this.message, this.data});

  factory UserInfoBean.fromJson(Map<String, dynamic> json) {
    return UserInfoBean(
      state: json['state'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null ? UserInfoData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'state': state, 'message': message, 'data': data?.toJson()};
  }
}

class UserInfoData {
  int? id;
  String? phoneNum;
  String? password;
  String? nickname;
  List<HeadImg>? headImg;
  late String? sex;
  late String? grade;
  late String? userType;
  late String? division;
  late String? mathScores;
  late String? position;
  String? state;
  String? banReason;
  String? banStartTime;
  String? banEndTime;
  String? addTime;
  String? studyNum;
  String? testNum;
  String? cacheNum;
  late String? provincialId;
  late String? cityId;
  late String? areaId;

  UserInfoData({
    this.id,
    this.phoneNum,
    this.password,
    this.nickname,
    this.headImg,
    this.sex,
    this.grade,
    this.userType,
    this.division,
    this.mathScores,
    this.position,
    this.state,
    this.banReason,
    this.banStartTime,
    this.banEndTime,
    this.addTime,
    this.studyNum,
    this.testNum,
    this.cacheNum,
    this.provincialId,
    this.cityId,
    this.areaId,
  });

  factory UserInfoData.fromJson(Map<String, dynamic> json) {
    return UserInfoData(
      id: json['id'] as int?,
      phoneNum: json['phoneNum'] as String?,
      password: json['password'] as String?,
      nickname: json['nickname'] as String?,
      headImg: json['headImg'] != null
          ? (json['headImg'] as List).map((v) => HeadImg.fromJson(v)).toList()
          : null,
      sex: json['sex'] as String?,
      grade: json['grade'] as String?,
      userType: json['userType'] as String?,
      division: json['division'] as String?,
      mathScores: json['mathScores'] as String?,
      position: json['position'] as String?,
      state: json['state'] as String?,
      banReason: json['banReason'] as String?,
      banStartTime: json['banStartTime'] as String?,
      banEndTime: json['banEndTime'] as String?,
      addTime: json['addTime'] as String?,
      studyNum: json['studyNum'] as String?,
      testNum: json['testNum'] as String?,
      cacheNum: json['cacheNum'] as String?,
      provincialId: json['provincialId'] as String?,
      cityId: json['cityId'] as String?,
      areaId: json['areaId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNum': phoneNum,
      'password': password,
      'nickname': nickname,
      'headImg': headImg?.map((v) => v.toJson()).toList(),
      'sex': sex,
      'grade': grade,
      'userType': userType,
      'division': division,
      'mathScores': mathScores,
      'position': position,
      'state': state,
      'banReason': banReason,
      'banStartTime': banStartTime,
      'banEndTime': banEndTime,
      'addTime': addTime,
      'studyNum': studyNum,
      'testNum': testNum,
      'cacheNum': cacheNum,
      'provincialId': provincialId,
      'cityId': cityId,
      'areaId': areaId,
    };
  }
}

class HeadImg {
  String? name;
  String? url;

  HeadImg({this.name, this.url});

  factory HeadImg.fromJson(Map<String, dynamic> json) {
    return HeadImg(name: json['name'] as String?, url: json['url'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }
}
