class HomeConditionDetailModel {
  late int messageId;
  late int userId;
  late String nickName;
  late String headImg;
  late String city;
  late String level;
  late String messageInfo;
  late List<Files> files;
  late String createTime;
  late String messageType;
  late String isSelf;
  late int labelId;
  late String labelName;
  late String labelType;
  late List atusers;
  late String followStatus;
  late int cntAgree;
  late List<Agrees> agrees;
  late String agreeStatus;
  late String collectionsStatus;
  late String delFlag;
  late String commentNum;
  late String collectionNum;

  HomeConditionDetailModel(
      {this.messageId = 0,
      this.userId = 0,
      this.nickName = '',
      this.headImg = '',
      this.city = '',
      this.level = '',
      this.messageInfo = '',
      required this.files,
      this.createTime = '',
      this.messageType = '',
      this.isSelf = '',
      this.labelId = 0,
      this.labelName = '',
      this.labelType = '',
      required this.atusers,
      this.followStatus = '',
      this.cntAgree = 0,
      required this.agrees,
      this.agreeStatus = '0',
      this.collectionsStatus = '0',
      this.delFlag = '',
      this.commentNum = '',
      this.collectionNum = ''});

  HomeConditionDetailModel.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'] ?? 0;
    userId = json['userId'] ?? 0;
    nickName = json['nickName'] ?? '';
    headImg = json['headImg'] ?? '';
    city = json['city'] ?? '';
    level = json['level'] ?? '';
    messageInfo = json['messageInfo'] ?? '';
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files.add(Files.fromJson(v));
      });
    }
    createTime = json['createTime'] ?? '';
    messageType = json['messageType'] ?? '';
    isSelf = json['isSelf'] ?? '';
    labelId = json['labelId'] ?? 0;
    labelName = json['labelName'] ?? '';
    labelType = json['labelType'] ?? '';
    if (json['atusers'] != null) {
      atusers = [];
      json['atusers'].forEach((v) {
        atusers.add(v);
      });
    }
    followStatus = json['followStatus'] ?? '';
    cntAgree = json['cntAgree'] ?? 0;
    if (json['agrees'] != null) {
      agrees = <Agrees>[];
      json['agrees'].forEach((v) {
        agrees.add(Agrees.fromJson(v));
      });
    }
    agreeStatus = json['agreeStatus'] ?? '0';
    collectionsStatus = json['collectionsStatus'] ?? '0';
    delFlag = json['delFlag'] ?? '';
    commentNum = json['commentNum'] ?? '';
    collectionNum = json['collectionNum'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['messageId'] = messageId;
    data['userId'] = userId;
    data['nickName'] = nickName;
    data['headImg'] = headImg;
    data['city'] = city;
    data['level'] = level;
    data['messageInfo'] = messageInfo;
    data['files'] = files.map((v) => v.toJson()).toList();
    data['createTime'] = createTime;
    data['messageType'] = messageType;
    data['isSelf'] = isSelf;
    data['labelId'] = labelId;
    data['labelName'] = labelName;
    data['labelType'] = labelType;
    data['atusers'] = atusers.map((v) => v.toJson()).toList();
    data['followStatus'] = followStatus;
    data['cntAgree'] = cntAgree;
    data['agrees'] = agrees.map((v) => v.toJson()).toList();
    data['agreeStatus'] = agreeStatus;
    data['collectionsStatus'] = collectionsStatus;
    data['delFlag'] = delFlag;
    data['commentNum'] = commentNum;
    data['collectionNum'] = collectionNum;
    return data;
  }
}

class Files {
  late int fileId;
  late String fileUrl;
  late String fileType;
  late String height;
  late String width;
  late String createTime;

  Files(
      {this.fileId = 0,
      this.fileUrl = '',
      this.fileType = '',
      this.height = '',
      this.width = '',
      this.createTime = ''});

  Files.fromJson(Map<String, dynamic> json) {
    fileId = json['fileId'] ?? 0;
    fileUrl = json['fileUrl'] ?? '';
    fileType = json['fileType'] ?? '';
    height = json['height'] ?? '';
    width = json['width'] ?? '';
    createTime = json['createTime'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['fileId'] = fileId;
    data['fileUrl'] = fileUrl;
    data['fileType'] = fileType;
    data['height'] = height;
    data['width'] = width;
    data['createTime'] = createTime;
    return data;
  }
}

class Agrees {
  late int userId;
  late String headImg;
  late String nickname;
  late String city;
  late String level;

  Agrees(
      {this.userId = 0,
      this.headImg = '',
      this.nickname = '',
      this.city = '',
      this.level = ''});

  Agrees.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] ?? 0;
    headImg = json['headImg'] ?? '';
    nickname = json['nickname'] ?? '';
    city = json['city'] ?? '';
    level = json['level'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userId'] = userId;
    data['headImg'] = headImg;
    data['nickname'] = nickname;
    data['city'] = city;
    data['level'] = level;
    return data;
  }
}
