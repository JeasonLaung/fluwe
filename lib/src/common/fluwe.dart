import 'dart:io';

import 'package:device_info/device_info.dart';
/**
 * 
 * APP的所有动态（异步）参数
 * 
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../router/router.dart';
import '../options/options.dart';

class Fluwe {
  /// 静态配置
  static ConfigOptions config;
  

  /// 版本号
  static String version;
  /// 应用名称
  static String appName;
  /// 打包次数
  static String buildNumber;
  /// ativity名称
  static String packageName;

  ///
  ///
  /// 手机视图布局参数
  /// 
  /// 
  /// 屏幕高宽
  static double screenHeight;
  static double screenWidth;
  /// 整个参数数据
  static MediaQueryData mediaQueryData;
  /// 状态拦高度
  static double statusBarHeight;

  /// 
  /// 设备信息
  /// 对应的设备才可以返回数据否则null
  /// 
  static IosDeviceInfo iosInfo;
  static AndroidDeviceInfo androidInfo;
  /// 设备唯一标识
  static String deviceToken;


  /// 是否为loading状态
  static bool isLoading = false;


  ///
  /// 缓存
  ///
  static SharedPreferences cache;

  static Future init({@required List<RouteOptions> routesConfig, ConfigOptions fluweConfig}) async{
    Router.configs = routesConfig;
    config = fluweConfig ?? ConfigOptions();
    /// 
    /// 包信息
    /// 
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    /// 版本号
    version = packageInfo.version;
    /// 应用名称
    appName = packageInfo.appName;
    /// 打包次数
    buildNumber = packageInfo.buildNumber;
    /// ativity名称
    packageName = packageInfo.packageName;

    /// 
    /// 设备信息
    /// 
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      iosInfo = await deviceInfo.iosInfo;
      deviceToken = iosInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
      deviceToken = androidInfo.androidId;
    }


    ///
    /// 缓存初始化
    ///
    cache = await SharedPreferences.getInstance();
    


    
    /// 
    /// 路由信息
    /// 
    /// 整个app的最重要的key，不要删除
    Router.navigatorKey = GlobalKey();




    ///
    ///
    /// 基本配置
    ///
    /// 强制竖屏
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

    /// 清除状态栏背景色
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, 
      statusBarBrightness: Brightness.light
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}