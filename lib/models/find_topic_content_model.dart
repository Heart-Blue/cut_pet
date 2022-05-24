class FindTopicContentItemModel {
  late int questionId;
  late int tribeId;
  late String title;
  late int userId;
  late int questionReadNum;
  late int answerNum;
  late int agreeNum;
  late int commentNum;
  late String nickname;
  late String headImg;
  late String tribeName;
  late String firstAnswer;
  late String firstFile;
  late String fileType;
  late String textType;
  late int answerUserId;
  late int answerId;
  late String agreeStatus;

  FindTopicContentItemModel(
      {this.questionId = 0,
      this.tribeId = 0,
      this.title = '',
      this.userId = 0,
      this.questionReadNum = 0,
      this.answerNum = 0,
      this.agreeNum = 0,
      this.commentNum = 0,
      this.nickname = '',
      this.headImg = '',
      this.tribeName = '',
      this.firstAnswer = '',
      this.firstFile = '',
      this.fileType = '',
      this.textType = '',
      this.answerUserId = 0,
      this.answerId = 0,
      this.agreeStatus = ''});

  FindTopicContentItemModel.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'] ?? 0;
    tribeId = json['tribeId'] ?? 0;
    title = json['title'] ?? '';
    userId = json['userId'] ?? 0;
    questionReadNum = json['questionReadNum'] ?? 0;
    answerNum = json['answerNum'] ?? 0;
    agreeNum = json['agreeNum'] ?? 0;
    commentNum = json['commentNum'] ?? 0;
    nickname = json['nickname'] ?? '';
    headImg = json['headImg'] ?? '';
    tribeName = json['tribeName'] ?? '';
    firstAnswer = json['firstAnswer'] ?? '';
    firstFile = json['firstFile'] ?? '';
    fileType = json['fileType'] ?? '';
    textType = json['textType'] ?? '';
    answerUserId = json['answerUserId'] ?? 0;
    answerId = json['answerId'] ?? 0;
    agreeStatus = json['agreeStatus'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['questionId'] = questionId;
    data['tribeId'] = tribeId;
    data['title'] = title;
    data['userId'] = userId;
    data['questionReadNum'] = questionReadNum;
    data['answerNum'] = answerNum;
    data['agreeNum'] = agreeNum;
    data['commentNum'] = commentNum;
    data['nickname'] = nickname;
    data['headImg'] = headImg;
    data['tribeName'] = tribeName;
    data['firstAnswer'] = firstAnswer;
    data['firstFile'] = firstFile;
    data['fileType'] = fileType;
    data['textType'] = textType;
    data['answerUserId'] = answerUserId;
    data['answerId'] = answerId;
    data['agreeStatus'] = agreeStatus;
    return data;
  }
}

class FindTopicContentListModel {
  List<FindTopicContentItemModel> list;
  FindTopicContentListModel({required this.list});

  factory FindTopicContentListModel.fromJson(List list) {
    return FindTopicContentListModel(
        list: list.map((e) => FindTopicContentItemModel.fromJson(e)).toList());
  }
}
