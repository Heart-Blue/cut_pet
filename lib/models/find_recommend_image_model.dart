class FindRecommendImageItemModel {
  late int labelId;
  late String labelName;
  late String labelType;
  late String labelImg;
  late String labelIcon;
  late int weight;
  late String isHot;
  late String isFlag;
  late String delFlag;
  late String createTime;
  late String modifyTime;
  late int createPerson;
  late int modifyPerson;
  late int userCount;
  late int readNUm;

  FindRecommendImageItemModel(
      {this.labelId = 0,
      this.labelName = '',
      this.labelType = '',
      this.labelImg = '',
      this.labelIcon = '',
      this.weight = 0,
      this.isHot = '',
      this.isFlag = '',
      this.delFlag = '',
      this.createTime = '',
      this.modifyTime = '',
      this.createPerson = 0,
      this.modifyPerson = 0,
      this.userCount = 0,
      this.readNUm = 0});

  FindRecommendImageItemModel.fromJson(Map<String, dynamic> json) {
    labelId = json['labelId'] ?? 0;
    labelName = json['labelName']?? '';
    labelType = json['labelType']?? '';
    labelImg = json['labelImg']?? '';
    labelIcon = json['labelIcon']?? '';
    weight = json['weight'] ?? 0;
    isHot = json['isHot']?? '';
    isFlag = json['isFlag']?? '';
    delFlag = json['delFlag']?? '';
    createTime = json['createTime']?? '';
    modifyTime = json['modifyTime']?? '';
    createPerson = json['createPerson'] ?? 0;
    modifyPerson = json['modifyPerson'] ?? 0;
    userCount = json['userCount'] ?? 0;
    readNUm = json['readNUm'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['labelId'] = labelId;
    data['labelName'] = labelName;
    data['labelType'] = labelType;
    data['labelImg'] = labelImg;
    data['labelIcon'] = labelIcon;
    data['weight'] = weight;
    data['isHot'] = isHot;
    data['isFlag'] = isFlag;
    data['delFlag'] = delFlag;
    data['createTime'] = createTime;
    data['modifyTime'] = modifyTime;
    data['createPerson'] = createPerson;
    data['modifyPerson'] = modifyPerson;
    data['userCount'] = userCount;
    data['readNUm'] = readNUm;
    return data;
  }
}

class FindRecommendImageListModel {
  List<FindRecommendImageItemModel> list;
  FindRecommendImageListModel({
    required this.list
  });

  factory FindRecommendImageListModel.fromJson(List list) {
    return FindRecommendImageListModel(list: list.map((e) => FindRecommendImageItemModel.fromJson(e)).toList());
  }
}
