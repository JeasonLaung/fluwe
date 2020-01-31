
import 'dart:typed_data';

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
          WeCell('打开设置',
            onTap: () {
              openSetting();
          }),

          WeCell('选择图片（官方）',
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


          WeCell('拍摄图片（官方）',
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

          

          WeCell('选择图片 + 压缩图片',
            onTap: () {
              chooseImage(compress: true).then((file) async{
                 showModal(
                  child: Column(
                    children: [
                      Text('压缩后大小：${file.length}节字'),
                      Image.file(file),
                    ]
                  ),
                  onCancel: () async{},
                  onConfirm: () async{
                  }
                );
              });
              // 生成二进制不保存
              // chooseImage().then((file) async{
              //   Uint8List res = await compressImage(file);
              //   showModal(
              //     child: Column(
              //       children: [
              //         Text('原大小：${await file.length()}节字'),
              //         Text('现大小：${res.length}节字'),
              //         Image.memory(res),
              //       ]
              //     ),
              //     onCancel: () async{},
              //     onConfirm: () async{
              //     }
              //   );
              // });
          }),
          WeCell('拍摄图片 + 压缩图片',
            onTap: () {
              // 生成二进制不保存
              chooseImage(type: ChooseImageType.camera).then((file) async{
                Uint8List res = await compressImage(file);
                showModal(
                  child: Column(
                    children: [
                      Text('原大小：${await file.length()}节字'),
                      Text('现大小：${res.length}节字'),
                      Image.memory(res),
                    ]
                  ),
                  onCancel: () async{},
                  onConfirm: () async{
                  }
                );
              });
          }),

          // WeCell('下载文件',
          //   onTap: () {
          //     // 生成二进制不保存
          //     downloadFile(
          //       url: 'https://v2test.mputao.com/download/app-release.apk'
          //     );
          // }),

          // WeCell('取消所有下载',
          //   onTap: () {
          //     // 生成二进制不保存
          //     cancelDownload(
          //       all: true
          //     );
          // }),
          
          // WeCell('下载历史',
          //   onTap: () {
          //     getDownloadFileList().then((res) {
          //       showModal(content: res.toString());
          //     });
          //   },
          // )
        ],
      ),
    );
  }
}