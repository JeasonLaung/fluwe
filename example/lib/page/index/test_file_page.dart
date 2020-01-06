
import 'package:flutter/material.dart';
import 'package:fluwe/fluwe.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';
import '../../widgets/widgets.dart';

/// 文件操作页面
class TestFilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('文件操作页面'),),
      body: WeCellGroup(
        children: <WeCell>[
          WeCell('选择图片（【官方】只能单选）',
            onTap: () {
              chooseImage().then((file) {
                showModal(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    child: Column(
                      children: <Widget>[
                        Image(image: FileImage(file),height: 100.0, width: 100.0, fit: BoxFit.fitHeight,),
                        Text('你选择了文件${file.path}', style: TextStyle(color: Color(0xff666666),decoration: TextDecoration.none, fontSize: 13.0),)
                      ],
                    ),
                  )
                );
              });
          }),


          WeCell('拍摄图片',
            onTap: () {
              chooseImage(type: ChooseImageType.camera).then((file) {
                showModal(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    child: Column(
                      children: <Widget>[
                        Image(image: FileImage(file),height: 100.0, width: 100.0, fit: BoxFit.fitHeight,),
                        Text('你选择了文件${file.path}', style: TextStyle(color: Color(0xff666666),decoration: TextDecoration.none, fontSize: 13.0),)
                      ],
                    ),
                  )
                );
              });
          }),

          WeCell('打开设置',
            onTap: () {
              openSetting();
          }),

          WeCell('打开设置',
            onTap: () {
          }),
        ],
      ),
    );
  }
}