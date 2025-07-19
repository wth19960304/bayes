import 'package:bayes/constant/color.dart';
import 'package:bayes/constant/length.dart';
import 'package:bayes/constant/style.dart';
import 'package:bayes/utils/screen_util.dart';
import 'package:flutter/material.dart';

class BottomAppBarItemModal {
  final String iconData; // 默认状态图标路径
  final String iconSelectData; // 选中状态图标路径
  final String text; // 显示文本

  BottomAppBarItemModal(this.iconData, this.iconSelectData, this.text);
}

/// 底部导航栏单个可点击项目组件
class BottomAppBarItem extends StatelessWidget {
  final String iconData; // 当前显示的图标路径
  final String text; // 显示文本
  final Color? color; // 文本颜色（可为null）
  final ValueChanged<int> onTabSeleted; // 点击回调函数
  final int index; // 当前项目索引

  const BottomAppBarItem(
    this.iconData,
    this.text,
    this.color,
    this.onTabSeleted,
    this.index, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTabSeleted(index), // 点击时触发回调
      child: Container(
        color: KColorConstant.white, // 背景设为白色
        width: Klength.designWidth / 3, // 宽度为屏幕1/3
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 图标区域
            SizedBox(
              height: ScreenUtil.L(22),
              width: ScreenUtil.L(22),
              child: Image.asset(iconData), // 加载本地图片
            ),
            // 文本区域
            Container(
              margin: EdgeInsets.only(top: ScreenUtil.L(3)),
              child: Text(
                text,
                style: TextStyle(
                  color: color, // 动态颜色（选中/未选中）
                  fontSize: ScreenUtil.setSp(12, false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 底部导航栏主组件（Stateful）
class KKBottomAppBar extends StatefulWidget {
  final List<BottomAppBarItemModal>? items; // 导航项数据列表
  final ValueChanged<int>? onTabSeleted; // 切换回调
  final Color? actviveColor; // 选中状态颜色
  final Color? color; // 默认状态颜色

  const KKBottomAppBar({
    super.key,
    this.items,
    this.onTabSeleted,
    this.actviveColor,
    this.color,
  });

  @override
  BottomAppBarState createState() => BottomAppBarState();
}

/// 底部导航栏状态管理类
class BottomAppBarState extends State<KKBottomAppBar> {
  int currentIndex = 0; // 当前选中索引

  @override
  Widget build(BuildContext context) {
    int l = widget.items!.length;
    // 动态生成导航项组件列表
    List<BottomAppBarItem> listWidgets = List.generate(l, (index) {
      BottomAppBarItemModal i = widget.items![index];
      return BottomAppBarItem(
        // 根据选中状态切换图标
        index == currentIndex ? i.iconSelectData : i.iconData,
        i.text,
        // 根据选中状态切换颜色
        index == currentIndex ? widget.actviveColor : widget.color,
        onItemTap, // 点击回调
        index,
      );
    });

    return Container(
      height: ScreenUtil.L(50), // 固定高度
      decoration: KBoxStyle.bottomShadowBg(), // 底部阴影样式
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: listWidgets, // 水平排列所有导航项
      ),
    );
  }

  /// 处理导航项点击事件
  onItemTap(int i) {
    setState(() => currentIndex = i); // 更新选中状态
    widget.onTabSeleted!(i); // 触发外部回调
  }
}
