class FindFocusTopItemModel {
  late int userId;
  late String headImg;
  late String nickname;
  late String petBreed;
  late int relationNum;
  late bool isRelation;

  FindFocusTopItemModel(
      {this.userId = 0,
      this.headImg = '',
      this.nickname = '',
      this.petBreed = '田园犬',
      this.isRelation = false,
      this.relationNum = 0});

  FindFocusTopItemModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] ?? 0;
    headImg = json['headImg'] ?? '';
    nickname = json['nickname'] ?? '';
    petBreed = json['petBreed'] ?? '田园犬';
    relationNum = json['relationNum'] ?? 0;
    isRelation = json['isRelation'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userId'] = userId;
    data['headImg'] = headImg;
    data['nickname'] = nickname;
    data['petBreed'] = petBreed;
    data['relationNum'] = relationNum;
    data['isFocus'] = isRelation;
    return data;
  }
}

class FindFocusTopIListModel {
  List<FindFocusTopItemModel> list;
  FindFocusTopIListModel({required this.list});

  factory FindFocusTopIListModel.fromJson(List list) {
    return FindFocusTopIListModel(
        list: list.map((e) => FindFocusTopItemModel.fromJson(e)).toList());
  }
}
