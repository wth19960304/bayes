class NianjiBean {
  final int? state;
  final String? message;
  final List<Data>? data;

  NianjiBean({this.state, this.message, this.data});

  factory NianjiBean.fromJson(Map<String, dynamic> json) {
    return NianjiBean(
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
  final String? gradeName;
  final String? id;

  Data({this.gradeName, this.id});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      gradeName: json['gradeName'] as String?,
      id: json['id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'gradeName': gradeName, 'id': id};
  }
}
