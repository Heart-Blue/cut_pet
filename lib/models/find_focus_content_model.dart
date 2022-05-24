class FindFocusContentItemModel {
  late int messageId;
  late int userId;
  late String messageType;
  late String messageInfo;
  late int cntComment;
  late int cntTranspond;
  late int cntAgree;
  late int cntRead;
  late int fileCount;
  late String followStatus;
  late String isSelf;
  late String level;
  late String agreeStatus;
  late String createTime;
  late String ctime;
  late List<FileList> fileList;
  late UserInfo userInfo;
  late MessageLabel messageLabel;
  late List atusers;
  late List<CommentList> commentList;

  FindFocusContentItemModel(
      {this.messageId = 0,
      this.userId = 0,
      this.messageType = '',
      this.messageInfo = '',
      this.cntComment = 0,
      this.cntTranspond = 0,
      this.cntAgree = 0,
      this.cntRead = 0,
      this.fileCount = 0,
      this.followStatus = '',
      this.isSelf = '',
      this.level = '',
      this.agreeStatus = '',
      this.createTime = '',
      this.ctime = '',
      required this.fileList,
      required this.userInfo,
      required this.messageLabel,
      required this.atusers,
      required this.commentList});

  FindFocusContentItemModel.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'] ?? 0;
    userId = json['userId'] ?? 0;
    messageType = json['messageType'] ?? '';
    messageInfo = json['messageInfo'] ?? '';
    cntComment = json['cntComment'] ?? 0;
    cntTranspond = json['cntTranspond'] ?? 0;
    cntAgree = json['cntAgree'] ?? 0;
    cntRead = json['cntRead'] ?? 0;
    fileCount = json['fileCount'] ?? 0;
    followStatus = json['followStatus'] ?? '';
    isSelf = json['isSelf'] ?? '';
    level = json['level'] ?? '';
    agreeStatus = json['agreeStatus'] ?? '';
    createTime = json['createTime'] ?? '';
    ctime = json['ctime'] ?? '';
    if (json['fileList'] != null) {
      fileList = <FileList>[];
      json['fileList'].forEach((v) {
        fileList.add(FileList.fromJson(v));
      });
    }
    if(json['userInfo'] != null) {
      userInfo = UserInfo.fromJson(json['userInfo']);
    }
    if(json['messageLabel'] != null) {
      messageLabel = MessageLabel.fromJson(json['messageLabel']);
    }
    if (json['atusers'] != null) {
      atusers = [];
      json['atusers'].forEach((v) {
        atusers.add(v);
      });
    }
    if (json['commentList'] != null) {
      commentList = <CommentList>[];
      json['commentList'].forEach((v) {
        commentList.add(CommentList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['messageId'] = messageId;
    data['userId'] = userId;
    data['messageType'] = messageType;
    data['messageInfo'] = messageInfo;
    data['cntComment'] = cntComment;
    data['cntTranspond'] = cntTranspond;
    data['cntAgree'] = cntAgree;
    data['cntRead'] = cntRead;
    data['fileCount'] = fileCount;
    data['followStatus'] = followStatus;
    data['isSelf'] = isSelf;
    data['level'] = level;
    data['agreeStatus'] = agreeStatus;
    data['createTime'] = createTime;
    data['ctime'] = ctime;
    data['fileList'] = fileList.map((v) => v.toJson()).toList();
    data['userInfo'] = userInfo.toJson();
    data['messageLabel'] = messageLabel.toJson();
    data['atusers'] = atusers.map((v) => v.toJson()).toList();
    data['commentList'] = commentList.map((v) => v.toJson()).toList();
    return data;
  }
}

class FileList {
  late int fileId;
  late String fileUrl;
  late String fileType;
  late String height;
  late String width;

  FileList(
      {this.fileId = 0,
      this.fileUrl = '',
      this.fileType = '',
      this.height = '',
      this.width = ''});

  FileList.fromJson(Map<String, dynamic> json) {
    fileId = json['fileId'] ?? 0;
    fileUrl = json['fileUrl'] ?? '';
    fileType = json['fileType'] ?? '';
    height = json['height'] ?? '';
    width = json['width'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['fileId'] = fileId;
    data['fileUrl'] = fileUrl;
    data['fileType'] = fileType;
    data['height'] = height;
    data['width'] = width;
    return data;
  }
}

class UserInfo {
  late int userId;
  late String headImg;
  late String nickname;
  late String city;

  UserInfo(
      {this.userId = 0, this.headImg = '', this.nickname = '', this.city = ''});

  UserInfo.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] ?? 0;
    headImg = json['headImg'] ?? '';
    nickname = json['nickname'] ?? '';
    city = json['city'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userId'] = userId;
    data['headImg'] = headImg;
    data['nickname'] = nickname;
    data['city'] = city;
    return data;
  }
}

class MessageLabel {
  late int labelId;
  late String labelName;

  MessageLabel({this.labelId = 0, this.labelName = ''});

  MessageLabel.fromJson(Map<String, dynamic> json) {
    labelId = json['labelId'] ?? 0;
    labelName = json['labelName'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['labelId'] = labelId;
    data['labelName'] = labelName;
    return data;
  }
}

class CommentList {
  late int commentId;
  late String commentInfo;
  late int userId;
  late int messageId;
  late String nickname;
  late List atUsers;

  CommentList(
      {this.commentId = 0,
      this.commentInfo = '',
      this.userId = 0,
      this.messageId = 0,
      this.nickname = '',
      required this.atUsers});

  CommentList.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'] ?? 0;
    commentInfo = json['commentInfo'] ?? '';
    userId = json['userId'] ?? 0;
    messageId = json['messageId'] ?? 0;
    nickname = json['nickname'] ?? '';
    if (json['atUsers'] != null) {
      atUsers = [];
      json['atUsers'].forEach((v) {
        atUsers.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['commentId'] = commentId;
    data['commentInfo'] = commentInfo;
    data['userId'] = userId;
    data['messageId'] = messageId;
    data['nickname'] = nickname;
    data['atUsers'] = atUsers.map((v) => v.toJson()).toList();
    return data;
  }
}

class FindFocusContentListModel {
  List<FindFocusContentItemModel> list;
  FindFocusContentListModel({required this.list});

  factory FindFocusContentListModel.fromJson(List list) {
    return FindFocusContentListModel(list: list.map((e) => FindFocusContentItemModel.fromJson(e)).toList());
  }
}
