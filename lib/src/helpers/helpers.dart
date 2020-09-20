import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../overlay/loading/index.dart';
import '../common/fluwe.dart';

export '../overlay/overlay.dart';

/// 原生吐司函数
Future showToast(String msg,
    {Toast toastLength,
    int timeInSecForIos = 1,
    double fontSize = 16.0,
    ToastGravity gravity = ToastGravity.CENTER,
    Color backgroundColor,
    Color textColor}) async {
  Fluttertoast.cancel();
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      timeInSecForIos: timeInSecForIos,
      fontSize: fontSize,
      gravity: gravity,
      backgroundColor: backgroundColor,
      textColor: textColor);
}

/// 关闭原生吐司函数
Future closeToast() async {
  return await Fluttertoast.cancel();
}

///
/// 打印
///
// final Logger _log = Logger();
// Logger get console => _log;

///
/// 拨打电话
///
Future makePhoneCall({@required phoneNumber}) async {
  openBrower(url: 'tel:$phoneNumber');
}

///
/// 发短信
///
Future sendMessage({@required phoneNumber}) async {
  openBrower(url: 'sms:' + phoneNumber);
}

///
/// 发短信
///
Future sendMail({@required email, String body = ''}) async {
  openBrower(url: 'mailto:' + email + '?subject=' + body);
}

///
/// 选择图片
///
enum ChooseImageType { camera, photo }
bool chooseImageBlock = false;
Future<File> chooseImage(
    {ChooseImageType type = ChooseImageType.photo,

    /// 是否压缩
    bool compress = false}) async {
  if (chooseImageBlock == true) {
    throw '不能同时打开两次选择文件';
  }
  chooseImageBlock = true;
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
  chooseImageBlock = false;
  if (file == null) {
    throw '没有选图片';
  } else {
    if (compress) {
      file = await compressImage(file, output: CompressOutputType.file);
    }
    return file;
  }
  // });
}

enum OpenAppType { weixin, alipays }

///
/// 调起其他应用
///

Future openApp({@required OpenAppType appName}) async {
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
Future<bool> openBrower({@required url}) async {
  if (await canLaunch(url.toString())) {
    await launch(url.toString());
    return true;
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
/// 颜色转换
///
Color col(String c) {
  return Color(int.parse(c, radix: 16) | 0xFF000000);
}

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
Future share(String text, {String subject, Rect sharePositonOrigin}) async {
  return await Share.share(text,
      subject: subject, sharePositionOrigin: sharePositonOrigin);
}

///
/// 缓存
///
SharedPreferences cache = Fluwe.cache;

///
/// APP权限调起
///
// Future<bool> openSetting() async{
//   return await PermissionHandler().openAppSettings();
// }

///
/// 处理权限(保证打开状态)
///
// Future<bool> requestPermission(permission, {Function fail}) async{
//   PermissionHandler permissionHandler = PermissionHandler();
//   PermissionStatus status;
//   Map<PermissionGroup, PermissionStatus> statuss = {};
//   if (permission is PermissionGroup) {
//     /// 检测授权
//     status = await permissionHandler.checkPermissionStatus(permission);

//     print(status);
//     /// denied（苹果已经授权的话会直接返回这个denied）   granted为（ios第一次授权成功 或 安卓授权打开状态返回）
//     if (status == PermissionStatus.denied || status == PermissionStatus.granted) {
//       return true;
//     } else {
//       statuss = await permissionHandler.requestPermissions([permission]);
//       /// 第一次授权
//       if (statuss[permission] == PermissionStatus.granted) {
//         return true;
//       } else {
//         if (fail is Function) {
//           fail();
//         }
//         throw false;
//       }
//     }
//   } else if(permission is List<PermissionGroup>) {
//     List<PermissionGroup> notPermissions = [];
//     print(permission);
//     permission.map((item) async{
//       status = await permissionHandler.checkPermissionStatus(item);
//       print(status);
//       /// denied（苹果已经授权的话会直接返回这个denied）   granted为（ios第一次授权成功 或 安卓授权打开状态返回）
//       if (status == PermissionStatus.denied || status == PermissionStatus.granted) {
//       } else {
//         notPermissions.add(item);
//       }
//     });
//     print(notPermissions);

//     statuss = await permissionHandler.requestPermissions(notPermissions);
//     statuss.map((key, val) {
//       if (val == PermissionStatus.granted) {
//       } else {
//         if (fail is Function) {
//           fail();
//         }
//         throw false;
//       }
//     });
//     return true;
//   }
//   throw false;
// }

enum CompressOutputType {
  /// 二进制文件,（返回）
  uint8List,

  /// 文件
  file
}

///
/// 压缩图片
/// 相关连接 [https://pub.flutter-io.cn/packages/flutter_image_compress]
///
/// 1.二进制图片显示
/// ```
/// Image.memory(Uint8List bytes)
/// ```
/// 2.本地图片显示
/// ```
///Image.file(File file)
/// ```
/// 3.网络图片显示
/// ```
///Image.network(String path)
/// ```
Future compressImage(File file,
    {

    /// 输出类型
    CompressOutputType output = CompressOutputType.uint8List,

    /// 压缩质量
    int quality = 70,

    /// 最小高度
    int minHeight = 1080,

    /// 最小宽度
    int minWidth = 1920,

    /// 转角
    int rotate = 0,
    CompressFormat format = CompressFormat.jpeg}) async {
  showLoading(canBack: false);
  var result;
  switch (output) {
    case CompressOutputType.uint8List:
      result = await FlutterImageCompress.compressWithFile(file.absolute.path,
          minWidth: minWidth,
          minHeight: minHeight,
          quality: quality,
          rotate: rotate,
          format: format);
      result = Uint8List.fromList(result);
      break;
    default:
      String ext = file.absolute.path.split('.').last;

      /// 应用自身空间
      Directory dir = await getApplicationDocumentsDirectory();

      /// 保存地址
      String savePath =
          '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.$ext';
      result = await FlutterImageCompress.compressAndGetFile(
          file.absolute.path, savePath,
          minWidth: minWidth,
          minHeight: minHeight,
          quality: quality,
          rotate: rotate,
          format: format);
      break;
  }
  closeLoading();
  return result;
}

// 获取存储路径
Future<String> _findLocalPath() async {
  // 因为Apple没有外置存储，所以第一步我们需要先对所在平台进行判断
  // 如果是android，使用getExternalStorageDirectory
  // 如果是iOS，使用getApplicationSupportDirectory
  final directory = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationSupportDirectory();
  return directory.path;
}

// // 下载申请权限
// Future<bool> _downloadCheckPermission() async {
//   // 先对所在平台进行判断
//   if (Platform.isAndroid) {
//     PermissionStatus permission = await PermissionHandler()
//         .checkPermissionStatus(PermissionGroup.storage);
//     if (permission != PermissionStatus.granted) {
//       Map<PermissionGroup, PermissionStatus> permissions =
//           await PermissionHandler()
//               .requestPermissions([PermissionGroup.storage]);
//       if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
//         return true;
//       }
//     } else {
//       return true;
//     }
//   } else {
//     return true;
//   }
//   return false;
// }

// /// 下载文件
// ///
// Future<String> downloadFile({
//   @required String url,
//   Function success,
//   Function fail,
//   Map<String, String> headers = const {},
//   String savePath}) async{

//   if(await _downloadCheckPermission()) {
//     String path = savePath ?? cache.getString('SAVE_PATH');
//     if (empty(path)) {
//       path = await _findLocalPath();
//     }
//     final _taskId = await FlutterDownloader.enqueue(
//       url: url,
//       headers: headers,
//       savedDir: path,
//       showNotification: true, // show download progress in status bar (for Android)
//       openFileFromNotification: true, // click on notification to open downloaded file (for Android)
//     );

//     // _registerCallback(String taskId, DownloadTaskStatus status, int progress) {
//     //   if (taskId == _taskId) {
//     //     if (status == DownloadTaskStatus.complete) {
//     //       if (success is Function) {
//     //         success();
//     //       }
//     //     } else if(status == DownloadTaskStatus.canceled || status == DownloadTaskStatus.failed || status == DownloadTaskStatus.undefined){
//     //       if (fail is Function) {
//     //         fail();
//     //       }
//     //     }
//     //   }
//     // }
//     // FlutterDownloader.registerCallback(_registerCallback);

//     return _taskId;
//   } else {
//     throw '文件读写权限没获取';
//   }
// }

// ///
// /// 取消下载
// ///
// Future<bool> cancelDownload({String taskId, bool all: false}) async{
//   if (all) {
//     await FlutterDownloader.cancelAll();
//     return true;
//   } else {
//     await FlutterDownloader.cancel(taskId:taskId);
//     return true;
//   }
// }

///
/// 缓存图片
///
CachedNetworkImage cacheImage(url, {BoxFit fit, Alignment alignment}) {
  return CachedNetworkImage(
    imageUrl: url,
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            alignment: alignment ?? Alignment.center,
            image: imageProvider,
            fit: fit ?? BoxFit.cover,
            colorFilter:
                ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)),
      ),
    ),
    placeholder: (context, url) => CircularProgressIndicator(),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}

/// 可通过sql搜索下载列表历史
/// ```
/// CREATE TABLE `task` (
/// 	`id`	INTEGER PRIMARY KEY AUTOINCREMENT,
/// 	`task_id`	VARCHAR ( 256 ),
/// 	`url`	TEXT,
/// 	`status`	INTEGER DEFAULT 0,
/// 	`progress`	INTEGER DEFAULT 0,
/// 	`file_name`	TEXT,
/// 	`saved_dir`	TEXT,
/// 	`resumable`	TINYINT DEFAULT 0,
/// 	`headers`	TEXT,
/// 	`show_notification`	TINYINT DEFAULT 0,
/// 	`open_file_from_notification`	TINYINT DEFAULT 0,
/// 	`time_created`	INTEGER DEFAULT 0
/// );
/// ```

// Future<List<DownloadTask>> getDownloadFileList({String query}) {
//   if (query is String) {
//     return FlutterDownloader.loadTasksWithRawQuery(query: query);
//   }
//   return FlutterDownloader.loadTasks();
// }

/// 空
bool empty(obj) {
  if (obj == null || obj == false || obj == '') {
    return true;
  }
  if (obj is List && obj.length == 0) {
    return true;
  }
  if (obj is Map && obj.keys.length == 0) {
    return true;
  }
  return false;
}
