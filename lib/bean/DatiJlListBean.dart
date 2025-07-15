class DatiJlListBean {
  final int? state;
  final String? message;
  final DatiJlListData? data;

  DatiJlListBean({this.state, this.message, this.data});

  factory DatiJlListBean.fromJson(Map<String, dynamic> json) {
    return DatiJlListBean(
      state: json['state'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null ? DatiJlListData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'state': state, 'message': message, 'data': data?.toJson()};
  }
}

class DatiJlListData {
  final int? total;
  final List<DatiJlContent>? content;

  DatiJlListData({this.total, this.content});

  factory DatiJlListData.fromJson(Map<String, dynamic> json) {
    return DatiJlListData(
      total: json['total'] as int?,
      content: json['content'] != null
          ? (json['content'] as List)
                .map((v) => DatiJlContent.fromJson(v))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'content': content?.map((v) => v.toJson()).toList(),
    };
  }
}

class DatiJlContent {
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

  DatiJlContent({
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

  factory DatiJlContent.fromJson(Map<String, dynamic> json) {
    return DatiJlContent(
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
