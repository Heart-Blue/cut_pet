import 'package:cute_pet/components/network_image.dart';
import 'package:cute_pet/models/comment_reply_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentReplyItem extends StatefulWidget {
  final List<CommentReolyModel> replyLists;
  final int userId;
  const CommentReplyItem(
      {required this.replyLists, required this.userId, Key? key})
      : super(key: key);

  @override
  _CommentReplyItemState createState() => _CommentReplyItemState();
}

class _CommentReplyItemState extends State<CommentReplyItem> {
  bool _showAll = false;
  final int _maxCount = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30.h),
      child: Column(
        children: renderAllComment(),
      ),
    );
  }

  List<Widget> renderAllComment() {
    final commentCount = widget.replyLists.length;

    int showCount = commentCount;
    if (commentCount > _maxCount) {
      showCount = _showAll ? commentCount : _maxCount;
    }

    List<Widget> commentList = [];
    for (var i = 0; i < showCount; i++) {
      commentList.add(renderCommentItem(widget.replyLists[i]));
    }

    if (commentCount > _maxCount) {
      commentList.add(renderShowAllButton());
    }

    return commentList;
  }

  Widget renderCommentItem(CommentReolyModel model) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: renderUserInfoItems(model)),
          renderCommentInfo(model)
        ],
      ),
    );
  }

  List<Widget> renderUserInfoItems(CommentReolyModel model) {
    List<Widget> commentList = [];

    Widget headerImage = GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(75.w),
        child: NetLoadImage(
          imageUrl: model.headImg,
          width: 35.w,
          height: 35.w,
        ),
      ),
      onTap: () {},
    );
    commentList.add(headerImage);

    Widget title = Text(model.replyNickname,
        style: TextStyle(fontSize: 24.sp, color: const Color(0xff666666)));
    commentList.add(SizedBox(width: 4.w));
    commentList.add(title);

    Widget time = Text(model.replyPublishTime,
        style: TextStyle(fontSize: 24.sp, color: const Color(0xff999999)));
    commentList.add(SizedBox(width: 20.w));
    commentList.add(time);

    if (widget.userId == model.replyUserId) {
      Widget logo = Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: const Color(0xff79b7f7)),
        child: Text('作者', style: TextStyle(fontSize: 9.w, color: Colors.white)),
      );
      commentList.add(SizedBox(width: 4.w));
      commentList.add(logo);
    }

    return commentList;
  }

  Widget renderCommentInfo(CommentReolyModel model) {
    String nickName = model.nickname + ': ';
    return Container(
        padding: EdgeInsets.only(left: 40.w, right: 20.w, top: 3.h),
        child: Text.rich(TextSpan(children: [
          WidgetSpan(
              child: Text('回复',
                  style: TextStyle(
                      fontSize: 24.sp, color: const Color(0xff666666))),
              alignment: PlaceholderAlignment.middle),
          ...nickName.runes.map((rune) {
            return WidgetSpan(
                child: Text(String.fromCharCode(rune),
                    style: TextStyle(
                        fontSize: 24.sp, color: const Color(0xff526e94))),
                alignment: PlaceholderAlignment.middle);
          }).toList(),
          ...model.commentInfo.runes.map((rune) {
            return WidgetSpan(
                child: Text(String.fromCharCode(rune),
                    style: TextStyle(
                        fontSize: 26.sp, color: const Color(0xff333333))),
                alignment: PlaceholderAlignment.middle);
          }).toList(),
        ])));
  }

  Widget renderShowAllButton() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Text.rich(TextSpan(children: [
          WidgetSpan(
              child: Text(_showAll ? '收起' : '展开所有',
                  style: TextStyle(
                      fontSize: 24.sp, color: const Color(0xff526e94))),
              alignment: PlaceholderAlignment.middle),
          WidgetSpan(
              child: Icon(Icons.arrow_drop_down,
                  size: 28.sp, color: const Color(0xff526e94)),
              alignment: PlaceholderAlignment.middle),
        ])),
      ),
      onTap: () {
        setState(() {
          _showAll = !_showAll;
        });
      },
    );
  }
}
