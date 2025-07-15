// ignore: file_names
class DefaultBean {
  int? state;
  String? message;

  DefaultBean({this.state, this.message});

  DefaultBean.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = state;
    data['message'] = message;
    return data;
  }
}
