import 'dart:convert';

import 'package:cute_pet/caches/shared_storage.dart';
import 'package:cute_pet/config/http_options.dart';
import 'package:cute_pet/models/response_model.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// http 请求单例类
class HttpRequest {
  // 工厂构造方法
  factory HttpRequest() => _instance;
  // 初始化一个单例实例
  static final HttpRequest _instance = HttpRequest._internal();
  // dio 实例
  static late final Dio dio;
  // 内部构造方法
  HttpRequest._internal() {
    // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    BaseOptions baseOptions = BaseOptions(
      baseUrl: HttpOptions.baseUrl,
      connectTimeout: HttpOptions.connectTimeout,
      receiveTimeout: HttpOptions.receiveTimeout,
      headers: {},
    );
    // 没有实例 则创建之
    dio = Dio(baseOptions);
    // 添加拦截器
    HttpOptions.showGlobalLogger
        ? dio.interceptors.add(PrettyDioLogger(
            requestHeader: false,
            requestBody: false,
            responseBody: true,
            responseHeader: false,
            error: false,
            compact: false,
            maxWidth: 90))
        : '';
  }

  /// 初始化公共属性 如果需要覆盖原配置项 就调用它
  /// [baseUrl] 地址前缀
  /// [connectTimeout] 连接超时赶时间
  /// [receiveTimeout] 接收超时赶时间
  /// [headers] 请求头
  /// [interceptors] 基础拦截器
  void init({
    String baseUrl = HttpOptions.baseUrl,
    int connectTimeout = HttpOptions.connectTimeout,
    int receiveTimeout = HttpOptions.receiveTimeout,
    Map<String, dynamic>? headers,
    List<Interceptor>? interceptors,
  }) {
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = connectTimeout;
    dio.options.receiveTimeout = receiveTimeout;
    dio.options.headers = headers;
    if (interceptors != null && interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }
  }

  /// 设置请求头
  void setHeaders(Map<String, dynamic> headers) {
    dio.options.headers.addAll(headers);
  }

  /*
   * 取消请求头
   * 同一个cancel token 可以用于多个请求
   * 当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  final CancelToken _cancelToken = CancelToken();
  void cancelRequests({CancelToken? token}) {
    token ?? _cancelToken.cancel('cancelled');
  }

  /// 设置鉴权请求头
  Future<Options> setAuthorizationHeader(Options requestOptions) async {
    String _authorization = '';
    _authorization = await SharedStorage.getToken();
    if (_authorization != '') {
      requestOptions.headers = {'authorization': _authorization};
    } else if (requestOptions.headers != null && _authorization == '') {
      requestOptions.headers!.clear();
    }
    return requestOptions;
  }

  // 日志初始化
  Logger logger = Logger(
    printer: PrettyPrinter(
        methodCount: 2, // number of method calls to be displayed
        errorMethodCount: 8, // number of method calls if stacktrace is provided
        lineLength: 120, // width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        ),
  );

  // 接口传参处理
  queryHandle(Map<String, dynamic>? params, String url) {
    ///定义请求参数
    params = params ?? {};
    //参数处理
    params.forEach((key, value) {
      if (url.contains(key)) {
        url = url.replaceAll(':$key', value.toString());
      }
    });
  }

  // 接口数据返回处理
  responseHandle(Response response, Function? onSuccess) {
    if (response.statusCode == 200) {
      if (onSuccess != null) {
        onSuccess(ResponseModel.fromJson(response.data is String ? jsonDecode(response.data) : response.data));
      }
    } else {
      throw Exception('erroMsg: ${response.data['message']}');
    }
  }

  // 打印错误信息
  String printError(e) {
    logger.e('\n======打印失败信息======');
    logger.e(e.toString());
    String error = '网络请求异常，请联系管理员';
    if (e.runtimeType != DioError) {
      error = e.toString().substring(20);
    }
    return error;
  }

  /// restful Get请求
  get(
    String url, {
    Map<String, dynamic>? params,
    Options? options,
    Function(ResponseModel)? onSuccess,
    Function(dynamic)? onError,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = await setAuthorizationHeader(options ?? Options());

    queryHandle(params, url);

    try {
      Response response;
      response = await dio.get(
        url,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken,
      );
      responseHandle(response, onSuccess);
    } catch (e) {
      onError!(printError(e));
    }
  }

  /// restful post请求
  post(
    String url, {
    Map<String, dynamic>? params,
    dynamic data,
    Function(ResponseModel)? onSuccess,
    Function(dynamic)? onError,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = await setAuthorizationHeader(options ?? Options());

    queryHandle(params, url);

    try {
      Response response;
      response = await dio.post(
        url,
        queryParameters: params,
        data: data,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken,
      );
      responseHandle(response, onSuccess);
    } catch (e) {
      onError!(printError(e));
    }
  }

  /// restful postForm请求
  postForm(
    String url, {
    Map<String, dynamic>? params,
    dynamic data,
    Function(ResponseModel)? onSuccess,
    Function(dynamic)? onError,
    required Function onSendProgress,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = await setAuthorizationHeader(options ?? Options());

    queryHandle(params, url);

    try {
      Response response;
      response = await dio.post(
        url,
        queryParameters: params,
        data: FormData.fromMap(data),
        options: requestOptions,
        onSendProgress: (int process, int total) {
          onSendProgress(process, total);
        },
        cancelToken: cancelToken ?? _cancelToken,
      );
      responseHandle(response, onSuccess);
    } catch (e) {
      onError!(printError(e));
    }
  }

  /// restful put请求
  put(
    String url, {
    Map<String, dynamic>? params,
    dynamic data,
    Function(ResponseModel)? onSuccess,
    Function(dynamic)? onError,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = await setAuthorizationHeader(options ?? Options());

    queryHandle(params, url);

    try {
      Response response;
      response = await dio.put(
        url,
        queryParameters: params,
        data: data,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken,
      );
      responseHandle(response, onSuccess);
    } catch (e) {
      onError!(printError(e));
    }
  }

  /// restful delete请求
  delete(
    String url, {
    Map<String, dynamic>? params,
    dynamic data,
    Function(ResponseModel)? onSuccess,
    Function(dynamic)? onError,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = await setAuthorizationHeader(options ?? Options());

    queryHandle(params, url);

    try {
      Response response;
      response = await dio.delete(
        url,
        queryParameters: params,
        data: data,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken,
      );
      responseHandle(response, onSuccess);
    } catch (e) {
      onError!(printError(e));
    }
  }
}
