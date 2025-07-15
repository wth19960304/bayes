class ChengjiuModel {
  int? state;
  String? message;
  List<ChengjiuData>? data;

  ChengjiuModel({this.state, this.message, this.data});

  ChengjiuModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ChengjiuData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = state;
    data['message'] = message;
    data['data'] = this.data?.map((v) => v.toJson()).toList();
    return data;
  }
}

class ChengjiuData {
  int? id;
  String? name;
  String? description;
  String? isTrue;

  ChengjiuData({this.id, this.name, this.description, this.isTrue});

  factory ChengjiuData.fromJson(Map<String, dynamic> json) {
    return ChengjiuData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      isTrue: json['isTrue'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'isTrue': isTrue,
    };
  }
}
