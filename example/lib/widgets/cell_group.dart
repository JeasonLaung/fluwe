import 'package:flutter/material.dart';
import './cell.dart';
class WeCellGroup extends StatelessWidget {
  final List<WeCell> children;
  final EdgeInsets margin;
  final int borderRadius;
  final String title;
  final List<BoxShadow> boxShadow;
  WeCellGroup({this.children = const [],this.margin,this.borderRadius,this.boxShadow, this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.symmetric(horizontal: 15.0,vertical: 15.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: borderRadius ?? 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            title != null 
            ? Container(
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 0, 10.0),
              child: Text(title, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
            )
            : Container(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: children
            ),
          ]
        ),
        decoration: BoxDecoration(
          boxShadow: boxShadow ?? [BoxShadow(color: Colors.black12, spreadRadius: 0.0, blurRadius: 10.0)],
          borderRadius: BorderRadius.circular(borderRadius ?? 20.0),
          color: Colors.white
        ),
      )
    );
  }
}