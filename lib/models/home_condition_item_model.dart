class HomeConditionItemModel {
  late int messageId;
  late int userId;
  late String messageType;
  late String videoCover;
  late String messageInfo;
  late String isHot;
  late String headImg;
  late String nickname;
  late String messageReadNum;
  late String messageAgreeNum;
  late int type;
  late String coverHeight;
  late String coverWidth;
  late bool isSelf;
  late List atUsers;
  late String agreeStatus;
  late int messageLabelId;
  late String labelName;

  HomeConditionItemModel(
      {this.messageId = 0,
      this.userId = 0,
      this.messageType = '',
      this.videoCover = '',
      this.messageInfo = '',
      this.isHot = '',
      this.headImg = '',
      this.nickname = '',
      this.messageReadNum = '',
      this.messageAgreeNum = '',
      this.type = 0,
      this.coverHeight = '',
      this.coverWidth = '',
      this.isSelf = false,
      required this.atUsers,
      this.agreeStatus  = '',
      this.messageLabelId = 0,
      this.labelName = ''});

  HomeConditionItemModel.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'] ?? 0;
    userId = json['userId'] ?? 0;
    messageType = json['messageType'] ?? '';
    videoCover = json['videoCover'] ?? '';
    messageInfo = json['messageInfo'] ?? '';
    isHot = json['isHot'] ?? '';
    headImg = json['headImg'] ?? '';
    nickname = json['nickname'] ?? '';
    messageReadNum = json['messageReadNum'] ?? '';
    messageAgreeNum = json['messageAgreeNum'] ?? '';
    type = json['type'] ?? 0;
    coverHeight = json['coverHeight'] ?? '';
    coverWidth = json['coverWidth'] ?? '';
    isSelf = json['isSelf'] ?? false;
    if (json['atUsers'] != null) {
      atUsers = [];
      json['atUsers'].forEach((v) {
        atUsers.add(v);
      });
    }
    agreeStatus = json['agreeStatus'] ?? '';
    messageLabelId = json['messageLabelId'] ?? 0;
    labelName = json['labelName'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['messageId'] = messageId;
    data['userId'] = userId;
    data['messageType'] = messageType;
    data['videoCover'] = videoCover;
    data['messageInfo'] = messageInfo;
    data['isHot'] = isHot;
    data['headImg'] = headImg;
    data['nickname'] = nickname;
    data['messageReadNum'] = messageReadNum;
    data['messageAgreeNum'] = messageAgreeNum;
    data['type'] = type;
    data['coverHeight'] = coverHeight;
    data['coverWidth'] = coverWidth;
    data['isSelf'] = isSelf;
    data['atUsers'] = atUsers.map((v) => v.toJson()).toList();
    data['agreeStatus'] = agreeStatus;
    data['messageLabelId'] = messageLabelId;
    data['labelName'] = labelName;
    return data;
  }
}

class HomeConditionListModel {
  List<HomeConditionItemModel> list;
  HomeConditionListModel({required this.list});

  factory HomeConditionListModel.fromJson(List<dynamic> list) {
    return HomeConditionListModel(
        list: list.map((e) => HomeConditionItemModel.fromJson(e)).toList());
  }
}
