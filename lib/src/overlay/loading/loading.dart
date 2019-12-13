
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String msg;
  LoadingWidget({this.msg});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        height: 120,
        width: 120,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 25.0,),
            Text('${msg ?? '正在加载'}', style: TextStyle(
              decoration: TextDecoration.none,
              color: Color(0xff333333),
              fontWeight: FontWeight.normal,
              fontSize: 15.0
            ),),
          ],
        )
      ),
    );
  }
}