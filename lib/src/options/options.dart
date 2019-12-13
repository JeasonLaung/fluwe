
import 'package:flutter/material.dart';

class ConfigOptions {
  /// 是否开启保活机制
  final bool keepAlive;

  /// 设计宽高
  final double designHeight;
  final double designWidth;
  

  /// 请求
  /// 域名
  final String baseUrl;
  final int connectTimeout;
  final int receiveTimeout;
  ConfigOptions({
    this.baseUrl = '',
    this.connectTimeout = 10,
    this.designHeight = 1334,
    this.designWidth = 750,
    this.keepAlive = false,
    this.receiveTimeout = 10});
}

/// 路由配置参数
class RouteOptions {
  final String url;
  final Widget Function(Map<String, dynamic> args) page;
  RouteOptions({this.url, this.page});
}

