import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluwe/src/common/fluwe.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

export '../overlay/overlay.dart';

/// 原生吐司函数
Future showToast(
  String msg, 
  {
    Toast toastLength, 
    int timeInSecForIos = 1, 
    double fontSize = 16.0, 
    ToastGravity gravity, 
    Color backgroundColor, 
    Color textColor}
  ) async{
  Fluttertoast.cancel();
  return Fluttertoast.showToast(
    msg:msg, 
    toastLength: toastLength, 
    timeInSecForIos: timeInSecForIos, 
    fontSize:fontSize, 
    gravity: gravity, 
    backgroundColor: backgroundColor, 
    textColor: textColor
  );
}

/// 关闭原生吐司函数
Future closeToast() async{
  return await Fluttertoast.cancel();
}




///
/// 拨打电话
///
Future makePhoneCall({@required phoneNumber}) async{
  openBrower(url: 'tel:$phoneNumber');
}


///
/// 发短信
///
Future sendMessage({@required phoneNumber}) async{
  openBrower(url: 'sms:' + phoneNumber);
}

///
/// 发短信
///
Future sendMail({@required email, String body = ''}) async{
  openBrower(url: 'mailto:' + email + '?subject=' + body);
}


///
/// 选择图片
///
enum ChooseImageType{
  camera,
  photo
}
Future chooseImage({ChooseImageType type: ChooseImageType.photo}) async{
  ImageSource source;
  switch (type) {
    case ChooseImageType.photo:
      source = ImageSource.gallery;
      break;
    case ChooseImageType.camera:
      source = ImageSource.camera;
      break;
    default:
      throw '获取种类不在ChooseImageType中';
  }
  // await requestPermission(PermissionGroup.photos).then((data) async{

    File file = await ImagePicker.pickImage(source: source);
    if (file == null) {
      throw '没有选图片';
    } else {
      return file;
    }
  // });
}

enum OpenAppType {
  weixin,
  alipays
}

/// 
/// 调起其他应用
/// 

Future openApp({@required OpenAppType appName}) async{
  String url;
  switch (appName) {
    case OpenAppType.alipays:
      url = 'alipays://';
      break;
    case OpenAppType.weixin:
      url = 'weixin://';
      break;
    default:
      return;
  }
  openBrower(url: url);
}


///
/// 打开外部网址
///
Future openBrower({@required url}) async{
  if (await canLaunch(url.toString())) {
    await launch(url.toString());
  } else {
    throw 'Could not launch $url.toString()';
  }
}


// ///
// /// 用户操作
// ///
// showActionSheet() {

// }

///
/// 快捷px 以设置为准
///
double px(double px) {
  return Fluwe.mediaQueryData.size.width / 750 * px;
}

///
/// h5相关的的高度百分比
///
double vh(double vh) {
  return vh * Fluwe.mediaQueryData.size.height / 100;
}
///
/// h5相关的的宽度百分比
///
double vw(double vw) {
  return vw * Fluwe.mediaQueryData.size.width / 100;
}

/// 
/// rpx 微信统一api
/// 
double rpx(double px) {
  return Fluwe.mediaQueryData.size.width / 750.0 * px;
}


///
/// 原生分享
///
Future share(String text, {String subject, Rect sharePositonOrigin}) async{
  return await Share.share(text, subject: subject, sharePositionOrigin: sharePositonOrigin);
}


///
/// 缓存
///
SharedPreferences cache = Fluwe.cache;



///
/// APP权限调起
///
Future<bool> openSetting() async{
  return await PermissionHandler().openAppSettings();
}

///
/// 处理权限(保证打开状态)
///
Future<bool> requestPermission(permission, {Function fail}) async{
  PermissionHandler permissionHandler = PermissionHandler();
  PermissionStatus status;
  Map<PermissionGroup, PermissionStatus> statuss = {};
  if (permission is PermissionGroup) {
    /// 检测授权
    status = await permissionHandler.checkPermissionStatus(permission);

    print(status);
    /// denied（苹果已经授权的话会直接返回这个denied）   granted为（ios第一次授权成功 或 安卓授权打开状态返回）
    if (status == PermissionStatus.denied || status == PermissionStatus.granted) {
      return true;
    } else {
      statuss = await permissionHandler.requestPermissions([permission]);
      /// 第一次授权
      if (statuss[permission] == PermissionStatus.granted) {
        return true;
      } else {
        if (fail is Function) {
          fail();
        }
        throw false;
      }
    }
  } else if(permission is List<PermissionGroup>) {
    List<PermissionGroup> notPermissions = [];
    print(permission);
    permission.map((item) async{
      status = await permissionHandler.checkPermissionStatus(item);
      print(status);
      /// denied（苹果已经授权的话会直接返回这个denied）   granted为（ios第一次授权成功 或 安卓授权打开状态返回）
      if (status == PermissionStatus.denied || status == PermissionStatus.granted) {
      } else {
        notPermissions.add(item);
      }
    });
    print(notPermissions);

    statuss = await permissionHandler.requestPermissions(notPermissions);
    statuss.map((key, val) {
      if (val == PermissionStatus.granted) {
      } else {
        if (fail is Function) {
          fail();
        }
        throw false;
      }
    });
    return true;
  }
  throw false;
}


// ///
// /// 压缩图片
// ///
// Future compressImage(File file) async{
//   var result = await FlutterImageCompress.compressWithFile(
//     file.absolute.path,
//     minWidth: 1024,
//     minHeight: 1024,
//     quality: 70,
//   );
//   print(file.lengthSync());
//   print(result.length);
//   return result;
// }