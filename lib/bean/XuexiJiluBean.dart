class XuexiJiluModel {
  final int? state;
  final String? message;
  final List<Data>? data;

  XuexiJiluModel({this.state, this.message, this.data});

  factory XuexiJiluModel.fromJson(Map<String, dynamic> json) {
    return XuexiJiluModel(
      state: json['state'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? (json['data'] as List).map((v) => Data.fromJson(v)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'state': state,
      'message': message,
      'data': data?.map((v) => v.toJson()).toList(),
    };
  }
}

class Data {
  final Course? course;
  final Video? video;
  final String? type;

  Data({this.course, this.video, this.type});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      course: json['course'] != null ? Course.fromJson(json['course']) : null,
      video: json['video'] != null ? Video.fromJson(json['video']) : null,
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'course': course?.toJson(), 'video': video?.toJson(), 'type': type};
  }
}

class Course {
  final int? id;
  final String? courseName;
  final List<CourseImg>? courseImg;
  final String? studyNum;
  final List<CourseLabel>? courseLabel;

  Course({
    this.id,
    this.courseName,
    this.courseImg,
    this.studyNum,
    this.courseLabel,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
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

class Video {
  final int? id;
  final String? name;
  final List<CourseLabel>? videoLabel;
  final String? titlePage;
  final String? studyNum;

  Video({this.id, this.name, this.videoLabel, this.titlePage, this.studyNum});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'] as int?,
      name: json['name'] as String?,
      videoLabel: json['videoLabel'] != null
          ? (json['videoLabel'] as List)
                .map((v) => CourseLabel.fromJson(v))
                .toList()
          : null,
      titlePage: json['titlePage'] as String?,
      studyNum: json['studyNum'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'videoLabel': videoLabel?.map((v) => v.toJson()).toList(),
      'titlePage': titlePage,
      'studyNum': studyNum,
    };
  }
}
