
import 'package:flutter/material.dart';

class ModalWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final String content;
  final Function onConfirm;
  final Function onCancel;
  ModalWidget({this.child, this.content,this.title, this.onCancel,this.onConfirm});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 0.8,
            alignment: Alignment.center,
            child: child == null
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      title != null
                      ? Text('$title', style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0
                      ))
                      : Container(),
                      title != null && content != null  
                      ? SizedBox(height: 20.0,)
                      : Container(),
                      content != null
                      ? Text('$content', style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color(0xff666666),
                        fontWeight: FontWeight.normal,
                        fontSize: 13.0
                      ))
                      : Container()

                    ],
                  )
                )
              : child
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Material(
            child: Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20),
                    child: Text('取消'),
                  ),
                  onTap: onCancel,
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20),
                    child: Text('确定', style: TextStyle(color: Colors.green),),
                  ),
                  onTap: onConfirm,
                ),
              ),
            ],
          ))
          )
        ],
      ),
    );
  }
}