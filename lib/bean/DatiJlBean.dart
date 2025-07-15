class DatiJlBean {
  final int? state;
  final String? message;
  final DatiJlData? data;

  DatiJlBean({this.state, this.message, this.data});

  factory DatiJlBean.fromJson(Map<String, dynamic> json) {
    return DatiJlBean(
      state: json['state'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null ? DatiJlData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'state': state, 'message': message, 'data': data?.toJson()};
  }
}

class DatiJlData {
  final List<SubMap>? subMap;
  final List<SubMap>? telvMap1;
  final List<SubMap>? therate;
  final TestRecord? testRecord;

  DatiJlData({this.subMap, this.telvMap1, this.therate, this.testRecord});

  factory DatiJlData.fromJson(Map<String, dynamic> json) {
    return DatiJlData(
      subMap: json['subMap'] != null
          ? (json['subMap'] as List).map((v) => SubMap.fromJson(v)).toList()
          : null,
      telvMap1: json['telvMap1'] != null
          ? (json['telvMap1'] as List).map((v) => SubMap.fromJson(v)).toList()
          : null,
      therate: json['therate'] != null
          ? (json['therate'] as List).map((v) => SubMap.fromJson(v)).toList()
          : null,
      testRecord: json['testRecord'] != null
          ? TestRecord.fromJson(json['testRecord'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subMap': subMap?.map((v) => v.toJson()).toList(),
      'telvMap1': telvMap1?.map((v) => v.toJson()).toList(),
      'therate': therate?.map((v) => v.toJson()).toList(),
      'testRecord': testRecord?.toJson(),
    };
  }
}

class SubMap {
  final String? trueNum;
  final String? totalNum;
  final String? name;

  SubMap({this.trueNum, this.totalNum, this.name});

  factory SubMap.fromJson(Map<String, dynamic> json) {
    return SubMap(
      trueNum: json['trueNum'] as String?,
      totalNum: json['totalNum'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'trueNum': trueNum, 'totalNum': totalNum, 'name': name};
  }
}

class TestRecord {
  final int? id;
  final String? userId;
  final String? subjectNum;
  final String? subject;
  final String? recordName;
  final String? recordType;
  final String? thematicNum;
  final String? thematic;
  final String? testLevelNum;
  final String? testLevel;
  final String? testNum;
  final String? correctRate;
  final String? addTime;
  final String? createBy;
  final String? createTime;
  final String? state;
  final String? updateTime;

  TestRecord({
    this.id,
    this.userId,
    this.subjectNum,
    this.subject,
    this.recordName,
    this.recordType,
    this.thematicNum,
    this.thematic,
    this.testLevelNum,
    this.testLevel,
    this.testNum,
    this.correctRate,
    this.addTime,
    this.createBy,
    this.createTime,
    this.state,
    this.updateTime,
  });

  factory TestRecord.fromJson(Map<String, dynamic> json) {
    return TestRecord(
      id: json['id'] as int?,
      userId: json['userId'] as String?,
      subjectNum: json['subjectNum'] as String?,
      subject: json['subject'] as String?,
      recordName: json['recordName'] as String?,
      recordType: json['recordType'] as String?,
      thematicNum: json['thematicNum'] as String?,
      thematic: json['thematic'] as String?,
      testLevelNum: json['testLevelNum'] as String?,
      testLevel: json['testLevel'] as String?,
      testNum: json['testNum'] as String?,
      correctRate: json['correctRate'] as String?,
      addTime: json['addTime'] as String?,
      createBy: json['createBy'] as String?,
      createTime: json['createTime'] as String?,
      state: json['state'] as String?,
      updateTime: json['updateTime'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'subjectNum': subjectNum,
      'subject': subject,
      'recordName': recordName,
      'recordType': recordType,
      'thematicNum': thematicNum,
      'thematic': thematic,
      'testLevelNum': testLevelNum,
      'testLevel': testLevel,
      'testNum': testNum,
      'correctRate': correctRate,
      'addTime': addTime,
      'createBy': createBy,
      'createTime': createTime,
      'state': state,
      'updateTime': updateTime,
    };
  }
}
