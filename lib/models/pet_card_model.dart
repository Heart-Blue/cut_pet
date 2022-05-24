class PetCardItemModel {
  late int trialReportId;
  late String reportType;
  late String reportTitle;
  late String messageInfo;
  late String isHot;
  late String messageCollectnum;
  late String messageCommentnum;
  late String messageTranspondnum;
  late String messageAgreenum;
  late String messageReadnum;
  late String agreeStatus;
  late String auditStatus;
  late String createTime;
  late int userId;
  late String headImg;
  late String nickname;
  late int labelId;
  late String labelName;
  late String fileUrl;

  PetCardItemModel(
      {this.trialReportId = 0,
      this.reportType = '',
      this.reportTitle = '',
      this.messageInfo = '',
      this.isHot = '',
      this.messageCollectnum = '',
      this.messageCommentnum = '',
      this.messageTranspondnum = '',
      this.messageAgreenum = '',
      this.messageReadnum = '',
      this.agreeStatus = '',
      this.auditStatus = '',
      this.createTime = '',
      this.userId = 0,
      this.headImg = '',
      this.nickname = '',
      this.labelId = 0,
      this.labelName = '',
      this.fileUrl = ''});

  PetCardItemModel.fromJson(Map<String, dynamic> json) {
    trialReportId = json['trialReportId'] ?? 0;
    reportType = json['reportType'] ?? '';
    reportTitle = json['reportTitle'] ?? '';
    messageInfo = json['messageInfo'] ?? '';
    isHot = json['isHot'] ?? '';
    messageCollectnum = json['messageCollectnum'] ?? '';
    messageCommentnum = json['messageCommentnum'] ?? '';
    messageTranspondnum = json['messageTranspondnum'] ?? '';
    messageAgreenum = json['messageAgreenum'] ?? '';
    messageReadnum = json['messageReadnum'] ?? '';
    agreeStatus = json['agreeStatus'] ?? '';
    auditStatus = json['auditStatus'] ?? '';
    createTime = json['createTime'] ?? '';
    userId = json['userId'] ?? 0;
    headImg = json['headImg'] ?? '';
    nickname = json['nickname'] ?? '';
    labelId = json['labelId'] ?? 0;
    labelName = json['labelName'] ?? '';
    fileUrl = json['fileUrl'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['trialReportId'] = trialReportId;
    data['reportType'] = reportType;
    data['reportTitle'] = reportTitle;
    data['messageInfo'] = messageInfo;
    data['isHot'] = isHot;
    data['messageCollectnum'] = messageCollectnum;
    data['messageCommentnum'] = messageCommentnum;
    data['messageTranspondnum'] = messageTranspondnum;
    data['messageAgreenum'] = messageAgreenum;
    data['messageReadnum'] = messageReadnum;
    data['agreeStatus'] = agreeStatus;
    data['auditStatus'] = auditStatus;
    data['createTime'] = createTime;
    data['userId'] = userId;
    data['headImg'] = headImg;
    data['nickname'] = nickname;
    data['labelId'] = labelId;
    data['labelName'] = labelName;
    data['fileUrl'] = fileUrl;
    return data;
  }
}

class PetCardListModel {
  List<PetCardItemModel> list;
  PetCardListModel({
    required this.list
  });

  factory PetCardListModel.fromJson(List<dynamic> list) {
    return PetCardListModel(list: list.map((e) => PetCardItemModel.fromJson(e)).toList());
  }
}
