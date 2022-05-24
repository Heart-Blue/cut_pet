class FindTopicTopItemModel {
  late String tribeId;
  late String tribeName;
  late String headImg;
  late String recommendType;
  late String tribeUserCount;
  late String isCollect;
  late bool isRelation;

  FindTopicTopItemModel(
      {this.tribeId = '',
      this.tribeName = '',
      this.headImg = '',
      this.recommendType = '',
      this.tribeUserCount = '',
      this.isCollect = '',
      this.isRelation = false
      });

  FindTopicTopItemModel.fromJson(Map<String, dynamic> json) {
    tribeId = json['tribeId'] ?? '';
    tribeName = json['tribeName'] ?? '';
    headImg = json['headImg'] ?? '';
    recommendType = json['recommendType'] ?? '';
    tribeUserCount = json['tribeUserCount'] ?? '';
    isCollect = json['isCollect'] ?? '';
    isRelation = json['isRelation'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['tribeId'] = tribeId;
    data['tribeName'] = tribeName;
    data['headImg'] = headImg;
    data['recommendType'] = recommendType;
    data['tribeUserCount'] = tribeUserCount;
    data['isCollect'] = isCollect;
    data['isRelation'] = isRelation;
    return data;
  }
}

class FindTopicTopListModel {
  List<FindTopicTopItemModel> list;
  FindTopicTopListModel({required this.list});

  factory FindTopicTopListModel.fromJson(List list) {
    return FindTopicTopListModel(
        list: list.map((e) => FindTopicTopItemModel.fromJson(e)).toList());
  }
}
