import 'dart:io';

import 'package:device_info/device_info.dart';
/**
 * 
 * APP的所有动态（异步）参数
 * 
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:package_info/package_info.dart';
import '../router/router.dart';
import '../options/options.dart';

class Fluwe {
  ///
  ///
  /// 手机视图布局参数
  ///
  ///
  /// 屏幕高宽
  static double screenHeight;
  static double screenWidth;

  /// 全局上下文
  static BuildContext context;

  /// 整个参数数据
  static MediaQueryData mediaQueryData;

  /// 状态拦高度
  static double statusBarHeight;

  /// 是否为loading状态
  static bool isLoading = false;

  static Future init({List<RouteOptions> routesConfig = const []}) async {
    /// 路由配置
    FluweRouter.configs = routesConfig;

    ///
    /// 路由信息
    ///
    /// 整个app的最重要的key，不要删除
    FluweRouter.navigatorKey = GlobalKey();

    ///
    ///
    /// 基本配置
    ///
    /// 强制竖屏
    // await SystemChrome.setPreferredOrientations(
    //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    // /// 清除状态栏背景色
    // SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //     statusBarBrightness: Brightness.light);
    // SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}
