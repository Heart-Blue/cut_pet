class HomeVideoItemModel {
  late int messageId;
  late String messageInfo;
  late int userId;
  late String nickName;
  late String headImg;
  late int fileId;
  late String fileUrl;
  late int cntComment;
  late int cntRead;
  late int cntAgree;
  late int cntTranspond;
  late String collectionNum;
  late String videoCover;
  late String agreeStatus;
  late String collectionStatus;
  late String createTime;
  late String coverHeight;
  late String coverWidth;
  late List atusers;
  late int labelId;
  late String labelName;
  late String isSelf;
  late String followStatus;
  late String sex;
  late String intro;

  HomeVideoItemModel(
      {this.messageId = 0,
      this.messageInfo = '',
      this.userId = 0,
      this.nickName = '',
      this.headImg = '',
      this.fileId = 0,
      this.fileUrl = '',
      this.cntComment = 0,
      this.cntRead = 0,
      this.cntAgree = 0,
      this.cntTranspond = 0,
      this.collectionNum = '',
      this.videoCover = '',
      this.agreeStatus = '',
      this.collectionStatus = '',
      this.createTime = '',
      this.coverHeight = '',
      this.coverWidth = '',
      required this.atusers,
      this.labelId = 0,
      this.labelName = '',
      this.isSelf = '',
      this.followStatus = '',
      this.sex = '',
      this.intro = ''});

  HomeVideoItemModel.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'] ?? 0;
    messageInfo = json['messageInfo'] ?? '';
    userId = json['userId'] ?? 0;
    nickName = json['nickName'] ?? '';
    headImg = json['headImg'] ?? '';
    fileId = json['fileId'] ?? 0;
    fileUrl = json['fileUrl'] ?? '';
    cntComment = json['cntComment'] ?? 0;
    cntRead = json['cntRead'] ?? 0;
    cntAgree = json['cntAgree'] ?? 0;
    cntTranspond = json['cntTranspond'] ?? 0;
    collectionNum = json['collectionNum'] ?? '';
    videoCover = json['videoCover'] ?? '';
    agreeStatus = json['agreeStatus'] ?? '';
    collectionStatus = json['collectionStatus'] ?? '';
    createTime = json['createTime'] ?? '';
    coverHeight = json['coverHeight'] ?? '';
    coverWidth = json['coverWidth'] ?? '';
    if (json['atusers'] != null) {
      atusers = [];
      json['atusers'].forEach((v) {
        atusers.add(v);
      });
    }
    labelId = json['labelId'] ?? 0;
    labelName = json['labelName'] ?? '';
    isSelf = json['isSelf'] ?? '';
    followStatus = json['followStatus'] ?? '';
    sex = json['sex'] ?? '';
    intro = json['intro'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['messageId'] = messageId;
    data['messageInfo'] = messageInfo;
    data['userId'] = userId;
    data['nickName'] = nickName;
    data['headImg'] = headImg;
    data['fileId'] = fileId;
    data['fileUrl'] = fileUrl;
    data['cntComment'] = cntComment;
    data['cntRead'] = cntRead;
    data['cntAgree'] = cntAgree;
    data['cntTranspond'] = cntTranspond;
    data['collectionNum'] = collectionNum;
    data['videoCover'] = videoCover;
    data['agreeStatus'] = agreeStatus;
    data['collectionStatus'] = collectionStatus;
    data['createTime'] = createTime;
    data['coverHeight'] = coverHeight;
    data['coverWidth'] = coverWidth;
    data['atusers'] = atusers.map((v) => v.toJson()).toList();
    data['labelId'] = labelId;
    data['labelName'] = labelName;
    data['isSelf'] = isSelf;
    data['followStatus'] = followStatus;
    data['sex'] = sex;
    data['intro'] = intro;
    return data;
  }
}

class HomeVideoListModel {
  List<HomeVideoItemModel> list;
  HomeVideoListModel({required this.list});

  factory HomeVideoListModel.fromJson(List<dynamic> list) {
    return HomeVideoListModel(
        list: list.map((e) => HomeVideoItemModel.fromJson(e)).toList());
  }
}
