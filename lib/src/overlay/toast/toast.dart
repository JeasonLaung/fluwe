
import 'package:flutter/material.dart';

class ToastWidget extends StatelessWidget {
  final String title;
  ToastWidget(this.title);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.7,
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0x99333333),
                borderRadius: BorderRadius.circular(5)
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(title, style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ),
      ));
  }
}