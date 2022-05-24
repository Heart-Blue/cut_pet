import 'package:cute_pet/models/comment_reply_model.dart';

class CommentItemModel {
  late int commentId;
  late String commentInfo;
  late int userId;
  late String nickname;
  late String headImg;
  late int replySize;
  late String publishTime;
  late int cntReply;
  late int userLoginId;
  late List<CommentReolyModel> commentReplyVOs;
  late List atusers;
  late String petDays;
  late int authorUserId;
  late int cntAgree;
  late String agreeStatus;

  CommentItemModel(
      {this.commentId = 0,
      this.commentInfo = '',
      this.userId = 0,
      this.nickname = '',
      this.headImg = '',
      this.replySize = 0,
      this.publishTime = '',
      this.cntReply = 0,
      this.userLoginId = 0,
      required this.commentReplyVOs,
      required this.atusers,
      this.petDays = '',
      this.authorUserId = 0,
      this.cntAgree = 0,
      this.agreeStatus = ''});

  CommentItemModel.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'] ?? 0;
    commentInfo = json['commentInfo'] ?? '';
    userId = json['userId'] ?? 0;
    nickname = json['nickname'] ?? '';
    headImg = json['headImg'] ?? '';
    replySize = json['replySize'] ?? 0;
    publishTime = json['publishTime'] ?? '';
    cntReply = json['cntReply'] ?? 0;
    userLoginId = json['userLoginId'] ?? 0;
    if (json['commentReplyVOs'] != null) {
      commentReplyVOs = [];
      json['commentReplyVOs'].forEach((v) {
        commentReplyVOs.add(CommentReolyModel.fromJson(v));
      });
    }
    if (json['atusers'] != null) {
      atusers = [];
      json['atusers'].forEach((v) {
        atusers.add(v);
      });
    }
    petDays = json['petDays'] ?? '';
    authorUserId = json['authorUserId'] ?? 0;
    cntAgree = json['cntAgree'] ?? 0;
    agreeStatus = json['agreeStatus'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['commentId'] = commentId;
    data['commentInfo'] = commentInfo;
    data['userId'] = userId;
    data['nickname'] = nickname;
    data['headImg'] = headImg;
    data['replySize'] = replySize;
    data['publishTime'] = publishTime;
    data['cntReply'] = cntReply;
    data['userLoginId'] = userLoginId;
    data['commentReplyVOs'] = commentReplyVOs.map((v) => v.toJson()).toList();
    data['atusers'] = atusers.map((v) => v.toJson()).toList();
    data['petDays'] = petDays;
    data['authorUserId'] = authorUserId;
    data['cntAgree'] = cntAgree;
    data['agreeStatus'] = agreeStatus;
    return data;
  }
}

class CommentListModel {
  List<CommentItemModel> list;
  CommentListModel({required this.list});

  factory CommentListModel.fromJson(List<dynamic> list) {
    return CommentListModel(
        list: list.map((e) => CommentItemModel.fromJson(e)).toList());
  }
}
