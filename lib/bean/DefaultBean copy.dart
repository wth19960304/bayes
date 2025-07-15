class DefaultBean {
  final int? state;
  final String? message;

  DefaultBean({this.state, this.message});

  factory DefaultBean.fromJson(Map<String, dynamic> json) {
    return DefaultBean(
      state: json['state'] as int?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'state': state, 'message': message};
  }
}
