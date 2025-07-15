class TestSelectBean {
  final int? state;
  final String? message;
  final TestSelectData? data;

  TestSelectBean({this.state, this.message, this.data});

  factory TestSelectBean.fromJson(Map<String, dynamic> json) {
    return TestSelectBean(
      state: json['state'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null ? TestSelectData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'state': state, 'message': message, 'data': data?.toJson()};
  }
}

class TestSelectData {
  final List<SubjectManageList>? subjectManageList;
  final List<ThematicManageList>? thematicManageList;
  final List<TestLevelManageList>? testLevelManageList;

  TestSelectData({
    this.subjectManageList,
    this.thematicManageList,
    this.testLevelManageList,
  });

  factory TestSelectData.fromJson(Map<String, dynamic> json) {
    return TestSelectData(
      subjectManageList: json['subjectManageList'] != null
          ? (json['subjectManageList'] as List)
                .map((v) => SubjectManageList.fromJson(v))
                .toList()
          : null,
      thematicManageList: json['thematicManageList'] != null
          ? (json['thematicManageList'] as List)
                .map((v) => ThematicManageList.fromJson(v))
                .toList()
          : null,
      testLevelManageList: json['testLevelManageList'] != null
          ? (json['testLevelManageList'] as List)
                .map((v) => TestLevelManageList.fromJson(v))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subjectManageList': subjectManageList?.map((v) => v.toJson()).toList(),
      'thematicManageList': thematicManageList?.map((v) => v.toJson()).toList(),
      'testLevelManageList': testLevelManageList
          ?.map((v) => v.toJson())
          .toList(),
    };
  }
}

class SubjectManageList {
  final String? id;
  final String? subjectName;

  SubjectManageList({this.id, this.subjectName});

  factory SubjectManageList.fromJson(Map<String, dynamic> json) {
    return SubjectManageList(
      id: json['id'] as String?,
      subjectName: json['subjectName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'subjectName': subjectName};
  }
}

class ThematicManageList {
  final String? thematicName;
  final String? id;
  final String? subjectName;

  ThematicManageList({this.thematicName, this.id, this.subjectName});

  factory ThematicManageList.fromJson(Map<String, dynamic> json) {
    return ThematicManageList(
      thematicName: json['thematicName'] as String?,
      id: json['id'] as String?,
      subjectName: json['subjectName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'thematicName': thematicName, 'id': id, 'subjectName': subjectName};
  }
}

class TestLevelManageList {
  final String? id;
  final String? testLevelName;

  TestLevelManageList({this.id, this.testLevelName});

  factory TestLevelManageList.fromJson(Map<String, dynamic> json) {
    return TestLevelManageList(
      id: json['id'] as String?,
      testLevelName: json['testLevelName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'testLevelName': testLevelName};
  }
}
