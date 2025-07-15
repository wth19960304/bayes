import 'package:bayes/bean/TestHomeBean.dart';

class ShiTiListBean {
  final int? state;
  final String? message;
  final Data? data;

  ShiTiListBean({this.state, this.message, this.data});

  factory ShiTiListBean.fromJson(Map<String, dynamic> json) {
    return ShiTiListBean(
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
  final List<TestManageList>? content;

  Data({this.total, this.content});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      total: json['total'] as int?,
      content: json['content'] != null
          ? (json['content'] as List)
                .map((v) => TestManageList.fromJson(v))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'content': content?.map((v) => v?.toJson()).toList(),
    };
  }
}
