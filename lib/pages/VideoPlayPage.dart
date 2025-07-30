import 'package:bayes/base/base_widget.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:fijkplayer_plus/fijkplayer_plus.dart';
import 'package:flutter/cupertino.dart';

///视频播放
class VideoPlayPage extends BaseWidget {
  String? path;

  VideoPlayPage({super.key, this.path});

  @override
  BaseWidgetState<BaseWidget> getState() {
    return _State();
  }
}

class _State extends BaseWidgetState<VideoPlayPage> {
  final FijkPlayer player = FijkPlayer();

  int selectIndex = 0;

  @override
  Widget buildWidget(BuildContext context) {
    return FijkView(
      player: player,
      width: ScreenUtil.L(360),
      height: ScreenUtil.L(200),
      panelBuilder: fijkPanel2Builder(fill: true),
    );
  }

  @override
  void onCreate() {
    setAppBarVisible(true);
    setTopBarVisible(true);
    setAppBarTitle("缓存视频播放");
    player.setDataSource(widget.path ?? '', autoPlay: true, showCover: true);
    floatingShow = false;
  }

  @override
  void onPause() {}

  @override
  void onResume() {
    //    player.start();
  }

  @override
  void dispose() {
    player.release();
    super.dispose();
  }

  @override
  void onBackground() {
    player.pause();
    super.onBackground();
  }
}
