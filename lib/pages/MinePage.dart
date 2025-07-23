import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

///个人中心
class MinePage extends BaseInnerWidget {
  @override
  int setIndex() {
    return 2;
  }

  @override
  BaseInnerWidgetState<BaseInnerWidget> getState() {
    return _MinePageState();
  }
}

class _MinePageState extends BaseInnerWidgetState<MinePage> {
  TextEditingController userController = TextEditingController();

  @override
  Widget buildWidget(BuildContext context) {
    if (data == null) {
      return baseStatueWidget(LoadingWidgetStatue.LOADING);
    }
    String userInfo = "";
    if (data.grade != "") {
      userInfo += "${data.grade} | ";
    }
    if (data.division != "") {
      userInfo += "${data.division} | ";
    }
    if (data.position != "") {
      userInfo += "${data.position}";
    }
    return Container(
      color: KColorConstant.white,
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _headerWidget(),
                Container(
                  margin: EdgeInsets.all(ScreenUtil().L(10)),
                  child: Text(
                    "${data.nickname}",
                    style: KFontConstant.appBarTiltleBig_bold(),
                  ),
                ),
                Text("$userInfo", style: KFontConstant.greyTextBig()),
                Padding(
                  padding: EdgeInsets.only(
                    left: ScreenUtil().L(50),
                    right: ScreenUtil().L(50),
                    top: ScreenUtil().L(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _topWidget(0),
                      _topWidget(1),
                      _topWidget(2),
                    ],
                  ),
                ),
                _buttom(),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                _routePage(98);
              },
              child: Padding(
                padding: EdgeInsets.all(ScreenUtil().L(10)),
                child: Image.asset(
                  "images/message_icon.png",
                  width: ScreenUtil().L(25),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //学习记录
  _topWidget(int index) {
    List<String> title = new List();
    title.add("学习记录");
    title.add("练习记录");
    title.add("我的缓存");
    List<String> images = new List();
    images.add("images/minekuang1.png");
    images.add("images/minekuang2.png");
    images.add("images/minekuang3.png");
    List<String> nums = List();
    nums.add("${data.studyNum}");
    nums.add("${data.testNum}");
    nums.add("${pathNum}");
    return InkWell(
      onTap: () {
        _routePage(100 + index);
      },
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: Image.asset(
                "${images[index]}",
                height: ScreenUtil().L(70),
              ),
            ),
            Container(
              height: ScreenUtil().L(65),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(ScreenUtil().L(5)),
                    child: Text(
                      "${nums[index]}",
                      style: KFontConstant.appBarTiltleBig_bold(),
                    ),
                  ),
                  Text("${title[index]}", style: KFontConstant.grayText()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //头像
  _headerWidget() {
    return InkWell(
      onTap: () {
        _routePage(99);
      },
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().L(30)),
            alignment: Alignment.topCenter,
            child: Image.asset(
              "images/headerbg.png",
              height: ScreenUtil().L(90),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().L(30)),
            alignment: Alignment.center,
            height: ScreenUtil().L(90),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(ScreenUtil().L(50)),
              ),
              child: CachedNetworkImage(
                imageUrl:
                    "${data.headImg == null || data.headImg.length == 0 ? "" : data.headImg[0].url}",
                placeholder: (context, url) => ImageLoadingPage(width: 20.0),
                errorWidget: (context, url, error) => Image.asset(
                  "images/header_defalut.png",
                  fit: BoxFit.cover,
                  width: ScreenUtil().L(90),
                  height: ScreenUtil().L(90),
                ),
                fit: BoxFit.cover,
                width: ScreenUtil().L(90),
                height: ScreenUtil().L(90),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //底部布局
  _buttom() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().L(20)),
      padding: EdgeInsets.only(
        left: ScreenUtil().L(10),
        bottom: ScreenUtil().L(50),
        top: ScreenUtil().L(10),
      ),
      color: KColorConstant.appBgColor,
      child: Column(
        children: <Widget>[
          _rowItemView("学习成就", "images/mine_huiyuan.png", 0),
          _rowItemView("收藏", "images/mine_shoucang.png", 2),
          _rowItemView("推荐给好友", "images/mine_fenxiang.png", 3),
          _rowItemView("检查新版本", "images/mine_jianche.png", 4),
          _rowItemView("关于我们", "images/mine_guanyu.png", 5),
          _rowItemView("退出登录", "images/mine_jianche.png", 6),
          _rowItemView("账户注销", "images/mine_huiyuan.png", 1),
          Container(
            color: Colors.transparent,
            margin: EdgeInsets.only(top: ScreenUtil().L(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new MeInfoPage(),
                      ),
                    );
                  },
                  child: Text("《用户协议》", style: KFontConstant.themeText()),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (context) => TextPage()));
                  },
                  child: Text("《隐私政策》", style: KFontConstant.themeText()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //底部单个布局
  Widget _rowItemView(
    String title,
    String imageUrl,
    int index, {
    double paddingH = 14,
  }) {
    return InkWell(
      onTap: () {
        _routePage(index);
      },
      child: Container(
        height: ScreenUtil().L(52),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: ScreenUtil().L(50),
                  width: ScreenUtil().L(50),
                  padding: EdgeInsets.only(
                    left: ScreenUtil().L(12),
                    right: ScreenUtil().L(12),
                    top: ScreenUtil().L(paddingH),
                    bottom: ScreenUtil().L(paddingH),
                  ),
                  child: Image.asset(imageUrl),
                ),
                Text(title, style: KFontConstant.defaultText()),
              ],
            ),
            Container(
              height: ScreenUtil().L(56),
              width: ScreenUtil().L(56),
              padding: EdgeInsets.all(ScreenUtil().L(20)),
              child: Image.asset("images/right_go.png"),
            ),
          ],
        ),
      ),
    );
  }

  ///界面跳转
  _routePage(int index, {int type}) {
    //学习成就
    if (index == 0) {
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new ChengjiuPage()),
      );
    }
    if (index == 1) {
      showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('账户注销'),
            content: new SingleChildScrollView(
              child: new Text('您确定要申请注销该账户吗？账户注销后，该账号将不可登录本APP，并清除您之前的账户数据。'),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('确定'),
                onPressed: () {
                  showToast("您的账号注销已提交，等待后台处理。");
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      ).then((val) {
        print(val);
      });
    } else if (index == 2) {
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new ShouCangPage()),
      );
    } else if (index == 3) {
      showShareDialog(title: "贝叶斯数学，内容全免费哟，快来下载和我一起学习吧！", type: "app");
    } else if (index == 4) {
      showToast("已是最新版本");
    } else if (index == 5) {
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new MeInfoPage()),
      );
    } else if (index == 6) {
      showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('退出登录'),
            content: new SingleChildScrollView(child: new Text('您确定退出该账号吗？')),
            actions: <Widget>[
              new FlatButton(
                child: new Text('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('确定'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new LoginPage(),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ).then((val) {
        print(val);
      });
    } else if (index == 98) {
      //消息中心
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new MyMessagePage()),
      );
    } else if (index == 99) {
      //头像 - 个人中心
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new FirstUserInfoPage()),
      );
    } else if (index == 100) {
      //学习记录
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new XuexiJiluPage()),
      );
    } else if (index == 101) {
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new ShitiListPage()),
      );
    } else if (index == 102) {
      //缓存列表
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new XiazaiPage()),
      );
    }
  }

  @override
  void onCreate() {
    setAppBarVisible(false);
    _initFluQQ();
    _initFluwx();
  }

  _initFluwx() async {
    await fluwx.registerWxApi(
      appId: "wxa4a5f5d0d85630a2",
      doOnAndroid: true,
      doOnIOS: true,
    );
  }

  _initFluQQ() async {
    FlutterQq.registerQQ('101887594');
  }

  @override
  void onPause() {}

  @override
  void onResume() {
    _getData();
    _getUserInfo();
    _checkPersmission();
  }

  void _checkPersmission() async {
    bool hasPermission = await Permission.storage.request().isGranted;
    if (!hasPermission) {
      showToast("您拒绝了我们获取储存权限，请前往[设置-应用管理-权限获取]打开权限");
      return;
    }
  }

  @override
  double getVerticalMargin() {
    return ScreenUtil().L(50) + //bar栏高度
        ScreenUtil.statusBarHeight + //状态栏高度
        ScreenUtil.bottomBarHeight;
  }

  UserInfoData data;

  int first = 0;

  ///获取用户信息
  _getUserInfo() {
    var formData = {"page": "1"};
    RequestMap.getUserInfo(
      ShowLoadingIntercept(this, isInit: true),
      formData,
    ).listen(
      (data) {
        setState(() {
          this.data = data.data;
          if (this.data.position == "") {
            //完善个人信息
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new FirstUserInfoPage(),
              ),
            );
          }
        });
      },
      onError: (err) {
        showToast(err.message);
      },
    );
  }

  String sDCardDir;

  int pathNum = 0;

  _getData() async {
    // 打印出test文件夹下文件的路径
    sDCardDir = (await getExternalStorageDirectory()).path;
    Directory directory = new Directory('$sDCardDir/videoBys');

    pathNum = directory.listSync().length;
  }
}
