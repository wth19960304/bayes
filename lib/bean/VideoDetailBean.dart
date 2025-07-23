class VideoDetailBean {
  final int? state;
  final String? message;
  final VideoData? data;

  VideoDetailBean({this.state, this.message, this.data});

  factory VideoDetailBean.fromJson(Map<String, dynamic> json) {
    return VideoDetailBean(
      state: json['state'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null ? VideoData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'state': state, 'message': message, 'data': data?.toJson()};
  }
}

class VideoData {
  final int? id;
  final String? name;
  final String? url;
  final String? time;
  final String? studyNum;
  late final String? dislikeNum;
  late final String? likeNum;
  final String? shareNum;
  late final String? collectNum;
  final String? playNum;
  late final String? isLike;
  late final String? isDisLike;
  late final String? isCollect;
  final String? addTime;
  final String? downloadNum;

  VideoData({
    this.id,
    this.name,
    this.url,
    this.time,
    this.studyNum,
    this.dislikeNum,
    this.likeNum,
    this.shareNum,
    this.collectNum,
    this.playNum,
    this.isLike,
    this.isDisLike,
    this.isCollect,
    this.addTime,
    this.downloadNum,
  });

  factory VideoData.fromJson(Map<String, dynamic> json) {
    return VideoData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      time: json['time'] as String?,
      studyNum: json['studyNum'] as String?,
      dislikeNum: json['dislikeNum'] as String?,
      likeNum: json['likeNum'] as String?,
      shareNum: json['shareNum'] as String?,
      collectNum: json['collectNum'] as String?,
      playNum: json['playNum'] as String?,
      isLike: json['isLike'] as String?,
      isDisLike: json['isDisLike'] as String?,
      isCollect: json['isCollect'] as String?,
      addTime: json['addTime'] as String?,
      downloadNum: json['downloadNum'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'time': time,
      'studyNum': studyNum,
      'dislikeNum': dislikeNum,
      'likeNum': likeNum,
      'shareNum': shareNum,
      'collectNum': collectNum,
      'playNum': playNum,
      'isLike': isLike,
      'isDisLike': isDisLike,
      'isCollect': isCollect,
      'addTime': addTime,
      'downloadNum': downloadNum,
    };
  }
}
