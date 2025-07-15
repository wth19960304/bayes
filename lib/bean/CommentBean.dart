class CommentBean {
  final int? state;
  final String? message;
  final Data? data;

  CommentBean({this.state, this.message, this.data});

  factory CommentBean.fromJson(Map<String, dynamic> json) {
    return CommentBean(
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
  final List<CommentContent>? content;

  Data({this.total, this.content});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      total: json['total'] as int?,
      content: json['content'] != null
          ? (json['content'] as List)
                .map((v) => CommentContent.fromJson(v))
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

class CommentContent {
  final int? id;
  final String? topicId;
  final String? userId;
  final String? userName;
  final List<UserHead>? userHead;
  final String? parentId;
  final String? parentName;
  final String? content;
  final String? addTime;

  CommentContent({
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

  factory CommentContent.fromJson(Map<String, dynamic> json) {
    return CommentContent(
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
