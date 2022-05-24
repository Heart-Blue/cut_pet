class HomeRecommendDetailModel {
  late int trialReportId;
  late int userId;
  late String reportTitle;
  late String reportType;
  late String auditStatus;
  late String h5MessageInfo;
  late String messageAgreenum;
  late String messageCommentnum;
  late String labelName;
  late String labelId;
  late String nickname;
  late String headImg;
  late String createTime;
  late String followStatus;
  late String collectionCount;
  late String collectionStatus;
  late String agreeStatus;
  late List<FileList> fileList;
  late bool isSelf;

  HomeRecommendDetailModel(
      {this.trialReportId = 0,
      this.userId = 0,
      this.reportTitle = '',
      this.reportType = '',
      this.auditStatus = '',
      this.h5MessageInfo = '',
      this.messageAgreenum = '',
      this.messageCommentnum = '',
      this.labelName = '',
      this.labelId = '',
      this.nickname = '',
      this.headImg = '',
      this.createTime = '',
      this.followStatus = '',
      this.collectionCount = '',
      this.collectionStatus = '',
      this.agreeStatus = '',
      required this.fileList,
      this.isSelf = false});

  HomeRecommendDetailModel.fromJson(Map<String, dynamic> json) {
    trialReportId = json['trialReportId'] ?? 0;
    userId = json['userId'] ?? 0;
    reportTitle = json['reportTitle'] ?? '';
    reportType = json['reportType'] ?? '';
    auditStatus = json['auditStatus'] ?? '';
    h5MessageInfo = json['h5MessageInfo'] ?? '';
    messageAgreenum = json['messageAgreenum'] ?? '';
    messageCommentnum = json['messageCommentnum'] ?? '';
    labelName = json['labelName'] ?? '';
    labelId = json['labelId'] ?? '';
    nickname = json['nickname'] ?? '';
    headImg = json['headImg'] ?? '';
    createTime = json['createTime'] ?? '';
    followStatus = json['followStatus'] ?? '';
    collectionCount = json['collectionCount'] ?? '';
    collectionStatus = json['collectionStatus'] ?? '';
    agreeStatus = json['agreeStatus'];
    if (json['fileList'] != null) {
      fileList = [];
      json['fileList'].forEach((v) {
        fileList.add(FileList.fromJson(v));
      });
    }
    isSelf = json['isSelf'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['trialReportId'] = trialReportId;
    data['userId'] = userId;
    data['reportTitle'] = reportTitle;
    data['reportType'] = reportType;
    data['auditStatus'] = auditStatus;
    data['h5MessageInfo'] = h5MessageInfo;
    data['messageAgreenum'] = messageAgreenum;
    data['messageCommentnum'] = messageCommentnum;
    data['labelName'] = labelName;
    data['labelId'] = labelId;
    data['nickname'] = nickname;
    data['headImg'] = headImg;
    data['createTime'] = createTime;
    data['followStatus'] = followStatus;
    data['collectionCount'] = collectionCount;
    data['collectionStatus'] = collectionStatus;
    data['agreeStatus'] = agreeStatus;
    data['fileList'] = fileList.map((v) => v.toJson()).toList();
    data['isSelf'] = isSelf;
    return data;
  }
}

class FileList {
  late int fileId;
  late int trialReportId;
  late String fileUrl;
  late String fileType;
  late String height;
  late String width;

  FileList(
      {this.fileId = 0,
      this.trialReportId = 0,
      this.fileUrl = '',
      this.fileType = '',
      this.height = '',
      this.width = ''});

  FileList.fromJson(Map<String, dynamic> json) {
    fileId = json['fileId'] ?? 0;
    trialReportId = json['trialReportId'] ?? 0;
    fileUrl = json['fileUrl'] ?? '';
    fileType = json['fileType'] ?? '';
    height = json['height'] ?? '';
    width = json['width'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['fileId'] = fileId;
    data['trialReportId'] = trialReportId;
    data['fileUrl'] = fileUrl;
    data['fileType'] = fileType;
    data['height'] = height;
    data['width'] = width;
    return data;
  }
}
