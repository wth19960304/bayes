class WoDeShouCangBean {
  final int? state;
  final String? message;
  final List<Data>? data;

  WoDeShouCangBean({this.state, this.message, this.data});

  factory WoDeShouCangBean.fromJson(Map<String, dynamic> json) {
    return WoDeShouCangBean(
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
  final int? id;
  final String? typeName;
  final String? testTopic;
  final String? testImg;
  final List<TestLabel>? testLabel;
  final String? name;
  final List<TestLabel>? videoLabel;
  final String? titlePage;
  final String? courseName;
  final List<CourseImg>? courseImg;
  final String? studyNum;
  final List<TestLabel>? courseLabel;

  Data({
    this.id,
    this.typeName,
    this.testTopic,
    this.testImg,
    this.testLabel,
    this.name,
    this.videoLabel,
    this.titlePage,
    this.courseName,
    this.courseImg,
    this.studyNum,
    this.courseLabel,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] as int?,
      typeName: json['typeName'] as String?,
      testTopic: json['testTopic'] as String?,
      testImg: json['testImg'] as String?,
      testLabel: json['testLabel'] != null
          ? (json['testLabel'] as List)
                .map((v) => TestLabel.fromJson(v))
                .toList()
          : null,
      name: json['name'] as String?,
      videoLabel: json['videoLabel'] != null
          ? (json['videoLabel'] as List)
                .map((v) => TestLabel.fromJson(v))
                .toList()
          : null,
      titlePage: json['titlePage'] as String?,
      courseName: json['courseName'] as String?,
      courseImg: json['courseImg'] != null
          ? (json['courseImg'] as List)
                .map((v) => CourseImg.fromJson(v))
                .toList()
          : null,
      studyNum: json['studyNum'] as String?,
      courseLabel: json['courseLabel'] != null
          ? (json['courseLabel'] as List)
                .map((v) => TestLabel.fromJson(v))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'typeName': typeName,
      'testTopic': testTopic,
      'testImg': testImg,
      'testLabel': testLabel?.map((v) => v.toJson()).toList(),
      'name': name,
      'videoLabel': videoLabel?.map((v) => v.toJson()).toList(),
      'titlePage': titlePage,
      'courseName': courseName,
      'courseImg': courseImg?.map((v) => v.toJson()).toList(),
      'studyNum': studyNum,
      'courseLabel': courseLabel?.map((v) => v.toJson()).toList(),
    };
  }
}

class TestLabel {
  final String? name;
  final String? type;

  TestLabel({this.name, this.type});

  factory TestLabel.fromJson(Map<String, dynamic> json) {
    return TestLabel(
      name: json['name'] as String?,
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'type': type};
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
