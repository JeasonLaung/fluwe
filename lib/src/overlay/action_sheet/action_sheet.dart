import 'package:flutter/material.dart';
import 'package:fluwe/fluwe.dart';
import 'package:fluwe/src/common/fluwe.dart';
import 'package:fluwe/src/helpers/helpers.dart';

final double _leftPadding = 18.0;
final double _topPadding = 12.0;

enum ActionSheetType {
  success,
  fail,
}

class ActionSheetWidget extends StatefulWidget {
  final dynamic title;
  final bool maskClosable;
  final dynamic cancelButton;
  final Function() close;
  final Function() fail;
  final Function(int index) success;
  final List<ActionsheetItem> childer;

  ActionSheetWidget({
    key,
    this.title,
    this.maskClosable,
    this.cancelButton,
    this.close,
    this.success,
    this.fail,
    this.childer,
  }) : super(key: key);

  @override
  ActionSheetWidgetState createState() => ActionSheetWidgetState();
}

class ActionSheetWidgetState extends State<ActionSheetWidget>
    with TickerProviderStateMixin {
  final GlobalKey _boxKey = GlobalKey();
  // 容器高度
  double _boxHeight = 0;
  // 是否是取消
  int _index;
  // 动画
  AnimationController _controller;
  //高度动画
  Animation<double> top;
  // 高度
  Animation<double> opacity;
  // 主题
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback(getBoxHeight);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // 获取容器高度
  void getBoxHeight(Duration time) {
    _boxHeight = _boxKey.currentContext.size.width;
    createAnimate();
    startAnimate();
  }

  // 创建动画
  void createAnimate() {
    // 内容动画
    top = Tween<double>(begin: _boxHeight, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.decelerate,
      ),
    );
    // ..addStatusListener(animateEnd);

    // 遮罩层透明动画
    opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.decelerate));
  }

  // 开始动画
  void startAnimate() {
    _controller.forward();
  }

  // 动画结束
  // void animateEnd(state) {
  //   if (state == AnimationStatus.dismissed) {
  //     if (_index == null) {
  //       widget.close();
  //     } else {
  //       widget.success(_index);
  //     }
  //     // 销毁
  //     _controller.dispose();
  //   }
  // }

  // 取消
  void close({
    // 有效种类或者无效种类
    ActionSheetType type = ActionSheetType.fail,
  }) {
    if (type == ActionSheetType.success) {
      widget.success(_index);
    } else {
      widget.fail();
    }
    _index = null;
    _controller.reverse().then((value) {
      FluweRouter.navigateBack();
    });
  }

  // item click
  void itemClick(int index) {
    _index = index;
    // _controller.reverse();
    close(type: ActionSheetType.success);
  }

  // 渲染title
  Widget renderTitle() {
    return SizedBox(
      height: 50.0,
      child: Align(
        alignment: Alignment.center,
        child: DefaultTextStyle(
          style: TextStyle(
              color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.w500),
          child: toTextWidget(widget.title, 'title'),
        ),
      ),
    );
  }

  // 取消按钮
  Widget renderCancelButton() {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: close,
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: 6.0, color: Color(0xffEFEFF4)))),
          child: SizedBox(
            height: 55.0,
            child: Align(
              alignment: Alignment.center,
              child: DefaultTextStyle(
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                child: toTextWidget(widget.cancelButton, 'cancelButton'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // list
    final List<Widget> list = [];

    // 判断标题
    if (widget.title != null) {
      list.add(renderTitle());
      list.add(Divider(height: 1, color: Color(0xffd8d8d8)));
    } else {
      // list.add(SizedBox(
      //   height: px(10),
      // ));
    }

    // 选项
    list.addAll(initChilder(widget.childer, itemClick, Color(0xffd8d8d8)));

    // 取消按钮
    if (widget.cancelButton != null) {
      list.add(renderCancelButton());
    }

    return WillPopScope(
      onWillPop: () async {
        close();
        return false;
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          return Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(px(30)),
                      topRight: Radius.circular(px(30))),
                  child: Transform.translate(
                    offset: Offset(0, top == null ? 10000.0 : top.value),
                    child: DecoratedBox(
                      key: _boxKey,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Material(
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: list,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

// 字符串转Widget
Widget toTextWidget(content, key) {
  if (content == null) return null;
  // 判断是字符串或者是widget
  if (content is Widget == false && content is String == false) {
    throw new FormatException('$key类型只能为String || Widget');
  }

  if (content is String) {
    return Text(content);
  }

  return content;
}

List<Widget> initChilder(
    List<ActionsheetItem> childer, onChange, Color borderColor,
    {Alignment align = Alignment.center}) {
  // 列表
  final List<Widget> list = [];

  // 循环childer
  for (int index = 0; index < childer.length; index++) {
    // 边框
    if (index != 0) {
      list.add(Divider(height: 1, color: borderColor));
    }

    list.add(
      InkWell(
        onTap: () {
          onChange(index);
        },
        child: DecoratedBox(
          decoration: BoxDecoration(),
          child: Align(
            alignment: align,
            child: Container(
              alignment: Alignment.center,
              height: px(100),
              child: DefaultTextStyle(
                style: TextStyle(fontSize: px(30), color: Colors.black),
                child: toTextWidget(childer[index].label, 'childer中的值'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  return list;
}

class ActionsheetItem {
  final label;
  final dynamic value;

  ActionsheetItem({@required this.label, this.value});
}
