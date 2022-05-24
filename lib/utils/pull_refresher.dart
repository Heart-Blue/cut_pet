import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PullRefresher {
  ///自定义刷新头部
  static Widget customHeader = const ClassicHeader(
    height: 45.0,
    releaseText: '松开手刷新',
    refreshingText: '刷新中',
    completeText: '刷新完成',
    failedText: '刷新失败',
    idleText: '下拉刷新',
  );

  ///自定义刷新底部
  static Widget customFooter = CustomFooter(
    builder: (BuildContext context, LoadStatus? mode) {
      Widget body;
      if (mode == LoadStatus.idle) {
        body = const Text("下拉加载");
      } else if (mode == LoadStatus.loading) {
        body = const CupertinoActivityIndicator();
      } else if (mode == LoadStatus.failed) {
        body = const Text("加载失败");
      } else if (mode == LoadStatus.canLoading) {
        body = const Text("加载更多...");
      } else {
        body = const Text("没有数据了...");
      }
      return Container(
        height: 55.0,
        color: const Color(0xfff3f2f9),
        child: Center(child: body),
      );
    },
  );
}
