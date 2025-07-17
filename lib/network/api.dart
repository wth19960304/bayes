import 'dart:async';
import 'dart:convert';
// ignore: library_prefixes
import 'dart:math' as LogUtil;

import 'package:bayes/base/build_config.dart';
import 'package:bayes/bean/entity_factory.dart';
import 'package:bayes/constant/color.dart';
import 'package:bayes/network/NWApi.dart';
import 'package:bayes/network/myIntercept.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';

import 'intercept/base_intercept.dart';

///http请求
class HttpManager {
  // ignore: constant_identifier_names
  static const CONTENT_TYPE_JSON = "application/json";
  // ignore: constant_identifier_names
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
  static final Dio _dio = Dio();
  // ignore: non_constant_identifier_names
  static final int CONNECR_TIME_OUT = 15000;
  // ignore: non_constant_identifier_names
  static final int RECIVE_TIME_OUT = 15000;
  static final Map<String, CancelToken> _cancelTokens = <String, CancelToken>{};

  HttpManager._internal() {
    initDio();
  }

  static final HttpManager _httpManger = HttpManager._internal();

  factory HttpManager() {
    return _httpManger;
  }

  //get请求
  PublishSubject<T> get<T>(
    String url, {
    required Map<String, dynamic> queryParameters,
    required BaseIntercept baseIntercept,
    bool isCancelable = true,
  }) {
    return _requstHttp<T>(
      url,
      true,
      queryParameters,
      baseIntercept,
      isCancelable,
    );
  }

  //post请求
  PublishSubject<T> post<T>(
    String url, {
    required Map<String, dynamic> queryParameters,
    BaseIntercept? baseIntercept,
    bool isCancelable = true,
    bool isSHowErrorToast = true,
  }) {
    return _requstHttp<T>(
      url,
      false,
      FormData.fromMap(queryParameters),
      baseIntercept,
      isCancelable,
    );
  }

  /// 参数说明  url 请求路径
  /// queryParamerers  是 请求参数
  /// baseWidget和baseInnerWidgetState用于 加载loading 和 设置 取消CanselToken
  /// isCancelable 是设置改请求是否 能被取消 ， 必须建立在 传入baseWidget或者baseInnerWidgetState的基础之上
  /// isShowLoading 设置是否能显示 加载loading , 同样要建立在传入 baseWidget或者 baseInnerWidgetState 基础之上
  /// isShowErrorToaet  这个是 设置请求失败后 是否要 吐司的
  PublishSubject<T> _requstHttp<T>(
    String url, [
    bool? isGet,
    queryParameters,
    BaseIntercept? baseIntercept,
    bool? isCancelable,
  ]) {
    Future future;
    PublishSubject<T> publishSubject = PublishSubject<T>();
    CancelToken? cancelToken;

    if (baseIntercept != null) {
      baseIntercept.beforeRequest();
      //为了 能够取消 请求
      if (isCancelable ?? false) {
        cancelToken =
            _cancelTokens[baseIntercept.getClassName()] ?? CancelToken();
        _cancelTokens[baseIntercept.getClassName()] = cancelToken;
      }
    }
    if (isGet ?? false) {
      future = _dio.get(
        url,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
    } else {
      future = _dio.post(url, data: queryParameters, cancelToken: cancelToken);
    }
    future
        .then((da) {
          Response data = da;
          if (data.headers.value("code") == "400") {
            //token过期 提示并进入登录界面
            //        showToast("登录过期，请重新登录");
            baseIntercept?.afterRequest();
            baseIntercept?.loginExpiration();
            return;
          }
          //需要先过滤 error ， 根据和后台的 约定 ， 搞清楚什么是失败
          int code = json.decode(data.toString())["state"];
          LogUtil.e;
          if (code != 200) {
            callError(
              publishSubject,
              MyError(code, json.decode(data.toString())["message"]),
              baseIntercept!,
            );
          } else {
            //解析参照 https://www.jianshu.com/p/e909f3f936d6
            publishSubject.add(
              EntityFactory.generateOBJ<T>(json.decode(data.toString())),
            );
            publishSubject.close();

            cancelLoading(baseIntercept!);
          }
        })
        .catchError((err) {
          callError(publishSubject, MyError(1, err.toString()), baseIntercept!);
        });

    return publishSubject;
  }

  ///请求错误以后 做的一些事情
  void callError(
    PublishSubject publishSubject,
    MyError error,
    BaseIntercept baseIntercept,
  ) {
    publishSubject.addError(error);
    publishSubject.close();
    cancelLoading(baseIntercept);
    baseIntercept.requestFailure(error.message);
  }

  ///取消请求
  static void cancelHttp(String tag) {
    if (_cancelTokens.containsKey(tag)) {
      if (!_cancelTokens[tag]!.isCancelled) {
        _cancelTokens[tag]?.cancel();
      }
      _cancelTokens.remove(tag);
    }
  }

  ///配置dio
  void initDio() {
    // 配置dio实例
    //线上测试地址
    //    _dio.options.baseUrl = "http://222.178.203.91:8803/";
    //内网地址
    //    _dio.options.baseUrl = "http://192.168.199.214:8091/";
    //服务器地址
    _dio.options.baseUrl = NWApi.baseApi;

    _dio.options.connectTimeout = Duration(milliseconds: CONNECR_TIME_OUT); //5s
    _dio.options.receiveTimeout = Duration(milliseconds: RECIVE_TIME_OUT);
    _dio.options.contentType = CONTENT_TYPE_FORM;

    //代理设置
    if (BuildConfig.isDebug) {
      //此处可以增加配置项，留一个设置代理的用户给测试人员配置，然后动态读取

      //代理配置可以设置
      //      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      //          (client) {
      //        // config the http client
      //        client.findProxy = (uri) {
      //          //proxy all request to localhost:8888
      //          return "PROXY 10.5.39.111:8888";
      //        };
      //        // you can also create a new HttpClient to dio
      //        // return new HttpClient();
      //      };
    }

    //证书配置
    //    String PEM="XXXXX"; // certificate content
    //    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate  = (client) {
    //      client.badCertificateCallback=(X509Certificate cert, String host, int port){
    //        if(cert.pem==PEM){ // Verify the certificate
    //          return true;
    //        }
    //        return false;
    //      };
    //    };

    /// 添加拦截器
    _dio.interceptors.add(MyIntercept());
  }

  void showErrorToast(String message) {
    //统一错误提示
    //    showToast(message);
  }

  void showToast(
    String content, {
    Toast length = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.CENTER,
    Color backColor = Colors.black87,
    Color textColor = KColorConstant.white,
  }) {
    Fluttertoast.showToast(
      msg: content,
      toastLength: length,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: backColor,
      textColor: textColor,
      fontSize: 13.0,
    );
  }

  void cancelLoading(BaseIntercept baseIntercept) {
    baseIntercept.afterRequest();
  }
}

class MyError {
  int code;
  String message;

  MyError(this.code, this.message);
}
