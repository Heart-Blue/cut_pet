class TopicPetItemModel {
  late String tribeId;
  late String tribeName;
  late String headImg;
  late String tribeDescription;
  late String tribeMessageCount;
  late String tribeUserCount;
  late String joinStatus;
  late int userCount;

  TopicPetItemModel(
      {this.tribeId = '',
      this.tribeName = '',
      this.headImg = '',
      this.tribeDescription = '',
      this.tribeMessageCount = '',
      this.tribeUserCount = '',
      this.joinStatus = '',
      this.userCount = 0});

  TopicPetItemModel.fromJson(Map<String, dynamic> json) {
    tribeId = json['tribeId'] ?? '';
    tribeName = json['tribeName'] ?? '';
    headImg = json['headImg'] ?? '';
    tribeDescription = json['tribeDescription'] ?? '';
    tribeMessageCount = json['tribeMessageCount'] ?? '';
    tribeUserCount = json['tribeUserCount'] ?? '';
    joinStatus = json['joinStatus'] ?? '';
    userCount = json['userCount'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['tribeId'] = tribeId;
    data['tribeName'] = tribeName;
    data['headImg'] = headImg;
    data['tribeDescription'] = tribeDescription;
    data['tribeMessageCount'] = tribeMessageCount;
    data['tribeUserCount'] = tribeUserCount;
    data['joinStatus'] = joinStatus;
    data['userCount'] = userCount;
    return data;
  }
}

class TopicPetListModel {
  List<TopicPetItemModel> list;
  TopicPetListModel({required this.list});

  factory TopicPetListModel.fromJson(List list) {
    return TopicPetListModel(list: list.map((e) => TopicPetItemModel.fromJson(e)).toList());
  }
}
