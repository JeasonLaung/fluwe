import 'package:flutter/material.dart';

enum ToastPosition {
  top,
  bottom,
  center,
}

class ToastWidget extends StatelessWidget {
  final String title;
  final ToastPosition position;
  ToastWidget(this.title, {this.position = ToastPosition.bottom});
  @override
  Widget build(BuildContext context) {
    double topHeight = 0;
    switch (position) {
      case ToastPosition.bottom:
        topHeight = MediaQuery.of(context).size.height * 0.7;
        break;
      case ToastPosition.center:
        topHeight = MediaQuery.of(context).size.height * 0.5;
        break;
      case ToastPosition.top:
        topHeight = MediaQuery.of(context).size.height * 0.3;
        break;
      default:
        topHeight = MediaQuery.of(context).size.height * 0.7;
        break;
    }
    return Positioned(
      top: topHeight,
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xcc333333),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(title, style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
