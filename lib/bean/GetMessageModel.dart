class GetMessageModel {
  final int? state;
  final String? message;
  final Data? data;

  GetMessageModel({this.state, this.message, this.data});

  factory GetMessageModel.fromJson(Map<String, dynamic> json) {
    return GetMessageModel(
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
  final String? state;
  final String? sender;
  final String? sendTime;
  final String? textInfo;
  final String? parentInfo;
  final String? type;
  final String? createTime;
  final String? createBy;
  final String? updateTime;
  final String? updateBy;
  final String? userId;
  final String? sendId;

  Content({
    this.id,
    this.state,
    this.sender,
    this.sendTime,
    this.textInfo,
    this.parentInfo,
    this.type,
    this.createTime,
    this.createBy,
    this.updateTime,
    this.updateBy,
    this.userId,
    this.sendId,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id: json['id'] as int?,
      state: json['state'] as String?,
      sender: json['sender'] as String?,
      sendTime: json['sendTime'] as String?,
      textInfo: json['textInfo'] as String?,
      parentInfo: json['parentInfo'] as String?,
      type: json['type'] as String?,
      createTime: json['createTime'] as String?,
      createBy: json['createBy'] as String?,
      updateTime: json['updateTime'] as String?,
      updateBy: json['updateBy'] as String?,
      userId: json['userId'] as String?,
      sendId: json['sendId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'state': state,
      'sender': sender,
      'sendTime': sendTime,
      'textInfo': textInfo,
      'parentInfo': parentInfo,
      'type': type,
      'createTime': createTime,
      'createBy': createBy,
      'updateTime': updateTime,
      'updateBy': updateBy,
      'userId': userId,
      'sendId': sendId,
    };
  }
}
