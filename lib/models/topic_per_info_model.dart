class TopicPetInfoModel {
  late String tribeId;
  late String ownerId;
  late String ownerNickName;
  late String ownerHeadImg;
  late String accId;
  late String tribeName;
  late String headImg;
  late String tribeDescription;
  late String thirdGroupId;
  late String groupName;
  late String groupImg;
  late String tribeMessageCount;
  late String tribeUserCount;
  late String joinStatus;
  late String followStatus;
  late String dogBreed;
  late int dogBreedId;

  TopicPetInfoModel(
      {this.tribeId = '',
      this.ownerId = '',
      this.ownerNickName = '',
      this.ownerHeadImg = '',
      this.accId = '',
      this.tribeName = '',
      this.headImg = '',
      this.tribeDescription = '',
      this.thirdGroupId = '',
      this.groupName = '',
      this.groupImg = '',
      this.tribeMessageCount = '',
      this.tribeUserCount = '',
      this.joinStatus = '',
      this.followStatus = '',
      this.dogBreed = '',
      this.dogBreedId = 0});

  TopicPetInfoModel.fromJson(Map<String, dynamic> json) {
    tribeId = json['tribeId'] ?? '';
    ownerId = json['ownerId'] ?? '';
    ownerNickName = json['ownerNickName'] ?? '';
    ownerHeadImg = json['ownerHeadImg'] ?? '';
    accId = json['accId'] ?? '';
    tribeName = json['tribeName'] ?? '';
    headImg = json['headImg'] ?? '';
    tribeDescription = json['tribeDescription'] ?? '';
    thirdGroupId = json['thirdGroupId'] ?? '';
    groupName = json['groupName'] ?? '';
    groupImg = json['groupImg'] ?? '';
    tribeMessageCount = json['tribeMessageCount'] ?? '';
    tribeUserCount = json['tribeUserCount'] ?? '';
    joinStatus = json['joinStatus'] ?? '';
    followStatus = json['followStatus'] ?? '';
    dogBreed = json['dogBreed'] ?? '';
    dogBreedId = json['dogBreedId'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['tribeId'] = tribeId;
    data['ownerId'] = ownerId;
    data['ownerNickName'] = ownerNickName;
    data['ownerHeadImg'] = ownerHeadImg;
    data['accId'] = accId;
    data['tribeName'] = tribeName;
    data['headImg'] = headImg;
    data['tribeDescription'] = tribeDescription;
    data['thirdGroupId'] = thirdGroupId;
    data['groupName'] = groupName;
    data['groupImg'] = groupImg;
    data['tribeMessageCount'] = tribeMessageCount;
    data['tribeUserCount'] = tribeUserCount;
    data['joinStatus'] = joinStatus;
    data['followStatus'] = followStatus;
    data['dogBreed'] = dogBreed;
    data['dogBreedId'] = dogBreedId;
    return data;
  }
}
