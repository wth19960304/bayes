class UserInfoBean {
  final int? state;
  final String? message;
  final UserInfoData? data;

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
  final int? id;
  final String? phoneNum;
  final String? password;
  final String? nickname;
  final List<HeadImg>? headImg;
  final String? sex;
  final String? grade;
  final String? userType;
  final String? division;
  final String? mathScores;
  final String? position;
  final String? state;
  final String? banReason;
  final String? banStartTime;
  final String? banEndTime;
  final String? addTime;
  final String? studyNum;
  final String? testNum;
  final String? cacheNum;
  final String? provincialId;
  final String? cityId;
  final String? areaId;

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
  final String? name;
  final String? url;

  HeadImg({this.name, this.url});

  factory HeadImg.fromJson(Map<String, dynamic> json) {
    return HeadImg(name: json['name'] as String?, url: json['url'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }
}
