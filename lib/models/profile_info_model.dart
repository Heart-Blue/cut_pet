class ProfileInfoModel {
  late User user;
  late Userinfo userinfo;
  late Userlevel userlevel;
  late List usermedalList;
  late int petCount;
  late int messageCount;
  late int fansCount;
  late int followCount;
  late int agreeCount;
  late String isSelf;
  late String followStatus;
  late String totalWalkDogTime;
  late TargetRule targetRule;
  late String fansNotifyStatus;
  late bool deviceStatus;
  late UserMember userMember;
  late int validCouponCount;
  late String userIndexBanner;

  ProfileInfoModel(
      {
        required this.user,
      required this.userinfo,
      required this.userlevel,
      required this.usermedalList,
      this.petCount = 0,
      this.messageCount = 0,
      this.fansCount = 0,
      this.followCount = 0,
      this.agreeCount = 0,
      this.isSelf = '',
      this.followStatus = '',
      this.totalWalkDogTime = '',
      required this.targetRule,
      this.fansNotifyStatus = '',
      this.deviceStatus = false,
      required this.userMember,
      this.validCouponCount = 0,
      this.userIndexBanner = ''});

  ProfileInfoModel.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
    userinfo = Userinfo.fromJson(json['userinfo']);
    userlevel = Userlevel.fromJson(json['userlevel']);
    if (json['usermedalList'] != null) {
      usermedalList = [];
      json['usermedalList'].forEach((v) {
        usermedalList.add(v);
      });
    }
    petCount = json['petCount'];
    messageCount = json['messageCount'];
    fansCount = json['fansCount'];
    followCount = json['followCount'];
    agreeCount = json['agreeCount'];
    isSelf = json['isSelf'];
    followStatus = json['followStatus'];
    totalWalkDogTime = json['totalWalkDogTime'];
    targetRule = TargetRule.fromJson(json['targetRule']);
    fansNotifyStatus = json['fansNotifyStatus'];
    deviceStatus = json['deviceStatus'];
    userMember = UserMember.fromJson(json['userMember']);
    validCouponCount = json['validCouponCount'];
    userIndexBanner = json['userIndexBanner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['user'] = user.toJson();
    data['userinfo'] = userinfo.toJson();
    data['userlevel'] = userlevel.toJson();
    data['usermedalList'] =
        usermedalList.map((v) => v.toJson()).toList();
    data['petCount'] = petCount;
    data['messageCount'] = messageCount;
    data['fansCount'] = fansCount;
    data['followCount'] = followCount;
    data['agreeCount'] = agreeCount;
    data['isSelf'] = isSelf;
    data['followStatus'] = followStatus;
    data['totalWalkDogTime'] = totalWalkDogTime;
    data['targetRule'] = targetRule.toJson();
    data['fansNotifyStatus'] = fansNotifyStatus;
    data['deviceStatus'] = deviceStatus;
    data['userMember'] = userMember.toJson();
    data['validCouponCount'] = validCouponCount;
    data['userIndexBanner'] = userIndexBanner;
    return data;
  }
}

class User {
  late int userId;
  late String userPhone;
  late String userPassword;
  late String userType;
  late String authStatus;
  late String userProperty;
  late String registerChannel;
  late String registerType;
  late String platformType;
  late String createTime;
  late String modifyTime;
  late String isFlag;
  late String delFlag;

  User(
      {this.userId = 0,
      this.userPhone = '',
      this.userPassword = '',
      this.userType = '',
      this.authStatus = '',
      this.userProperty = '',
      this.registerChannel = '',
      this.registerType = '',
      this.platformType = '',
      this.createTime = '',
      this.modifyTime = '',
      this.isFlag = '',
      this.delFlag = ''});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userPhone = json['userPhone'];
    userPassword = json['userPassword'];
    userType = json['userType'];
    authStatus = json['authStatus'];
    userProperty = json['userProperty'];
    registerChannel = json['registerChannel'];
    registerType = json['registerType'];
    platformType = json['platformType'];
    createTime = json['createTime'];
    modifyTime = json['modifyTime'];
    isFlag = json['isFlag'];
    delFlag = json['delFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userId'] = userId;
    data['userPhone'] = userPhone;
    data['userPassword'] = userPassword;
    data['userType'] = userType;
    data['authStatus'] = authStatus;
    data['userProperty'] = userProperty;
    data['registerChannel'] = registerChannel;
    data['registerType'] = registerType;
    data['platformType'] = platformType;
    data['createTime'] = createTime;
    data['modifyTime'] = modifyTime;
    data['isFlag'] = isFlag;
    data['delFlag'] = delFlag;
    return data;
  }
}

class Userinfo {
  late int userinfoId;
  late int userId;
  late String accid;
  late String accToken;
  late String hxPassword;
  late String headImg;
  late String nickname;
  late int boneValue;
  late int foodValue;
  late int coin;
  late double accountBalance;
  late String province;
  late String city;
  late String sex;
  late String intro;
  late String deviceNo;
  late String inviteCode;
  late int starRankId;
  late int starRank;
  late String starRankName;
  late int starValue;
  late String chainPrivateKey;
  late String chainPublicKey;
  late String chainAddress;
  late String talentType;
  late String isRecommend;
  late String imei;
  late String createTime;
  late String modifyTime;
  late String isFlag;
  late String delFlag;

  Userinfo(
      {
        this.userinfoId = 0,
      this.userId = 0,
      this.accid = '',
      this.accToken = '',
      this.hxPassword = '',
      this.headImg = '',
      this.nickname = '',
      this.boneValue = 0,
      this.foodValue = 0,
      this.coin = 0,
      this.accountBalance = 0,
      this.province = '',
      this.city = '',
      this.sex = '',
      this.intro = '',
      this.deviceNo = '',
      this.inviteCode = '',
      this.starRankId = 0,
      this.starRank = 0,
      this.starRankName = '',
      this.starValue = 0,
      this.chainPrivateKey = '',
      this.chainPublicKey = '',
      this.chainAddress = '',
      this.talentType = '',
      this.isRecommend = '',
      this.imei = '',
      this.createTime = '',
      this.modifyTime = '',
      this.isFlag = '',
      this.delFlag = ''});

  Userinfo.fromJson(Map<String, dynamic> json) {
    userinfoId = json['userinfoId'];
    userId = json['userId'];
    accid = json['accid'];
    accToken = json['accToken'];
    hxPassword = json['hxPassword'];
    headImg = json['headImg'];
    nickname = json['nickname'];
    boneValue = json['boneValue'];
    foodValue = json['foodValue'];
    coin = json['coin'];
    accountBalance = json['accountBalance'];
    province = json['province'];
    city = json['city'];
    sex = json['sex'];
    intro = json['intro'];
    deviceNo = json['deviceNo'];
    inviteCode = json['inviteCode'];
    starRankId = json['starRankId'];
    starRank = json['starRank'];
    starRankName = json['starRankName'];
    starValue = json['starValue'];
    chainPrivateKey = json['chainPrivateKey'];
    chainPublicKey = json['chainPublicKey'];
    chainAddress = json['chainAddress'];
    talentType = json['talentType'];
    isRecommend = json['isRecommend'];
    imei = json['imei'];
    createTime = json['createTime'];
    modifyTime = json['modifyTime'];
    isFlag = json['isFlag'];
    delFlag = json['delFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userinfoId'] = userinfoId;
    data['userId'] = userId;
    data['accid'] = accid;
    data['accToken'] = accToken;
    data['hxPassword'] = hxPassword;
    data['headImg'] = headImg;
    data['nickname'] = nickname;
    data['boneValue'] = boneValue;
    data['foodValue'] = foodValue;
    data['coin'] = coin;
    data['accountBalance'] = accountBalance;
    data['province'] = province;
    data['city'] = city;
    data['sex'] = sex;
    data['intro'] = intro;
    data['deviceNo'] = deviceNo;
    data['inviteCode'] = inviteCode;
    data['starRankId'] = starRankId;
    data['starRank'] = starRank;
    data['starRankName'] = starRankName;
    data['starValue'] = starValue;
    data['chainPrivateKey'] = chainPrivateKey;
    data['chainPublicKey'] = chainPublicKey;
    data['chainAddress'] = chainAddress;
    data['talentType'] = talentType;
    data['isRecommend'] = isRecommend;
    data['imei'] = imei;
    data['createTime'] = createTime;
    data['modifyTime'] = modifyTime;
    data['isFlag'] = isFlag;
    data['delFlag'] = delFlag;
    return data;
  }
}

class Userlevel {
  late int userlevelId;
  late int userId;
  late String level;
  late int growthValue;
  late String createTime;
  late String modifyTime;
  late String isFlag;
  late String delFlag;

  Userlevel(
      {this.userlevelId = 0,
      this.userId = 0,
      this.level = '',
      this.growthValue = 0,
      this.createTime = '',
      this.modifyTime = '',
      this.isFlag = '',
      this.delFlag = ''});

  Userlevel.fromJson(Map<String, dynamic> json) {
    userlevelId = json['userlevelId'];
    userId = json['userId'];
    level = json['level'];
    growthValue = json['growthValue'];
    createTime = json['createTime'];
    modifyTime = json['modifyTime'];
    isFlag = json['isFlag'];
    delFlag = json['delFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userlevelId'] = userlevelId;
    data['userId'] = userId;
    data['level'] = level;
    data['growthValue'] = growthValue;
    data['createTime'] = createTime;
    data['modifyTime'] = modifyTime;
    data['isFlag'] = isFlag;
    data['delFlag'] = delFlag;
    return data;
  }
}

class TargetRule {
  late int ruleId;
  late String level;
  late int growthValue;
  late String createTime;
  late String isFlag;
  late String delFlag;

  TargetRule(
      {this.ruleId = 0,
      this.level = '',
      this.growthValue = 0,
      this.createTime = '',
      this.isFlag = '',
      this.delFlag = ''});

  TargetRule.fromJson(Map<String, dynamic> json) {
    ruleId = json['ruleId'];
    level = json['level'];
    growthValue = json['growthValue'];
    createTime = json['createTime'];
    isFlag = json['isFlag'];
    delFlag = json['delFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['ruleId'] = ruleId;
    data['level'] = level;
    data['growthValue'] = growthValue;
    data['createTime'] = createTime;
    data['isFlag'] = isFlag;
    data['delFlag'] = delFlag;
    return data;
  }
}

class UserMember {
  late int rankId;
  late String rankName;
  late String plusStatus;
  late String plusType;
  late int rankValue;
  late int jifen;
  late int nextRankNeedValue;

  UserMember(
      {this.rankId = 0,
      this.rankName = '',
      this.plusStatus = '',
      this.plusType = '',
      this.rankValue = 0,
      this.jifen = 0,
      this.nextRankNeedValue = 0});

  UserMember.fromJson(Map<String, dynamic> json) {
    rankId = json['rankId'];
    rankName = json['rankName'];
    plusStatus = json['plusStatus'];
    plusType = json['plusType'];
    rankValue = json['rankValue'];
    jifen = json['jifen'];
    nextRankNeedValue = json['nextRankNeedValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['rankId'] = rankId;
    data['rankName'] = rankName;
    data['plusStatus'] = plusStatus;
    data['plusType'] = plusType;
    data['rankValue'] = rankValue;
    data['jifen'] = jifen;
    data['nextRankNeedValue'] = nextRankNeedValue;
    return data;
  }
}
