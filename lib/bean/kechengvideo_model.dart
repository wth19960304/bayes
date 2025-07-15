class KeChengVideoModel {
  final int? state;
  final String? message;
  final Data? data;

  KeChengVideoModel({this.state, this.message, this.data});

  factory KeChengVideoModel.fromJson(Map<String, dynamic> json) {
    return KeChengVideoModel(
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
  final int? total;
  final List<KeChengVideo>? content;

  Data({this.total, this.content});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      total: json['total'] as int?,
      content: json['content'] != null
          ? (json['content'] as List)
                .map((v) => KeChengVideo.fromJson(v))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'content': content?.map((v) => v.toJson()).toList(),
    };
  }
}

class KeChengVideo {
  final int? id;
  final String? courseId;
  final String? name;
  final String? time;
  final String? url;
  final List<Videolabel>? videolabel;
  final String? playNum;
  final String? courseName;
  final List<CourseLabel>? courseLabel;
  final List<CourseImg>? courseImg;

  KeChengVideo({
    this.id,
    this.courseId,
    this.name,
    this.time,
    this.url,
    this.videolabel,
    this.playNum,
    this.courseName,
    this.courseLabel,
    this.courseImg,
  });

  factory KeChengVideo.fromJson(Map<String, dynamic> json) {
    return KeChengVideo(
      id: json['id'] as int?,
      courseId: json['courseId'] as String?,
      name: json['name'] as String?,
      time: json['time'] as String?,
      url: json['url'] as String?,
      videolabel: json['videolabel'] != null
          ? (json['videolabel'] as List)
                .map((v) => Videolabel.fromJson(v))
                .toList()
          : null,
      playNum: json['playNum'] as String?,
      courseName: json['courseName'] as String?,
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
      'courseName': courseName,
      'courseLabel': courseLabel?.map((v) => v.toJson()).toList(),
      'courseImg': courseImg?.map((v) => v.toJson()).toList(),
    };
  }
}

class Videolabel {
  final int? id;
  final String? type;
  final String? name;
  final String? courseVideoId;

  Videolabel({this.id, this.type, this.name, this.courseVideoId});

  factory Videolabel.fromJson(Map<String, dynamic> json) {
    return Videolabel(
      id: json['id'] as int?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      courseVideoId: json['courseVideoId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'courseVideoId': courseVideoId,
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
