class ComplainlistBean {
  final int? state;
  final String? message;
  final Data? data;

  ComplainlistBean({this.state, this.message, this.data});

  factory ComplainlistBean.fromJson(Map<String, dynamic> json) {
    return ComplainlistBean(
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
  final List<Content>? content;

  Data({this.total, this.content});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      total: json['total'] as int?,
      content: json['content'] != null
          ? (json['content'] as List).map((v) => Content.fromJson(v)).toList()
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

class Content {
  final int? id;
  final String? userId;
  final String? userName;
  final List<UserHead>? userHead;
  final String? content;
  final String? likeNum;
  final String? dislikeNum;
  final String? commentNum;
  final String? isLike;
  final String? isDislike;
  final List<ComplainImgList>? complainImgList;
  final List<CommentList>? commentList;
  final String? addTime;
  final String? other;

  Content({
    this.id,
    this.userId,
    this.userName,
    this.userHead,
    this.content,
    this.likeNum,
    this.dislikeNum,
    this.commentNum,
    this.isLike,
    this.isDislike,
    this.complainImgList,
    this.commentList,
    this.addTime,
    this.other,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id: json['id'] as int?,
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      userHead: json['userHead'] != null
          ? (json['userHead'] as List).map((v) => UserHead.fromJson(v)).toList()
          : null,
      content: json['content'] as String?,
      likeNum: json['likeNum'] as String?,
      dislikeNum: json['dislikeNum'] as String?,
      commentNum: json['commentNum'] as String?,
      isLike: json['isLike'] as String?,
      isDislike: json['isDislike'] as String?,
      complainImgList: json['complainImgList'] != null
          ? (json['complainImgList'] as List)
                .map((v) => ComplainImgList.fromJson(v))
                .toList()
          : null,
      commentList: json['commentList'] != null
          ? (json['commentList'] as List)
                .map((v) => CommentList.fromJson(v))
                .toList()
          : null,
      addTime: json['addTime'] as String?,
      other: json['other'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userHead': userHead?.map((v) => v.toJson()).toList(),
      'content': content,
      'likeNum': likeNum,
      'dislikeNum': dislikeNum,
      'commentNum': commentNum,
      'isLike': isLike,
      'isDislike': isDislike,
      'complainImgList': complainImgList?.map((v) => v.toJson()).toList(),
      'commentList': commentList?.map((v) => v.toJson()).toList(),
      'addTime': addTime,
      'other': other,
    };
  }
}

class UserHead {
  final String? name;
  final String? url;

  UserHead({this.name, this.url});

  factory UserHead.fromJson(Map<String, dynamic> json) {
    return UserHead(name: json['name'] as String?, url: json['url'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }
}

class ComplainImgList {
  final int? uid;
  final String? name;
  final String? url;
  final String? status;

  ComplainImgList({this.uid, this.name, this.url, this.status});

  factory ComplainImgList.fromJson(Map<String, dynamic> json) {
    return ComplainImgList(
      uid: json['uid'] as int?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'name': name, 'url': url, 'status': status};
  }
}

class CommentList {
  final int? id;
  final String? topicId;
  final String? userId;
  final String? userName;
  final List<UserHead>? userHead;
  final String? parentId;
  final String? parentName;
  final String? content;
  final String? addTime;

  CommentList({
    this.id,
    this.topicId,
    this.userId,
    this.userName,
    this.userHead,
    this.parentId,
    this.parentName,
    this.content,
    this.addTime,
  });

  factory CommentList.fromJson(Map<String, dynamic> json) {
    return CommentList(
      id: json['id'] as int?,
      topicId: json['topicId'] as String?,
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      userHead: json['userHead'] != null
          ? (json['userHead'] as List).map((v) => UserHead.fromJson(v)).toList()
          : null,
      parentId: json['parentId'] as String?,
      parentName: json['parentName'] as String?,
      content: json['content'] as String?,
      addTime: json['addTime'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'topicId': topicId,
      'userId': userId,
      'userName': userName,
      'userHead': userHead?.map((v) => v.toJson()).toList(),
      'parentId': parentId,
      'parentName': parentName,
      'content': content,
      'addTime': addTime,
    };
  }
}
