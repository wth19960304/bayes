class ShouCangVideoBean {
  final int? state;
  final String? message;
  final Data? data;

  ShouCangVideoBean({this.state, this.message, this.data});

  factory ShouCangVideoBean.fromJson(Map<String, dynamic> json) {
    return ShouCangVideoBean(
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
  final List<CourseVideoList>? courseVideoList;
  final List<VideoManageList>? videoManageList;

  Data({this.courseVideoList, this.videoManageList});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      courseVideoList: json['courseVideoList'] != null
          ? (json['courseVideoList'] as List)
                .map((v) => CourseVideoList.fromJson(v))
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
      'courseVideoList': courseVideoList?.map((v) => v.toJson()).toList(),
      'videoManageList': videoManageList?.map((v) => v.toJson()).toList(),
    };
  }
}

class CourseVideoList {
  final int? id;
  final String? courseId;
  final String? name;
  final String? time;
  final String? url;
  final List<CourseLabel>? videolabel;
  final String? playNum;
  final List<CourseLabel>? courseLabel;
  final List<CourseImg>? courseImg;

  CourseVideoList({
    this.id,
    this.courseId,
    this.name,
    this.time,
    this.url,
    this.videolabel,
    this.playNum,
    this.courseLabel,
    this.courseImg,
  });

  factory CourseVideoList.fromJson(Map<String, dynamic> json) {
    return CourseVideoList(
      id: json['id'] as int?,
      courseId: json['courseId'] as String?,
      name: json['name'] as String?,
      time: json['time'] as String?,
      url: json['url'] as String?,
      videolabel: json['videolabel'] != null
          ? (json['videolabel'] as List)
                .map((v) => CourseLabel.fromJson(v))
                .toList()
          : null,
      playNum: json['playNum'] as String?,
      courseLabel: json['courseLabel'] != null
          ? (json['courseLabel'] as List)
                .map((v) => CourseLabel.fromJson(v))
                .toList()
          : null,
      courseImg: json['courseImg'] != null
          ? (json['courseImg'] as List)
                .map((v) => CourseImg.fromJson(v))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'name': name,
      'time': time,
      'url': url,
      'videolabel': videolabel?.map((v) => v.toJson()).toList(),
      'playNum': playNum,
      'courseLabel': courseLabel?.map((v) => v.toJson()).toList(),
      'courseImg': courseImg?.map((v) => v.toJson()).toList(),
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

class VideoManageList {
  final int? id;
  final String? name;
  final List<CourseLabel>? videoLabel;
  final String? titlePage;
  final String? studyNum;

  VideoManageList({
    this.id,
    this.name,
    this.videoLabel,
    this.titlePage,
    this.studyNum,
  });

  factory VideoManageList.fromJson(Map<String, dynamic> json) {
    return VideoManageList(
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
