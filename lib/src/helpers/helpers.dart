import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluwe/src/common/fluwe.dart';
import 'package:image_picker/image_picker.dart';
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
  return await Fluttertoast.showToast(
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
    default:
      source = ImageSource.camera;
  }
  File file = await ImagePicker.pickImage(source: source);
  if (file == null) {
    throw '没有选图片';
  } else {
    return file;
  }
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
