// 请求配置
class HttpOptions {
  // 连接服务器超时时间，单位是毫秒
  static const int connectTimeout = 10000;
  // 接收超时时间，单位是毫秒
  static const int receiveTimeout = 10000;
  // 地址前缀
  static const String baseUrl = 'https://gate.ieasydog.com/api/';
  // 是否全局显示http请求日志
  static const bool showGlobalLogger = true;

  /*
   * 登录注册相关接口
   */
  /// 密码登录
  static const String applogin = 'user/user/applogin';

  /// 获取用户信息
  static const String userIndex = 'user/user/userIndex';

  /// 获取我的页面宠物信息
  static const String selectUserId = 'user/pet/selectUserId';

  /*
   * 宠物相关接口
   */
  /// 保存宠物信息: /api/user/pet/save
  static const String petSave = 'user/pet/save';

  /*
   * 首页相关接口
   */
  /// 轮播图: discover/advertUnit/selectPageList?locationName=2&locationPage=1
  static const String selectPageList = 'discover/advertUnit/selectPageList';

  /// 首页种草列表: auditStatus=1&pageIndex=1&pageSize=10&userLoginId=136899
  static const String getTrialReportList =
      'user/trialReport/getTrialReportList';

  /// 首页推荐列表: messageTotal=0&pageIndex=1&reportTotal=0&thirtyPieces=1&userLoginId=136899
  static const String selectMessageRecommendList =
      'user/message/selectMessageRecommendList';

  /// 首页种草列表: post: /user/trialReport/getTrialReportInfo
  static const String getTrialReportInfo =
      'user/trialReport/getTrialReportInfo';

  /// 首页种草点赞: post: user/agree/updateTrialReportAgree
  static const String updateTrialReportAgree =
      'user/agree/updateTrialReportAgree';

  /// 首页种草收藏: post: user/collections/update
  static const String collectionApi = 'user/collections/update';

  // 发现轮播图: /user/messageLabel/v2006/lt/selectMessageLabelList?pageIndex=1&pageSize=5
  static const String selectMessageLabelList =
      'user/messageLabel/v2006/lt/selectMessageLabelList';

  /// 发现-附近: /user/message/getMessageNearby?latitude=30.285382&longitude=120.036424&pageIndex=1&pageSize=10&total=0&userLoginId=136899
  static const String getMessageNearby = 'user/message/getMessageNearby';

  /// 发现-动态详情: user/message/detail?messageId=29720&userId=136899
  static const String find_detail = 'user/message/detail';

  /// 发现关注-推荐关注列表: user/relation/selectNotRelation?pageIndex=1&pageSize=3&userLoginId=136899
  static const String selectNotRelation = 'user/relation/selectNotRelation';

  /// 发现关注-动态列表: user/message/selectPageList?listType=2&pageIndex=2&pageSize=10&total=388&userLoginId=136899
  static const String user_selectNotRelation = 'user/message/selectPageList';

  /// 发现-点赞: user/agree/updateAgree?agreeStatus=0&messageId=29720&userId=136899
  /// 点赞评论: agreeStatus=0&commentId=34161&userId=136899
  /// agreeStatus: 0点赞, 1: 取消
  static const String updateAgree = 'user/agree/updateAgree';

  /// 发现-收藏(post): user/collections/update
  /// collectionsStatus=0&messageId=29716&token=&userId=136899
  /// collectionsStatus: 0收藏, 1取消
  static const String user_collection = 'user/collections/update';

  /// 发现-评论列表: user/comment/selectCommentPage?messageId=29716&pageIndex=1&pageSize=10&replySize=5&userId=136899&userLoginId=136899
  static const String selectCommentPage = 'user/comment/selectCommentPage';

  /// 发现-评论内容(post): user/comment/save
  /// commentInfo=&messageId=29716&token=&userId=136899
  static const String comment_save = 'user/comment/save';

  /// 发现-评论-二级评论内容(post): user/commentReply/save
  /// beReplyedUserId=120987&commentId=35318&commentInfo=&replyUserId=136899&token=
  static const String comment_reply_save = 'user/commentReply/save';

  /// 发现-删除评论: user/comment/delete?commentId=35327&userLoginId=136899
  static const String comment_delete = 'user/comment/delete';

  /// 发现-关注: user/relation/UpdateAttation?isFlag=0&userByid=147280&userId=136899
  /// isFlag: 0关注, 1取消关注
  static const String updateAttation = 'user/relation/UpdateAttation';

  /// 发现-关注列表: user/relation/selectMyAttention?pageIndex=1&pageSize=15&userId=136899&userLoginId=136899
  static const String selectMyAttention = 'user/relation/selectMyAttention';

  /// 发现--视频列表: user/message/selectCurrentVideoPage?messageId=29801&orderColumn=create_time&pageIndex=1&pageSize=10&userLoginId=136899
  static const String selectCurrentVideoPage =
      'user/message/selectCurrentVideoPage';

  /// 话题讨论: user/messageLabel/getMessageAndReportBylabel?messageLabelId=399&orderType=1&pageIndex=1&pageSize=10&userLoginId=136899
  /// orderType: 热门1, 最新2
  static const String getMessageBylabel =
      'user/messageLabel/getMessageAndReportBylabel';

  /// 热门话题: user/tribe/v2004/lik/getHotTribe?dogBreedId=102
  static const String getHotTribe = 'user/tribe/v2004/lik/getHotTribe';

  /// 热门讨论: user/question/v1911/lt/selectQuestionHotList?pageIndex=1&pageSize=6&userId=136899
  static const String selectQuestionHotList =
      'user/question/v1911/lt/selectQuestionHotList';

  /// 问题回答列表-最热
  /// get: user/answer/v1911/zyz/selectHotAnswerPage?pageIndex=1&pageSize=10&questionId=99&userId=136899
  static const String selectHotAnswerPage =
      '/user/answer/v1911/zyz/selectHotAnswerPage';

  /// 问题回答列表-最新
  /// get: user/answer/v1911/zyz/selectNewAnswerPage?pageIndex=1&pageSize=10&questionId=99&userId=136899
  static const String selectNewAnswerPage =
      '/user/answer/v1911/zyz/selectNewAnswerPage';

  /// 热门列表
  /// post: /user/tribe/allTribeList
  /// pageIndex=1&pageSize=10&userId=136899
  static const String allTribeList = '/user/tribe/allTribeList';

  /// 犬种信息
  /// post: /user/tribe/selectTribeInfo
  /// loginUserId=136899&tribeId=7
  static const String selectTribeInfo = '/user/tribe/selectTribeInfo';

  /// 讨论列表
  /// get: /user/question/v1911/lik/selectQuestionList?orderType=1&pageIndex=1&pageSize=10&tribeId=17&userId=136899
  static const String selectQuestionList = '/user/question/v1911/lik/selectQuestionList';

  /// 热门列表关注
  /// post: user/tribeUser/updateTribeUser, delFlag=0&tribeId=24&userId=136899
  /// delFlag: 0, 关注, 1:取消关注
  static const String updateTribeUser = '/user/tribeUser/updateTribeUser';
}
