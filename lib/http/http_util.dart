import 'package:cute_pet/config/http_options.dart';
import 'package:cute_pet/models/response_model.dart';
import 'package:dio/dio.dart';

import 'http_request.dart';

// http请求静态类
class HttpUtil {
  /// 初始化公共属性 如果需要覆盖原配置项 就调用它
  ///
  /// [baseUrl] 地址前缀
  /// [connectTimeout] 连接超时赶时间
  /// [receiveTimeout] 接收超时赶时间
  /// [headers] 请求头
  /// [interceptors] 基础拦截器
  static void init({
    String baseUrl = HttpOptions.baseUrl,
    int connectTimeout = HttpOptions.connectTimeout,
    int receiveTimeout = HttpOptions.receiveTimeout,
    Map<String, dynamic>? headers,
    List<Interceptor>? interceptors,
  }) {
    HttpRequest().init(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      headers: headers,
      interceptors: interceptors,
    );
  }

  /// 设置请求头
  static void setHeaders(Map<String, dynamic> headers) {
    HttpRequest().setHeaders(headers);
  }

  /// 取消请求
  static void cancelRequests({CancelToken? token}) {
    HttpRequest().cancelRequests(token: token);
  }

  /// restful Get请求
  static Future get(
    String url, {
    Map<String, dynamic>? params,
    Options? options,
    Function(ResponseModel)? onSuccess,
    Function(dynamic)? onError,
    CancelToken? cancelToken,
  }) async {
    return await HttpRequest().get(url,
        params: params,
        options: options,
        cancelToken: cancelToken,
        onSuccess: onSuccess,
        onError: onError);
  }

  /// restful post 操作
  static Future post(
    String path, {
    Map<String, dynamic>? params,
    dynamic data,
    Options? options,
    Function(ResponseModel)? onSuccess,
    Function(dynamic)? onError,
    CancelToken? cancelToken,
  }) async {
    return await HttpRequest().post(path,
        params: params,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSuccess: onSuccess,
        onError: onError);
  }

  /// restful postForm 表单提交操作
  static Future postForm(
    String path, {
    Map<String, dynamic>? params,
    dynamic data,
    Options? options,
    Function(ResponseModel)? onSuccess,
    Function(dynamic)? onError,
    required Function onSendProgress,
    CancelToken? cancelToken,
  }) async {
    return await HttpRequest().postForm(path,
        params: params,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSuccess: onSuccess,
        onSendProgress: onSendProgress,
        onError: onError);
  }

  /// restful put 表单提交操作
  static Future put(
    String path, {
    Map<String, dynamic>? params,
    dynamic data,
    Options? options,
    Function(ResponseModel)? onSuccess,
    Function(dynamic)? onError,
    CancelToken? cancelToken,
  }) async {
    return await HttpRequest().put(path,
        params: params,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSuccess: onSuccess,
        onError: onError);
  }

  /// restful delete 表单提交操作
  static Future delete(
    String path, {
    Map<String, dynamic>? params,
    dynamic data,
    Options? options,
    Function(ResponseModel)? onSuccess,
    Function(dynamic)? onError,
    CancelToken? cancelToken,
  }) async {
    return await HttpRequest().delete(path,
        params: params,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSuccess: onSuccess,
        onError: onError);
  }
}
