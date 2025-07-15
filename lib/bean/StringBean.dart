class StringBean {
  final int? state;
  final String? message;
  final String? data;

  StringBean({this.state, this.message, this.data});

  factory StringBean.fromJson(Map<String, dynamic> json) {
    return StringBean(
      state: json['state'] as int?,
      message: json['message'] as String?,
      data: json['data'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'state': state, 'message': message, 'data': data};
  }
}
