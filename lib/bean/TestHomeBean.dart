class TestHomeBean {
  final int? state;
  final String? message;
  final TestHomeData? data;

  TestHomeBean({this.state, this.message, this.data});

  factory TestHomeBean.fromJson(Map<String, dynamic> json) {
    return TestHomeBean(
      state: json['state'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null ? TestHomeData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'state': state, 'message': message, 'data': data?.toJson()};
  }
}

class TestHomeData {
  final List<TestManageList>? testManageList;

  TestHomeData({this.testManageList});

  factory TestHomeData.fromJson(Map<String, dynamic> json) {
    return TestHomeData(
      testManageList: json['testManageList'] != null
          ? (json['testManageList'] as List)
                .map((v) => TestManageList.fromJson(v))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'testManageList': testManageList?.map((v) => v.toJson()).toList()};
  }
}

class TestManageList {
  final int? id;
  final String? testTopic;
  final String? typeName;
  final String? correctRate;
  final List<TestLabel>? testLabel;

  TestManageList({
    this.id,
    this.testTopic,
    this.typeName,
    this.correctRate,
    this.testLabel,
  });

  factory TestManageList.fromJson(Map<String, dynamic> json) {
    return TestManageList(
      id: json['id'] as int?,
      testTopic: json['testTopic'] as String?,
      typeName: json['typeName'] as String?,
      correctRate: json['correctRate'] as String?,
      testLabel: json['testLabel'] != null
          ? (json['testLabel'] as List)
                .map((v) => TestLabel.fromJson(v))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'testTopic': testTopic,
      'typeName': typeName,
      'correctRate': correctRate,
      'testLabel': testLabel?.map((v) => v.toJson()).toList(),
    };
  }
}

class TestLabel {
  final String? name;
  final String? type;

  TestLabel({this.name, this.type});

  factory TestLabel.fromJson(Map<String, dynamic> json) {
    return TestLabel(
      name: json['name'] as String?,
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'type': type};
  }
}
