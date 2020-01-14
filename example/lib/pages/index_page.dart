import 'package:flutter/material.dart';
import 'package:fluwe/fluwe.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('fluwe'),
      ),
      body: Container(
        width: rpx(750),
        color: Colors.black38,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('123'),
              onPressed: () {
                showModal();
              },
            )
          ],
        )
      )
    );
  }
}

class ModalWidget extends StatelessWidget {
  final String title;
  final String content;
  final Function onConfirm;
  final Function onCancel;
  final Widget child;
  const ModalWidget({this.child, this.content = '', this.title = '提示', this.onConfirm, this.onCancel});


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(rpx(13)),
      child: Container(
          width: rpx(670),
          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(),
            borderRadius: BorderRadius.circular(rpx(13))
          ),
          child: Column(
            children: [
              SizedBox(height: rpx(67),),

              Container(
                padding: EdgeInsets.symmetric(horizontal: rpx(50)),
                child: Text(title, style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: rpx(37)
                )),
              ),
              
              SizedBox(height: rpx(40),),

              child != null
              ? child
              :(content != '' 
                ? Container(
                  padding: EdgeInsets.symmetric(horizontal: rpx(50)),
                  child: Text(content, style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: rpx(37),
                    color: Color(0xff808080)
                  ))
                )
                : Container()),



              SizedBox(height: rpx(67),),


              buildButtons()
              // RaisedButton(
              //   child: Text(title),
              //   onPressed: () {
              //     showModal();
              //   },
              // ),
          ]
        ),
      ),
    );
  }


  Widget buildButtons() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Material(
            color: Colors.white,
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: rpx(1),
                      color: Color(0xffe5e5e5)
                    ),
                    right: BorderSide(
                      width: rpx(1),
                      color: Color(0xffe5e5e5)
                    ),
                  )
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                child: Text('取消', style: TextStyle(
                  fontSize: rpx(37),
                  fontWeight: FontWeight.bold
                ),),
              ),
              onTap: () {
                if (onCancel is Function) {
                  return onCancel();
                }
              },
            ),
          )
        ),
        Expanded(
          child: Material(
            color: Colors.white,
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: rpx(1),
                      color: Color(0xffe5e5e5)
                    )
                  )
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                child: Text('确定', style: TextStyle(
                  color: Color(0xff576c94),
                  fontSize: rpx(37),
                  fontWeight: FontWeight.bold
                ),),
              ),
              onTap: () {
                if (onCancel is Function) {
                  return onCancel();
                }
              },
            )
          ),
        ),
      ],
    );
  }
}