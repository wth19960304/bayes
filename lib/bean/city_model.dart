class CityModel {
  int? code;
  String? message;
  List<City>? data;

  CityModel({this.code, this.message, this.data});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? (json['data'] as List).map((v) => City.fromJson(v)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data?.map((v) => v.toJson()).toList(),
    };
  }
}

class City {
  int? id;
  int? pid;
  String? districtName;
  String? type;
  int? hierarchy;
  String? districtSqe;

  City({
    this.id,
    this.pid,
    this.districtName,
    this.type,
    this.hierarchy,
    this.districtSqe,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] as int?,
      pid: json['pid'] as int?,
      districtName: json['districtName'] as String?,
      type: json['type'] as String?,
      hierarchy: json['hierarchy'] as int?,
      districtSqe: json['districtSqe'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pid': pid,
      'districtName': districtName,
      'type': type,
      'hierarchy': hierarchy,
      'districtSqe': districtSqe,
    };
  }
}
