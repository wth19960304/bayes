import 'package:bayes/bean/CourseMangeModel.dart';
import 'package:bayes/bean/ShouChangVideoBean.dart' hide CourseImg, CourseLabel;

class StudyHomeBean {
  final int? state;
  final String? message;
  final Data? data;

  StudyHomeBean({this.state, this.message, this.data});

  factory StudyHomeBean.fromJson(Map<String, dynamic> json) {
    return StudyHomeBean(
      state: json['state'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'state': state, 'message': message, 'data': data?.toJson()};
  }
}

class Data {
  final List<BannerManageList>? bannerManageList;
  final List<SubjectManageList>? subjectManageList;
  final List<CourseManageList>? courseManageList;
  final List<VideoManageList>? videoManageList;

  Data({
    this.bannerManageList,
    this.subjectManageList,
    this.courseManageList,
    this.videoManageList,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      bannerManageList: json['bannerManageList'] != null
          ? (json['bannerManageList'] as List)
                .map((v) => BannerManageList.fromJson(v))
                .toList()
          : null,
      subjectManageList: json['subjectManageList'] != null
          ? (json['subjectManageList'] as List)
                .map((v) => SubjectManageList.fromJson(v))
                .toList()
          : null,
      courseManageList: json['courseManageList'] != null
          ? (json['courseManageList'] as List)
                .map((v) => CourseManageList.fromJson(v))
                .toList()
          : null,
      videoManageList: json['videoManageList'] != null
          ? (json['videoManageList'] as List)
                .map((v) => VideoManageList.fromJson(v))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bannerManageList': bannerManageList?.map((v) => v.toJson()).toList(),
      'subjectManageList': subjectManageList?.map((v) => v.toJson()).toList(),
      'courseManageList': courseManageList?.map((v) => v.toJson()).toList(),
      'videoManageList': videoManageList?.map((v) => v.toJson()).toList(),
    };
  }
}

class BannerManageList {
  final int? id;
  final List<Img>? img;
  final String? type;
  final String? status;
  final String? state;
  final Bounce? bounce;

  BannerManageList({
    this.id,
    this.img,
    this.type,
    this.status,
    this.state,
    this.bounce,
  });

  factory BannerManageList.fromJson(Map<String, dynamic> json) {
    return BannerManageList(
      id: json['id'] as int?,
      img: json['img'] != null
          ? (json['img'] as List).map((v) => Img.fromJson(v)).toList()
          : null,
      type: json['type'] as String?,
      status: json['status'] as String?,
      state: json['state'] as String?,
      bounce: json['bounce'] != null ? Bounce.fromJson(json['bounce']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'img': img?.map((v) => v.toJson()).toList(),
      'type': type,
      'status': status,
      'state': state,
      'bounce': bounce?.toJson(),
    };
  }
}

class Bounce {
  final String? name;
  final String? id;

  Bounce({this.name, this.id});

  factory Bounce.fromJson(Map<String, dynamic> json) {
    return Bounce(name: json['name'] as String?, id: json['id'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'id': id};
  }
}

class Img {
  final String? name;
  final String? time;
  final String? url;

  Img({this.name, this.time, this.url});

  factory Img.fromJson(Map<String, dynamic> json) {
    return Img(
      name: json['name'] as String?,
      time: json['time'] as String?,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'time': time, 'url': url};
  }
}

class SubjectManageList {
  final int? id;
  final String? subjectName;
  final List<Img>? img;

  SubjectManageList({this.id, this.subjectName, this.img});

  factory SubjectManageList.fromJson(Map<String, dynamic> json) {
    return SubjectManageList(
      id: json['id'] as int?,
      subjectName: json['subjectName'] as String?,
      img: json['img'] != null
          ? (json['img'] as List).map((v) => Img.fromJson(v)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subjectName': subjectName,
      'img': img?.map((v) => v.toJson()).toList(),
    };
  }
}

class CourseManageList {
  final int? id;
  final String? courseName;
  final List<CourseImg>? courseImg;
  final String? studyNum;
  final List<CourseLabel>? courseLabel;

  CourseManageList({
    this.id,
    this.courseName,
    this.courseImg,
    this.studyNum,
    this.courseLabel,
  });

  factory CourseManageList.fromJson(Map<String, dynamic> json) {
    return CourseManageList(
      id: json['id'] as int?,
      courseName: json['courseName'] as String?,
      courseImg: json['courseImg'] != null
          ? (json['courseImg'] as List)
                .map((v) => CourseImg.fromJson(v))
                .toList()
          : null,
      studyNum: json['studyNum'] as String?,
      courseLabel: json['courseLabel'] != null
          ? (json['courseLabel'] as List)
                .map((v) => CourseLabel.fromJson(v))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseName': courseName,
      'courseImg': courseImg?.map((v) => v.toJson()).toList(),
      'studyNum': studyNum,
      'courseLabel': courseLabel?.map((v) => v.toJson()).toList(),
    };
  }
}
