import 'dart:async';

import 'package:bayes/constant/color.dart';
import 'package:bayes/utils/sp_constant.dart';
import 'package:fijkplayer_plus/fijkplayer_plus.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomFijkWidgetBottom extends StatefulWidget {
  final FijkPlayer player;
  final BuildContext? buildContext;
  final Size? viewSize;
  final Rect? texturePos;
  double? speed = SpConstanst().getVideoSpeed();

  CustomFijkWidgetBottom({
    super.key,
    required this.player,
    this.buildContext,
    this.viewSize,
    this.texturePos,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomFijkWidgetBottomState createState() => _CustomFijkWidgetBottomState();
}

class _CustomFijkWidgetBottomState extends State<CustomFijkWidgetBottom> {
  FijkPlayer get player => widget.player;

  /// 是否显示状态栏+菜单栏
  bool isPlayShowCont = true;

  /// 已播放时长
  String durrentPos = "00:00:00";

  /// 进度条总长度
  Duration _duration = Duration();

  /// 流监听器
  late StreamSubscription _currentPosSubs;

  /// 进度条当前进度
  double sliderValue = 1000.0;

  bool _prepared = false;
  bool _playing = false;

  @override
  void initState() {
    _prepared = player.state.index >= FijkState.prepared.index;
    _playing = player.state == FijkState.started;

    /// 进行监听
    widget.player.addListener(_playerValueChanged);

    /// 接收流
    _currentPosSubs = widget.player.onCurrentPosUpdate.listen((v) {
      setState(() {
        /// 实时获取当前播放进度（进度条）
        this.sliderValue = v.inMilliseconds.toDouble();

        /// 实时获取当前播放进度（数字展示）
        durrentPos = v.toString().substring(0, v.toString().indexOf("."));
      });
    });
    _duration = player.value.duration;

    /// 初始化
    super.initState();
  }

  bool _hideStuff = true;

  /// 监听器
  void _playerValueChanged() {
    FijkValue value = player.value;
    if (value.duration != _duration) {
      if (_hideStuff == false) {
        setState(() {
          _duration = value.duration;
        });
      } else {
        _duration = value.duration;
      }
    }
    bool playing = (value.state == FijkState.started);
    bool prepared = value.prepared;
    if (playing != _playing ||
        prepared != _prepared ||
        value.state == FijkState.asyncPreparing) {
      setState(() {
        _playing = playing;
        _prepared = prepared;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Rect rect = Rect.fromLTWH(
      0,
      0,
      widget.viewSize!.width,
      widget.viewSize!.height,
    );

    return Positioned.fromRect(
      rect: rect,
      child: GestureDetector(
        onTap: onTapFun,
        onDoubleTap: onDoubleTapFun,
        onHorizontalDragUpdate: (d) {},
        child: Container(
          color: isPlayShowCont ? Colors.black12 : Colors.transparent,
          alignment: Alignment.bottomLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(),
              Stack(
                children: <Widget>[
                  //播放暂停按钮
                  isPlayShowCont ? buildStart2PuaseButton() : Container(),
                  speedSettingShow ? speedSetting() : Container(),
                ],
              ),
              //底部控制栏
              isPlayShowCont
                  ? SizedBox(
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "  $durrentPos ",
                            style: TextStyle(color: Colors.white),
                          ),
                          //进度条 使用Slider滑动组件实现
                          Expanded(child: buildSlider()),
                          //播放时间
                          Text(
                            "  ${_duration2String(_duration)}",
                            style: TextStyle(color: Colors.white),
                          ),
                          //倍数播放
                          speedButton(),
                          //全屏按钮
                          buildFullScreenButton(),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  double dura2double(Duration d) {
    // ignore: unnecessary_null_comparison
    double value = d != null ? d.inMilliseconds.toDouble() : 0.0;
    if (value == 0.0) return 100000.0;
    return value;
  }

  String _duration2String(Duration duration) {
    if (duration.inMilliseconds < 0) return "-: negtive";

    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    int inHours = duration.inHours;
    return inHours > 0
        ? "$inHours:$twoDigitMinutes:$twoDigitSeconds"
        : "$twoDigitMinutes:$twoDigitSeconds";
  }

  //屏幕的点击事件, showCont强制显示控制栏，当操作了其它功能时，强制显示
  void onTapFun({bool showCont = false}) {
    if (speedSettingShow) {
      setState(() {
        speedSettingShow = false;
      });
    }
    setState(() {
      if (showCont) {
        isPlayShowCont = true;
      } else {
        // 显示 、隐藏  进度条+标题栏
        isPlayShowCont = !isPlayShowCont;
      }
    });
  }

  //双击 播放或者暂停
  void onDoubleTapFun() {
    onTapFun(showCont: true);
    setState(() {
      (player.state == FijkState.started)
          ? widget.player.pause()
          : widget.player.start();
    });
  }

  //播放 暂停按钮
  Widget buildStart2PuaseButton() {
    return Container(
      height: widget.viewSize!.height - 50,
      alignment: Alignment.center,
      child: IconButton(
        icon: Icon(
          (player.state == FijkState.started) ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
          size: 40,
        ),
        onPressed: () {
          onDoubleTapFun();
        },
      ),
    );
  }

  static const FijkSliderColors sliderColors = FijkSliderColors(
    cursorColor: Color.fromARGB(240, 250, 100, 10),
    playedColor: Color.fromARGB(200, 240, 90, 50),
    baselineColor: Color.fromARGB(100, 20, 20, 20),
    bufferedColor: Color.fromARGB(180, 200, 200, 200),
  );

  //进度条
  Widget buildSlider() {
    return FijkSlider(
      colors: sliderColors,
      value: sliderValue,
      min: 0.0,
      max: dura2double(_duration),
      onChanged: (val) {},
      onChangeEnd: (val) {
        onTapFun(showCont: true);
        sliderValue = val.floorToDouble();
        // 设置进度
        player.seekTo(sliderValue.toInt());
        setState(() {});
      },
    );
  }

  //  fplayer.setSpeed(1.5);
  List<double> speeds = [1.0, 1.25, 1.5, 2.0];

  //设置倍数播放是否显示
  bool speedSettingShow = false;

  //倍数播放按钮
  Widget speedButton() {
    return InkWell(
      onTap: () {
        onTapFun(showCont: true);
        //点击显示设置倍速播放选项
        setState(() {
          speedSettingShow = true;
        });
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        // ignore: sort_child_properties_last
        child: Text(
          "${widget.speed} x",
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            letterSpacing: 0.3, //字间距
          ),
        ),
        margin: EdgeInsets.only(left: 10, right: 10),
      ),
    );
  }

  //倍数播放设置控件
  Widget speedSetting() {
    List<Widget> widgets = [];
    for (int i = 0; i < speeds.length; i++) {
      widgets.add(
        InkWell(
          onTap: () {
            widget.speed = speeds[i];
            SpConstanst().setVideoSpeed(widget.speed ?? 0);
            player.setSpeed(widget.speed ?? 0);
            setState(() {
              speedSettingShow = false;
            });
            onTapFun(showCont: true);
          },
          child: Container(
            height: 30,
            width: 50,
            alignment: Alignment.center,
            child: Text(
              "${speeds[i]} x",
              style: TextStyle(
                fontSize: 14,
                color: widget.speed == speeds[i]
                    ? KColorConstant.themeColor
                    : Colors.white,
                letterSpacing: 0.3, //字间距
                fontWeight: widget.speed == speeds[i]
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        ),
      );
    }
    return Container(
      alignment: Alignment.bottomRight,
      height: widget.viewSize!.height - 50,
      margin: EdgeInsets.only(right: 45),
      child: Container(
        height: 125,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white30, width: 1.0),
          color: Colors.black87,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(children: widgets),
      ),
    );
  }

  //全屏按钮
  Widget buildFullScreenButton() {
    Icon icon = player.value.fullScreen
        ? Icon(Icons.fullscreen_exit)
        : Icon(Icons.fullscreen);
    return IconButton(
      padding: EdgeInsets.all(0),
      iconSize: 30,
      color: Color(0xFFFFFFFF),
      icon: icon,
      onPressed: () {
        _hideStuff = player.value.fullScreen;
        player.value.fullScreen
            ? player.exitFullScreen()
            : player.enterFullScreen();
      },
    );
  }

  @override
  void dispose() {
    /// 关闭监听
    player.removeListener(_playerValueChanged);

    /// 关闭流回调
    _currentPosSubs.cancel();
    super.dispose();
  }
}
