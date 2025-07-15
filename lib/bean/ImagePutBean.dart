class ImagePutBean {
  final int? state;
  final String? message;
  final List<ImagesData>? data;

  ImagePutBean({this.state, this.message, this.data});

  factory ImagePutBean.fromJson(Map<String, dynamic> json) {
    return ImagePutBean(
      state: json['state'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? (json['data'] as List).map((v) => ImagesData.fromJson(v)).toList()
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

class ImagesData {
  final String? name;
  final String? url;

  ImagesData({this.name, this.url});

  factory ImagesData.fromJson(Map<String, dynamic> json) {
    return ImagesData(
      name: json['name'] as String?,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }
}
