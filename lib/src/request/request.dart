
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../helpers/helpers.dart';

import '../common/fluwe.dart';


enum RequestType {
  get,
  post,
  put,
  delete
}
/// -----------------------------
///
/// response标准形式
/// ```
/// {
///   "data": [],
///   "status": 1,
///   "msg": "请求成功",
///   "code": 200
/// }
/// ```
/// 或
/// ```
/// {
///   "data": [],
///   "status": 0,
///   "msg": "请求失败",
///   "code": 400
/// }
/// ```
/// -----------------------------

class Request{
  static Dio dio;
  /// 测试环境
  static get _isDebug => !bool.fromEnvironment('dart.vm.product');
  static Future<Response> _base({
    String url = '',
    Map params = const <String, dynamic>{},
    /// FormData || {}
    /// 
    /// FormData formData = FormData.from({
    //   'name': 'image',
    //   'file': UploadFileInfo(File(file.path),file.path)
    // });
    Map data = const <String, dynamic>{},
    String contentType,
    RequestType method = RequestType.get, 
    Map headers = const <String, dynamic>{},
    int connectTimeout,
    int receiveTimeout,
    bool loading = false
  }) async{

    data = Map<String, dynamic>.from(data);
    params = Map<String, dynamic>.from(params);
    headers = Map<String, dynamic>.from(headers);

    /// 使用Request的库的话，签名名称不能为空
    assert(Fluwe.config.signName != null, '使用Request的库的话，签名名称不能为空,请配置Fluwe.config.signName');

    /// 存在缓存则赋值
    String signture = cache.getString(Fluwe.config.signName);
    if(!empty(signture)) {
      headers[Fluwe.config.signName] = signture;
    }

    /// 初始化url
    if (url.startsWith(r'http(s)?://')) {
    } else {
      url = Fluwe.config.baseUrl + url;
    }


    if (dio == null) {
      dio = Dio(BaseOptions(
        headers: headers,
        contentType: contentType,
        connectTimeout: connectTimeout ?? Fluwe.config.connectTimeout,
        receiveTimeout: receiveTimeout ?? Fluwe.config.receiveTimeout
      ));
      dio.interceptors.add(InterceptorsWrapper(
        onRequest:(RequestOptions options) {
          if (loading) {
            showLoading(onCancel: clear());
          }
          return options;
        },
        onError:(DioError err) {
          // showRequestToast('$url 请求异常，原因：${err.error}');
          if(err.error is String) {
            if (_isDebug) {
              showRequestToast('$url 请求返回失败，原因：${err.error}');
            } else {
              showRequestToast(err.error);
            }
          } else {
            if (_isDebug) {
              showRequestToast('$url 请求返回失败，原因：${err.error}');
            }
          }
          return dio.reject('$url 请求异常，原因：${err.error}');
        },
        onResponse:(Response response) async{
          if (response.data is Map) {
            if (response.data['status'] == 1) {
              return response;
            } else {
              return dio.reject(response.data['msg'] ?? '请求失败，没有返回任何信息');
            }
          } else {
            return dio.reject('$url 请求异常，原因：返回结果不为json类型，输出${response.data}');
          }
        },
      ));
    }
    
    
    switch (method) {
      case RequestType.get:
        return await dio.get(url,queryParameters: params);
        break;
      case RequestType.post:
        return await dio.post(url, data: data, queryParameters: params);
        break;
      case RequestType.put:
        return await dio.put(url, data: data, queryParameters: params);
        break;
      case RequestType.put:
        return await dio.put(url, data: data, queryParameters: params);
        break;
      default:
        throw('请求方法异常');
        break;
    }
  }
  static get({@required String url, Map data = const <String, dynamic>{}, bool all = false, Map headers = const <String, dynamic>{}})async{
    Response response = await _base(
      url: url,
      data: data,
      method: RequestType.get,
    );
    if (all) {
      /// 是否整个response全部输出
      return response;
    } else {
      return response.data;
    }
  }

    /// data参数: `FormData` 或者 `Map`
    /// 上传文件用`FormData`
    /// ```
    /// FormData formData = FormData.from({
    ///   'name': 'image',
    ///   'file': UploadFileInfo(File(file.path),file.path)
    /// });
    /// ```
    /// 
  static post({@required String url, data = const <String, dynamic>{}, params = const <String, dynamic>{}, bool all = false, Map headers = const <String, dynamic>{}}) async{

    Response response = await _base(
      url: url,
      method: RequestType.post,
      data: data,
      params: params
    );
    if (all) {
      /// 是否整个response全部输出
      return response;
    } else {
      return response.data;
    }
  }

  static put({@required String url, Map data = const <String, dynamic>{}, Map params = const <String, dynamic>{}, bool all = false, Map headers = const <String, dynamic>{}}) async{
    Response response = await _base(
      url: url,
      method: RequestType.put,
      data: data,
      params: params
    );
    if (all) {
      /// 是否整个response全部输出
      return response;
    } else {
      return response.data;
    }
  }

  static delete({@required String url, Map data = const <String, dynamic>{}, Map params = const <String, dynamic>{}, bool all = false, Map headers = const <String, dynamic>{}}) async{
    Response response = await _base(
      url: url,
      headers: headers,
      method: RequestType.delete,
      data: data,
      params: params
    );
    if (all) {
      /// 是否整个response全部输出
      return response;
    } else {
      return response.data;
    }
  }

  /// 关闭这个请求
  static clear() {
    dio?.clear();
  }

  static close() {
    dio?.close();
    dio = null;
  }


  static showRequestToast(msg, {bool hasMsg = false}) {
    showToast(msg ?? '请求失败');
    // if (_isDebug) {
    //   showToast(msg);
    // } else {
      // if (hasMsg) {
      //   showToast(msg);
      // } else {
      //   showToast('请求失败');
      // }
    // }
  }

}