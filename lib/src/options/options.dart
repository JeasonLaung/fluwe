
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
  /// 签名名称（会存到cookie）
  final String signName;
  final int connectTimeout;
  final int receiveTimeout;
  ConfigOptions({
    this.baseUrl = '',
    this.connectTimeout = 10,
    this.designHeight = 1334,
    this.designWidth = 750,
    this.signName,
    this.keepAlive = false,
    this.receiveTimeout = 10});
}

/// 路由配置参数
class RouteOptions {
  final String url;
  final Widget Function(Map<String, dynamic> args) page;
  final bool Function(Map<String, dynamic> args) condition;
  RouteOptions({this.url, this.page, this.condition});
}

