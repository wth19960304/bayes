class CourseManageModel {
  final int? state;
  final String? message;
  final CourseData? data;

  CourseManageModel({this.state, this.message, this.data});

  factory CourseManageModel.fromJson(Map<String, dynamic> json) {
    return CourseManageModel(
      state: json['state'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null ? CourseData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'state': state, 'message': message, 'data': data?.toJson()};
  }
}

class CourseData {
  final int? id;
  final String? courseName;
  final String? lector;
  final String? lectorProfile;
  final String? chapterNum;
  final String? studyNum;
  final String? commentNum;
  final String? collectNum;
  final String? isCollect;
  final String? courseContent;
  final List<CourseImg>? courseImg;
  final List<CourseLabel>? courseLabel;
  final List<CourseVideos>? courseVideos;
  final String? addTime;

  CourseData({
    this.id,
    this.courseName,
    this.lector,
    this.lectorProfile,
    this.chapterNum,
    this.studyNum,
    this.commentNum,
    this.collectNum,
    this.isCollect,
    this.courseContent,
    this.courseImg,
    this.courseLabel,
    this.courseVideos,
    this.addTime,
  });

  factory CourseData.fromJson(Map<String, dynamic> json) {
    return CourseData(
      id: json['id'] as int?,
      courseName: json['courseName'] as String?,
      lector: json['lector'] as String?,
      lectorProfile: json['lectorProfile'] as String?,
      chapterNum: json['chapterNum'] as String?,
      studyNum: json['studyNum'] as String?,
      commentNum: json['commentNum'] as String?,
      collectNum: json['collectNum'] as String?,
      isCollect: json['isCollect'] as String?,
      courseContent: json['courseContent'] as String?,
      courseImg: json['courseImg'] != null
          ? (json['courseImg'] as List)
                .map((v) => CourseImg.fromJson(v))
                .toList()
          : null,
      courseLabel: json['courseLabel'] != null
          ? (json['courseLabel'] as List)
                .map((v) => CourseLabel.fromJson(v))
                .toList()
          : null,
      courseVideos: json['courseVideos'] != null
          ? (json['courseVideos'] as List)
                .map((v) => CourseVideos.fromJson(v))
                .toList()
          : null,
      addTime: json['addTime'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseName': courseName,
      'lector': lector,
      'lectorProfile': lectorProfile,
      'chapterNum': chapterNum,
      'studyNum': studyNum,
      'commentNum': commentNum,
      'collectNum': collectNum,
      'isCollect': isCollect,
      'courseContent': courseContent,
      'courseImg': courseImg?.map((v) => v.toJson()).toList(),
      'courseLabel': courseLabel?.map((v) => v.toJson()).toList(),
      'courseVideos': courseVideos?.map((v) => v.toJson()).toList(),
      'addTime': addTime,
    };
  }
}

class CourseImg {
  final int? uid;
  final String? name;
  final String? time;
  final String? url;
  final String? status;

  CourseImg({this.uid, this.name, this.time, this.url, this.status});

  factory CourseImg.fromJson(Map<String, dynamic> json) {
    return CourseImg(
      uid: json['uid'] as int?,
      name: json['name'] as String?,
      time: json['time'] as String?,
      url: json['url'] as String?,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'time': time,
      'url': url,
      'status': status,
    };
  }
}

class CourseLabel {
  final String? name;
  final String? type;

  CourseLabel({this.name, this.type});

  factory CourseLabel.fromJson(Map<String, dynamic> json) {
    return CourseLabel(
      name: json['name'] as String?,
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'type': type};
  }
}

class CourseVideos {
  final String? name;
  final int? id;
  final String? time;
  final String? isStudy;

  CourseVideos({this.name, this.id, this.time, this.isStudy});

  factory CourseVideos.fromJson(Map<String, dynamic> json) {
    return CourseVideos(
      name: json['name'] as String?,
      id: json['id'] as int?,
      time: json['time'] as String?,
      isStudy: json['is_study'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'id': id, 'time': time, 'is_study': isStudy};
  }
}
