class MessageListModel {
  final int? state;
  final String? message;
  final Data? data;

  MessageListModel({this.state, this.message, this.data});

  factory MessageListModel.fromJson(Map<String, dynamic> json) {
    return MessageListModel(
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
  final List<Message>? content;

  Data({this.total, this.content});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      total: json['total'] as int?,
      content: json['content'] != null
          ? (json['content'] as List).map((v) => Message.fromJson(v)).toList()
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

class Message {
  final int? id;
  final int? userId;
  final int? fromUserId;
  final String? remindType;
  final String? readStatus;
  final String? content;
  final String? addTime;
  final String? createBy;
  final String? createTime;
  final String? updateBy;
  final String? updateTime;

  Message({
    this.id,
    this.userId,
    this.fromUserId,
    this.remindType,
    this.readStatus,
    this.content,
    this.addTime,
    this.createBy,
    this.createTime,
    this.updateBy,
    this.updateTime,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as int?,
      userId: json['userId'] as int?,
      fromUserId: json['fromUserId'] as int?,
      remindType: json['remindType'] as String?,
      readStatus: json['readStatus'] as String?,
      content: json['content'] as String?,
      addTime: json['addTime'] as String?,
      createBy: json['createBy'] as String?,
      createTime: json['createTime'] as String?,
      updateBy: json['updateBy'] as String?,
      updateTime: json['updateTime'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'fromUserId': fromUserId,
      'remindType': remindType,
      'readStatus': readStatus,
      'content': content,
      'addTime': addTime,
      'createBy': createBy,
      'createTime': createTime,
      'updateBy': updateBy,
      'updateTime': updateTime,
    };
  }
}
