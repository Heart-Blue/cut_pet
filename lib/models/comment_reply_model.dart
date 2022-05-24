class CommentReolyModel {
  late int userId;
  late int replyUserId;
  late String replyNickname;
  late String commentInfo;
  late int replyId;
  late String headImg;
  late String nickname;
  late List atusers;
  late String replyPublishTime;
  late String petDays;

  CommentReolyModel(
      {this.userId = 0,
      this.replyUserId = 0,
      this.replyNickname = '',
      this.commentInfo = '',
      this.replyId = 0,
      this.headImg = '',
      this.nickname = '',
      required this.atusers,
      this.replyPublishTime = '',
      this.petDays = ''});

  CommentReolyModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] ?? 0;
    replyUserId = json['replyUserId'] ?? 0;
    replyNickname = json['replyNickname'] ?? '';
    commentInfo = json['commentInfo'] ?? '';
    replyId = json['replyId'] ?? 0;
    headImg = json['headImg'] ?? '';
    nickname = json['nickname'] ?? '';
    if (json['atusers'] != null) {
      atusers = [];
      json['atusers'].forEach((v) {
        atusers.add(v);
      });
    }
    replyPublishTime = json['replyPublishTime'] ?? '';
    petDays = json['petDays'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userId'] = userId;
    data['replyUserId'] = replyUserId;
    data['replyNickname'] = replyNickname;
    data['commentInfo'] = commentInfo;
    data['replyId'] = replyId;
    data['headImg'] = headImg;
    data['nickname'] = nickname;
    data['atusers'] = atusers.map((v) => v.toJson()).toList();
    data['replyPublishTime'] = replyPublishTime;
    data['petDays'] = petDays;
    return data;
  }
}
