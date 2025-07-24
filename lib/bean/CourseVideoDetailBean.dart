class CourseVideoDetailBean {
  final int? state;
  final String? message;
  final CourseVideoDetailData? data;

  CourseVideoDetailBean({this.state, this.message, this.data});

  factory CourseVideoDetailBean.fromJson(Map<String, dynamic> json) {
    return CourseVideoDetailBean(
      state: json['state'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? CourseVideoDetailData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'state': state, 'message': message, 'data': data?.toJson()};
  }
}

class CourseVideoDetailData {
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
  final String? subject;
  final String? thematic;

  CourseVideoDetailData({
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
    this.subject,
    this.thematic,
  });

  factory CourseVideoDetailData.fromJson(Map<String, dynamic> json) {
    return CourseVideoDetailData(
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
      subject: json['subject'] as String?,
      thematic: json['thematic'] as String?,
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
      'subject': subject,
      'thematic': thematic,
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
  final int? id;
  final String? courseId;
  final String? name;
  final String? time;
  final String? url;
  late final String? dislikeNum;
  late final String? likeNum;
  final String? shareNum;
  late final String? collectNum;
  final String? downloadNum;
  late final String? isLike;
  late final String? isDisLike;
  late final String? isCollect;
  final List<AboutVideolist>? aboutVideolist;

  CourseVideos({
    this.id,
    this.courseId,
    this.name,
    this.time,
    this.url,
    this.dislikeNum,
    this.likeNum,
    this.shareNum,
    this.collectNum,
    this.downloadNum,
    this.isLike,
    this.isDisLike,
    this.isCollect,
    this.aboutVideolist,
  });

  factory CourseVideos.fromJson(Map<String, dynamic> json) {
    return CourseVideos(
      id: json['id'] as int?,
      courseId: json['courseId'] as String?,
      name: json['name'] as String?,
      time: json['time'] as String?,
      url: json['url'] as String?,
      dislikeNum: json['dislikeNum'] as String?,
      likeNum: json['likeNum'] as String?,
      shareNum: json['shareNum'] as String?,
      collectNum: json['collectNum'] as String?,
      downloadNum: json['downloadNum'] as String?,
      isLike: json['isLike'] as String?,
      isDisLike: json['isDisLike'] as String?,
      isCollect: json['isCollect'] as String?,
      aboutVideolist: json['aboutVideolist'] != null
          ? (json['aboutVideolist'] as List)
                .map((v) => AboutVideolist.fromJson(v))
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
      'dislikeNum': dislikeNum,
      'likeNum': likeNum,
      'shareNum': shareNum,
      'collectNum': collectNum,
      'downloadNum': downloadNum,
      'isLike': isLike,
      'isDisLike': isDisLike,
      'isCollect': isCollect,
      'aboutVideolist': aboutVideolist?.map((v) => v.toJson()).toList(),
    };
  }
}

class AboutVideolist {
  int? id;
  int? cvId;
  int? cmId;
  String? vmId;
  String? name;
  String? time;

  AboutVideolist({
    this.id,
    this.cvId,
    this.vmId,
    this.name,
    this.time,
    this.cmId,
  });

  AboutVideolist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cvId = int.parse(json['caId']);
    cmId = json['cmId'];
    vmId = json['vmId'];
    name = json['name'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['caId'] = cvId;
    data['vmId'] = vmId;
    data['name'] = name;
    data['time'] = time;
    data['caId'] = cvId;
    return data;
  }
}
