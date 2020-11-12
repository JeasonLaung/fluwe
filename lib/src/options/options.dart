import 'package:flutter/material.dart';

class ConfigOptions {
  /// 设计宽高
  final double designHeight;
  final double designWidth;

  ConfigOptions({
    this.designHeight = 1334,
    this.designWidth = 750,
  });
}

/// 路由配置参数
class RouteOptions {
  final String url;
  final Widget Function(Map<String, dynamic> args) page;
  final bool Function(Map<String, dynamic> args) condition;
  RouteOptions({this.url, this.page, this.condition});
}
