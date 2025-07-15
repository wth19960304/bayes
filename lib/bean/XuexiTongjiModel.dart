class XuexiTongjiModel {
  final int? state;
  final String? message;
  final Data? data;

  XuexiTongjiModel({this.state, this.message, this.data});

  factory XuexiTongjiModel.fromJson(Map<String, dynamic> json) {
    return XuexiTongjiModel(
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
  final String? tests;
  final List<Level>? level;
  final List<Subject>? subject;
  final String? videos;
  final String? correctRate;
  final List<Thematic>? thematic;

  Data({
    this.tests,
    this.level,
    this.subject,
    this.videos,
    this.correctRate,
    this.thematic,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      tests: json['tests'] as String?,
      level: json['level'] != null
          ? (json['level'] as List).map((v) => Level.fromJson(v)).toList()
          : null,
      subject: json['subject'] != null
          ? (json['subject'] as List).map((v) => Subject.fromJson(v)).toList()
          : null,
      videos: json['videos'] as String?,
      correctRate: json['correctRate'] as String?,
      thematic: json['thematic'] != null
          ? (json['thematic'] as List).map((v) => Thematic.fromJson(v)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tests': tests,
      'level': level?.map((v) => v.toJson()).toList(),
      'subject': subject?.map((v) => v.toJson()).toList(),
      'videos': videos,
      'correctRate': correctRate,
      'thematic': thematic?.map((v) => v.toJson()).toList(),
    };
  }
}

class Level {
  final String? num;
  final String? testLevelName;
  final String? correctRate;

  Level({this.num, this.testLevelName, this.correctRate});

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      num: json['num'] as String?,
      testLevelName: json['testLevelName'] as String?,
      correctRate: json['correctRate'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'num': num,
      'testLevelName': testLevelName,
      'correctRate': correctRate,
    };
  }
}

class Subject {
  final String? subject;
  final String? num;
  final String? correctRate;

  Subject({this.subject, this.num, this.correctRate});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subject: json['subject'] as String?,
      num: json['num'] as String?,
      correctRate: json['correctRate'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'subject': subject, 'num': num, 'correctRate': correctRate};
  }
}

class Thematic {
  final String? num;
  final String? correctRate;
  final String? thematic;

  Thematic({this.num, this.correctRate, this.thematic});

  factory Thematic.fromJson(Map<String, dynamic> json) {
    return Thematic(
      num: json['num'] as String?,
      correctRate: json['correctRate'] as String?,
      thematic: json['thematic'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'num': num, 'correctRate': correctRate, 'thematic': thematic};
  }
}
