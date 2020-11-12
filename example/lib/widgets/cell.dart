import 'package:flutter/material.dart';
import 'package:fluwe/fluwe.dart';

class WeCell extends StatelessWidget {
  /// 名称
  final String title;

  /// 前面的icon
  final Icon icon;

  /// 是否显示右边箭头
  final bool isLink;

  /// 图片级别高于icon
  final ImageProvider image;

  /// 右边箭头的左边
  final Widget footer;

  /// 跳转，会被ontap覆盖
  final Widget page;
  final String url;

  final Function onTap;
  final Function onTapCancel;
  final Function onLongPress;
  final Function onHover;
  final Function onDoubleTap;
  final Function onTapDown;
  WeCell(this.title,
      {this.url,
      this.page,
      this.icon,
      this.isLink = true,
      this.footer,
      this.image,
      this.onDoubleTap,
      this.onHover,
      this.onLongPress,
      this.onTap,
      this.onTapCancel,
      this.onTapDown});
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: InkWell(
          onTapCancel: onTapCancel,
          onDoubleTap: onDoubleTap,
          onTapDown: onTapDown,
          onHover: onHover,
          onLongPress: onLongPress,
          onTap: () {
            if (onTap != null) {
              return onTap();
            }
            if (page != null) {
              return Router.navigateTo(page: page, url: url);
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                /// 左边
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 10.0),
                      child: image != null
                          ? image
                          : (icon != null ? icon : Container()),
                    ),
                    Text(
                      title,
                      style: TextStyle(fontSize: 20.0, color: Colors.black87),
                    )
                  ],
                ),

                /// 右边
                Row(
                  children: <Widget>[
                    footer ?? Container(),
                    isLink ? Icon(Icons.keyboard_arrow_right) : Container()
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
