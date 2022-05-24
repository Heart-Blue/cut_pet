class LoginProfileInfoModel {
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
  late String token;
  late String nickname;
  late String headImg;
  late String accToken;

  LoginProfileInfoModel(
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
      this.delFlag = '',
      this.token = '',
      this.nickname = '',
      this.headImg = '',
      this.accToken = ''});

  LoginProfileInfoModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] ?? 0;
    userPhone = json['userPhone'] ?? '';
    userPassword = json['userPassword'] ?? '';
    userType = json['userType'] ?? '';
    authStatus = json['authStatus'] ?? '';
    userProperty = json['userProperty'] ?? '';
    registerChannel = json['registerChannel'] ?? '';
    registerType = json['registerType'] ?? '';
    platformType = json['platformType'] ?? '';
    createTime = json['createTime'] ?? '';
    modifyTime = json['modifyTime'] ?? '';
    isFlag = json['isFlag'] ?? '';
    delFlag = json['delFlag'] ?? '';
    token = json['token'] ?? '';
    nickname = json['nickname'] ?? '';
    headImg = json['headImg'] ?? '';
    accToken = json['accToken'] ?? '';
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
    data['token'] = token;
    data['nickname'] = nickname;
    data['headImg'] = headImg;
    data['accToken'] = accToken;
    return data;
  }
}
