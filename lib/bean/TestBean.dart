import 'package:bayes/bean/TestHomeBean.dart';

class TestBean {
  final int? state;
  final String? message;
  final TestData? data;

  TestBean({this.state, this.message, this.data});

  factory TestBean.fromJson(Map<String, dynamic> json) {
    return TestBean(
      state: json['state'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null ? TestData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'state': state, 'message': message, 'data': data?.toJson()};
  }
}

class TestData {
  final int? id;
  final String? typeName;
  final String? testTopic;
  final List<OptionImg>? testImg;
  final List<TestLabel>? testLabel;
  final String? selectType;
  final String? isTrue;
  final String? explainVideo;
  final String? explainVideoName;
  final String? grade;
  final String? subject;
  final String? thematic;
  final String? testLevel;
  final String? status;
  final List<AboutVideos>? aboutVideos;
  final List<TestOptionsList>? testOptionsList;
  final List<TestAnswersList>? testAnswersList;
  final String? dislikeNum;
  final String? likeNum;
  final String? shareNum;
  final String? collectNum;
  final String? commentNum;
  final String? correctRate;
  final String? answerNum;
  final String? isLike;
  final String? isDisLike;
  final String? isCollect;

  TestData({
    this.id,
    this.typeName,
    this.testTopic,
    this.testImg,
    this.testLabel,
    this.selectType,
    this.isTrue,
    this.explainVideo,
    this.explainVideoName,
    this.grade,
    this.subject,
    this.thematic,
    this.testLevel,
    this.status,
    this.aboutVideos,
    this.testOptionsList,
    this.testAnswersList,
    this.dislikeNum,
    this.likeNum,
    this.shareNum,
    this.collectNum,
    this.commentNum,
    this.correctRate,
    this.answerNum,
    this.isLike,
    this.isDisLike,
    this.isCollect,
  });

  factory TestData.fromJson(Map<String, dynamic> json) {
    return TestData(
      id: json['id'] as int?,
      typeName: json['typeName'] as String?,
      testTopic: json['testTopic'] as String?,
      testImg: json['testImg'] != null
          ? (json['testImg'] as List).map((v) => OptionImg.fromJson(v)).toList()
          : null,
      testLabel: json['testLabel'] != null
          ? (json['testLabel'] as List)
                .map((v) => TestLabel.fromJson(v))
                .toList()
          : null,
      selectType: json['selectType'] as String?,
      isTrue: json['isTrue'] as String?,
      explainVideo: json['explainVideo'] as String?,
      explainVideoName: json['explainVideoName'] as String?,
      grade: json['grade'] as String?,
      subject: json['subject'] as String?,
      thematic: json['thematic'] as String?,
      testLevel: json['testLevel'] as String?,
      status: json['status'] as String?,
      aboutVideos: json['aboutVideos'] != null
          ? (json['aboutVideos'] as List)
                .map((v) => AboutVideos.fromJson(v))
                .toList()
          : null,
      testOptionsList: json['testOptionsList'] != null
          ? (json['testOptionsList'] as List)
                .map((v) => TestOptionsList.fromJson(v))
                .toList()
          : null,
      testAnswersList: json['testAnswersList'] != null
          ? (json['testAnswersList'] as List)
                .map((v) => TestAnswersList.fromJson(v))
                .toList()
          : null,
      dislikeNum: json['dislikeNum'] as String?,
      likeNum: json['likeNum'] as String?,
      shareNum: json['shareNum'] as String?,
      collectNum: json['collectNum'] as String?,
      commentNum: json['commentNum'] as String?,
      correctRate: json['correctRate'] as String?,
      answerNum: json['answerNum'] as String?,
      isLike: json['isLike'] as String?,
      isDisLike: json['isDisLike'] as String?,
      isCollect: json['isCollect'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'typeName': typeName,
      'testTopic': testTopic,
      'testImg': testImg?.map((v) => v.toJson()).toList(),
      'testLabel': testLabel?.map((v) => v.toJson()).toList(),
      'selectType': selectType,
      'isTrue': isTrue,
      'explainVideo': explainVideo,
      'explainVideoName': explainVideoName,
      'grade': grade,
      'subject': subject,
      'thematic': thematic,
      'testLevel': testLevel,
      'status': status,
      'aboutVideos': aboutVideos?.map((v) => v.toJson()).toList(),
      'testOptionsList': testOptionsList?.map((v) => v.toJson()).toList(),
      'testAnswersList': testAnswersList?.map((v) => v.toJson()).toList(),
      'dislikeNum': dislikeNum,
      'likeNum': likeNum,
      'shareNum': shareNum,
      'collectNum': collectNum,
      'commentNum': commentNum,
      'correctRate': correctRate,
      'answerNum': answerNum,
      'isLike': isLike,
      'isDisLike': isDisLike,
      'isCollect': isCollect,
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

class TestOptionsList {
  final int? id;
  final String? optionName;
  final List<OptionImg>? optionImg;
  final String? optionTrue;

  TestOptionsList({this.id, this.optionName, this.optionImg, this.optionTrue});

  factory TestOptionsList.fromJson(Map<String, dynamic> json) {
    return TestOptionsList(
      id: json['id'] as int?,
      optionName: json['optionName'] as String?,
      optionImg: json['optionImg'] != null
          ? (json['optionImg'] as List)
                .map((v) => OptionImg.fromJson(v))
                .toList()
          : null,
      optionTrue: json['optionTrue'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'optionName': optionName,
      'optionImg': optionImg?.map((v) => v.toJson()).toList(),
      'optionTrue': optionTrue,
    };
  }
}

class AboutVideos {
  final int? id;
  final int? cvId;
  final int? cmId;
  final String? vmId;
  final String? name;
  final String? time;

  AboutVideos({this.id, this.cvId, this.cmId, this.vmId, this.name, this.time});

  factory AboutVideos.fromJson(Map<String, dynamic> json) {
    return AboutVideos(
      id: json['id'] as int?,
      cvId: json['caId'] != null
          ? int.tryParse(json['caId'].toString())
          : int.tryParse(json['cvId'].toString()),
      cmId: json['cmId'] as int?,
      vmId: json['vmId'] as String?,
      name: json['name'] as String?,
      time: json['time'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'caId': cvId,
      'vmId': vmId,
      'name': name,
      'time': time,
      'cmId': cmId,
    };
  }
}

class OptionImg {
  final String? name;
  final String? url;

  OptionImg({this.name, this.url});

  factory OptionImg.fromJson(Map<String, dynamic> json) {
    return OptionImg(
      name: json['name'] as String?,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }
}

class TestAnswersList {
  final int? id;
  final String? testManageId;
  final String? answer;

  TestAnswersList({this.id, this.testManageId, this.answer});

  factory TestAnswersList.fromJson(Map<String, dynamic> json) {
    return TestAnswersList(
      id: json['id'] as int?,
      testManageId: json['testManageId'] as String?,
      answer: json['answer'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'testManageId': testManageId, 'answer': answer};
  }
}
