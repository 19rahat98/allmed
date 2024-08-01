import 'dart:io';

import 'package:allmed/common/contants/global_network_constant.dart';
import 'package:allmed/common/contants/global_translate_constant.dart';
import 'package:allmed/common/data/network/app_default_interceptor.dart';
import 'package:allmed/common/data/network/bearer_token_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Future<Dio> createHttpClient(String baseUrl, {bool useLogger = true}) async {
  final dio = Dio();
  dio.options.baseUrl = baseUrl;
  dio.options.connectTimeout = const Duration(seconds: 8);
  dio.options.receiveTimeout = const Duration(seconds: 5);
  dio.options.headers = {'Accept': 'application/json'};
  dio.options.headers[GlobalNetworkConstant.acceptLanguage] = GlobalTranslateConstant.ru;

  dio.interceptors.add(
    AppDefaultHeaderInterceptor(),
  );

  if (kDebugMode && useLogger) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
      ),
    );
  }

  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    return HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  };
  return dio;
}

Future<Dio> createAuthorizedHttpClient(String baseUrl) async {
  final dio = Dio();
  dio.options.baseUrl = baseUrl;
  dio.options.connectTimeout = const Duration(seconds: 8);
  dio.options.receiveTimeout = const Duration(seconds: 5);
  dio.options.headers = {'Accept': 'application/json'};

  dio.interceptors.add(AppDefaultHeaderInterceptor());
  if (kDebugMode) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
      ),
    );
  }
  dio.interceptors.add(BearerTokenInterceptor(dio));

  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    return HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  };
  return dio;
}
