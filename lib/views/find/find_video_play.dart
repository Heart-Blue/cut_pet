import 'package:cute_pet/components/find_bottom_tool.dart';
import 'package:cute_pet/components/network_image.dart';
import 'package:cute_pet/controllers/app_theme_controller.dart';
import 'package:cute_pet/models/home_video_item_model.dart';
import 'package:cute_pet/utils/find_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class FindVideoPlay extends StatefulWidget {
  final HomeVideoItemModel homeVideoItemModel;
  final FindActionCallBack actionCallback;
  const FindVideoPlay(
      {Key? key,
      required this.homeVideoItemModel,
      required this.actionCallback})
      : super(key: key);

  @override
  _FindVideoPlayState createState() => _FindVideoPlayState();
}

class _FindVideoPlayState extends State<FindVideoPlay> {
  late VideoPlayerController _videoController;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _editController = TextEditingController();
  final _appThemeController = Get.find<AppThemeController>();

  bool _isPlaying = true; //是否播放的按钮
  int _currentTime = 0; //当前播放时间
  int _totalTime = 1; //总时间

  void _videoListener() {
    if (!_videoController.value.hasError) {
      setState(() {
        _currentTime = _videoController.value.position.inSeconds;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _videoController =
        VideoPlayerController.network(widget.homeVideoItemModel.fileUrl);
    _videoController.setLooping(true);
    _videoController.addListener(_videoListener);
    _videoController.initialize().then((value) {
      _videoController.play();
      _totalTime = _videoController.value.duration.inSeconds;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _videoController.removeListener(_videoListener);

    super.dispose();
  }

  // 保存视频
  void _saveVideo() {
    // TKMediaUtil.saveVideo(widget.homeVideoItemModel.fileUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          renderVideoItem(),
          renderBottomBar(),
          renderNavigation(),
        ],
      ),
    );
  }

  Widget renderNavigation() {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Get.back();
              }),
          IconButton(
              icon: const Icon(Icons.file_download, color: Colors.white),
              onPressed: () => _saveVideo()),
        ],
      ),
    );
  }

  Widget renderVideoItem() {
    Widget videoItem = AspectRatio(
      aspectRatio: _videoController.value.aspectRatio,
      child: VideoPlayer(_videoController),
    );

    Widget indicator = Stack(
      children: <Widget>[
        Image.network(widget.homeVideoItemModel.videoCover,
            fit: BoxFit.contain, width: Get.width, height: Get.height),
        const Center(child: CircularProgressIndicator())
      ],
    );

    return GestureDetector(
      child: Container(
        width: Get.width,
        height: Get.height,
        color: Colors.black,
        child: Center(
            child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            _videoController.value.isInitialized ? videoItem : indicator,
            Positioned(
                child: _isPlaying
                    ? Container()
                    : Center(
                        child: Image.asset('assets/images/video_play.png',
                            width: 55.w, height: 55.w)))
          ],
        )),
      ),
      onTap: () {
        if (_isPlaying) {
          _videoController.pause();
        } else {
          _videoController.play();
        }
        setState(() {
          _isPlaying = !_isPlaying;
        });
      },
    );
  }

  Widget renderBottomBar() {
    return Positioned(
      bottom: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(15.w, 0, 16.w, 20.h),
        width: Get.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.black45, Colors.transparent],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            renderUserInfo(),
            renderMessage(),
            renderProgressItem(),
            renderBottomItem()
          ],
        ),
      ),
    );
  }

  Widget renderUserInfo() {
    return Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(50.w),
          child: NetLoadImage(
            imageUrl: widget.homeVideoItemModel.headImg,
            width: 50.w,
            height: 50.w,
          ),
        ),
        SizedBox(width: 20.w),
        Text(widget.homeVideoItemModel.nickName,
            style: TextStyle(fontSize: 28.sp, color: Colors.white))
      ],
    );
  }

  Widget renderMessage() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Text(widget.homeVideoItemModel.messageInfo,
          style: TextStyle(fontSize: 28.sp, color: Colors.white)),
    );
  }

  Widget renderProgressItem() {
    return Row(
      children: <Widget>[
        Text(getTimer(_currentTime),
            style: TextStyle(fontSize: 24.sp, color: Colors.white)),
        SizedBox(width: 10.w),
        Expanded(
          child: SizedBox(
            height: 2.h,
            child: LinearProgressIndicator(
              value: _currentTime / _totalTime,
              backgroundColor: const Color(0x88FFFFFF),
              valueColor: const AlwaysStoppedAnimation(Colors.white),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Text(getTimer(_totalTime),
            style: TextStyle(fontSize: 24.sp, color: Colors.white)),
      ],
    );
  }

  Widget renderBottomItem() {
    return FindBottomTool(
      focusNode: _focusNode,
      controller: _editController,
      submitAction: (text) => {},
      backcolorColor: Colors.transparent,
      showBorder: false,
      appThemeController: _appThemeController,
      actionCallback: (type) {
      },
    );
  }

  String getTimer(int duration) {
    final int time = duration;
    final minute = time ~/ 60;
    final secord = time % 60;

    final minuteStr = minute > 9 ? '$minute' : '0$minute';
    final secordStr = secord > 9 ? '$secord' : '0$secord';

    return '$minuteStr:$secordStr';
  }
}
