class TopicHotItemModel {
  late int answerId;
  late int answerUserId;
  late String textType;
  late String htmlDescription;
  late String textDescription;
  late int commentNum;
  late int agreeNum;
  late int readNum;
  late String firstFile;
  late String fileType;
  late String createTime;
  late String nickname;
  late String headImg;
  late String followStatus;
  late String isAgree;

  TopicHotItemModel(
      {this.answerId = 0,
      this.answerUserId = 0,
      this.textType = '',
      this.htmlDescription = '',
      this.textDescription = '',
      this.commentNum = 0,
      this.agreeNum = 0,
      this.readNum = 0,
      this.firstFile = '',
      this.fileType = '',
      this.createTime = '',
      this.nickname = '',
      this.headImg = '',
      this.followStatus = '',
      this.isAgree = ''});

  TopicHotItemModel.fromJson(Map<String, dynamic> json) {
    answerId = json['answerId'] ?? 0;
    answerUserId = json['answerUserId'] ?? 0;
    textType = json['textType'] ?? '';
    htmlDescription = json['htmlDescription'] ?? '';
    textDescription = json['textDescription'] ?? '';
    commentNum = json['commentNum'] ?? 0;
    agreeNum = json['agreeNum'] ?? 0;
    readNum = json['readNum'] ?? 0;
    firstFile = json['firstFile'] ?? '';
    fileType = json['fileType'] ?? '';
    createTime = json['createTime'] ?? '';
    nickname = json['nickname'] ?? '';
    headImg = json['headImg'] ?? '';
    followStatus = json['followStatus'] ?? '';
    isAgree = json['isAgree'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['answerId'] = answerId;
    data['answerUserId'] = answerUserId;
    data['textType'] = textType;
    data['htmlDescription'] = htmlDescription;
    data['textDescription'] = textDescription;
    data['commentNum'] = commentNum;
    data['agreeNum'] = agreeNum;
    data['readNum'] = readNum;
    data['firstFile'] = firstFile;
    data['fileType'] = fileType;
    data['createTime'] = createTime;
    data['nickname'] = nickname;
    data['headImg'] = headImg;
    data['followStatus'] = followStatus;
    data['isAgree'] = isAgree;
    return data;
  }
}

class TopicHotListModel {
  List<TopicHotItemModel> list;
  TopicHotListModel({required this.list});

  factory TopicHotListModel.fromJson(List list) {
    return TopicHotListModel(list: list.map((e) => TopicHotItemModel.fromJson(e)).toList());
  }
}
