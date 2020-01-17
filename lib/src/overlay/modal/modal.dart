
import 'package:flutter/material.dart';
import 'package:fluwe/src/helpers/helpers.dart';

class ModalWidget extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final Function onConfirm;
  final Function onCancel;
  final Widget child;
  const ModalWidget({
    this.child, 
    this.content = '', 
    this.title = '提示', 
    this.onConfirm, 
    this.onCancel,
    this.cancelText = '取消',
    this.confirmText = '确定'
  });


  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(rpx(13)),
        child: Container(
            width: rpx(670),
            decoration: BoxDecoration(
              color: Colors.white,
              // border: Border.all(),
              borderRadius: BorderRadius.circular(rpx(13))
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                  ? LimitedBox(
                    maxHeight: vh(60),
                    child: Container(
                      decoration: BoxDecoration(
                      ),
                      padding: EdgeInsets.symmetric(horizontal: rpx(50)),
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          child:  Text(content, style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: rpx(37),
                            color: Color(0xff808080)
                          ))
                        )
                      )
                    )
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
      )
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
                child: Text(cancelText, style: TextStyle(
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
                child: Text(confirmText, style: TextStyle(
                  color: Color(0xff576c94),
                  fontSize: rpx(37),
                  fontWeight: FontWeight.bold
                ),),
              ),
              onTap: () {
                if (onConfirm is Function) {
                  return onConfirm();
                }
              },
            )
          ),
        ),
      ],
    );
  }
}