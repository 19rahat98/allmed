import 'dart:async';
import 'dart:convert';
import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/exception/default_error.dart';
import 'package:allmed/common/exception/exception.dart';
import 'package:dio/dio.dart';

/// функция для получения резултата
typedef ResponseJson<T> = T Function(Map<String, dynamic>);

typedef ResponseJsonAndCode<T> = T Function(Map<String, dynamic>, int code);

typedef ResponseListJson<T> = T Function(List<dynamic>);

/// функция для получения пользователькой ошибка
/// [dynamic] ошибка в виде json
/// [String] ошибка по умалчанию
typedef ErrorResponsePrinter<T> = HttpRequestException<T> Function(
    Map<String, dynamic>, String, int);

/// вызов безопасно http функцию с обработкой пользовтелькой ошибки, а также обратный вызов для работы с
/// локальной базов в лучае какой либо ошибки
/// T отвер сервера
Future<T> safeApiCallWithDataBase<T>({
  Map<String, dynamic> Function()? onQueryDataBase,
  Future<Response>? networkCall,
  Function(Map<String, dynamic>)? onSaveDataBase,
  required ResponseJson<T> onResult,
}) async {
  try {
    final result = await networkCall;
    final json = await result?.data;
    onSaveDataBase?.call(json);
    return onResult.call(json);
  } catch (ex) {
    if (ex is DioException) {
      final dataBaseValue = onQueryDataBase?.call();
      if (dataBaseValue?.isEmpty ?? false) {
        return onResult.call(dataBaseValue!);
      }
      final data = ex.response?.data;
      final message = _handleDioExceptionType(ex, data);
      throw HttpRequestException<dynamic>(
        message: message,
        code: ex.response?.statusCode ?? GlobalCoreConstants.negative,
        httpTypeError: HttpTypeError.http,
      );
    }
    throw _throwDefaultError(ex);
  }
}

/// вызов безопасно http функцию с обработкой пользовтелькой ошибки
/// [T] отвер сервера
Future<T> safeApiCall<T>(
  Future<Response> response,
  ResponseJson<T> jsonCall, {
  bool? isTest,
}) async {
  await _makeThrowInternetConnection(isTest ?? false);
  try {
    final result = await response;
    final json = result.data;
    return jsonCall.call(json);
  } catch (ex) {
    if (ex is DioException) {
      final data = ex.response?.data;
      final message = _handleDioExceptionType(ex, data);
      throw HttpRequestException<dynamic>(
        message: message,
        httpTypeError: HttpTypeError.http,
        code: ex.response?.statusCode ?? GlobalCoreConstants.negative,
      );
    }
    throw _throwDefaultError(ex);
  }
}

Future<T> safeApiCallWithCode<T>(
  Future<Response> response,
  ResponseJsonAndCode<T> jsonCall, {
  bool? isTest,
}) async {
  await _makeThrowInternetConnection(isTest ?? false);
  try {
    final result = await response;
    final json = result.data;
    return jsonCall.call(json, result.statusCode ?? 200);
  } catch (ex) {
    if (ex is DioException) {
      final data = ex.response?.data;
      final message = _handleDioExceptionType(ex, data);
      throw HttpRequestException<dynamic>(
        message: message,
        httpTypeError: HttpTypeError.http,
        code: ex.response?.statusCode ?? GlobalCoreConstants.negative,
      );
    }
    throw _throwDefaultError(ex);
  }
}

/// вызов безопасно http функцию с обработкой пользовтелькой ошибки
/// [T] отвер сервера
Future<T> safeApiCallList<T>(
  Future<Response> response,
  ResponseListJson<T> jsonCall, {
  bool? isTest,
}) async {
  await _makeThrowInternetConnection(isTest ?? false);
  try {
    final result = await response;
    final json = result.data;
    return jsonCall.call(json);
  } catch (ex) {
    if (ex is DioException) {
      final data = ex.response?.data;
      final message = _handleDioExceptionType(ex, data);
      throw HttpRequestException<dynamic>(
        message: message,
        code: ex.response?.statusCode ?? GlobalCoreConstants.negative,
        httpTypeError: HttpTypeError.http,
      );
    }
    throw _throwDefaultError(ex);
  }
}

/// вызов безопасно http функцию возвращает void (вызывать в случае пустого ответа)
/// [response] - ответ от сервера
Future<void> safeApiCallVoid(
  Future<Response> response, {
  bool? isTest,
}) async {
  await _makeThrowInternetConnection(isTest ?? false);
  try {
    await response;
    return;
  } catch (ex) {
    if (ex is DioException) {
      final data = ex.response?.data;
      final message = _handleDioExceptionType(ex, data);
      throw HttpRequestException<dynamic>(
        message: message,
        code: ex.response?.statusCode ?? GlobalCoreConstants.zeroInt,
        httpTypeError: HttpTypeError.http,
      );
    }
    throw _throwDefaultError(ex);
  }
}

/// вызов безопасно http функцию
/// T отвер сервера
/// V ответ сервера в виде ошибки
Future<T> safeApiCallWithError<T, V>(
  Future<Response> response,
  ResponseJson<T> jsonCall,
  ErrorResponsePrinter<V> errorResponsePrinter, {
  bool? isTest,
}) async {
  try {
    final result = await response;
    final json = result.data;
    return jsonCall.call(json);
  } catch (ex) {
    if (ex is DioException) {
      throw errorResponsePrinter.call(
        _parseResponseData(ex.response),
        _handleDioExceptionType(ex),
        ex.response?.statusCode ?? GlobalCoreConstants.negative,
      );
    }

    throw _throwDefaultError(ex);
  }
}

Map<String, dynamic> _parseResponseData(Response? response) {
  final typeError = response?.data.runtimeType;
  try {
    if (typeError == String) {
      return jsonDecode(response?.data);
    } else {
      return response?.data;
    }
  } catch (e) {
    rethrow;
  }
}

/// вызов безопасно http функцию
/// T отвер сервера
/// V ответ сервера в виде ошибки
Future<void> safeApiVoidCallWithError<V>(
  Future<Response> response,
  ErrorResponsePrinter<V> errorResponsePrinter, {
  bool? isTest,
}) async {
  await _makeThrowInternetConnection(isTest ?? false);
  try {
    await response;
    return;
  } catch (ex) {
    if (ex is DioException) {
      final data = ex.response?.data;
      throw errorResponsePrinter.call(
        data,
        _handleDioExceptionType(ex),
        ex.response?.statusCode ?? GlobalCoreConstants.negative,
      );
    }

    throw _throwDefaultError(ex);
  }
}

/// выкидывает исключение в виде ошибки по умалчанию
HttpRequestException<String> _throwDefaultError(exception) {
  return HttpRequestException<String>(
    message: exception,
    code: GlobalCoreConstants.zeroInt,
    httpTypeError: HttpTypeError.http,
  );
}

/// вызывает исключение при отсутсии интернета
Future<HttpRequestException<String>?> _makeThrowInternetConnection(
  bool isTest,
) async {
  if (isTest == true) {
    final isInternetConnection = await _checkInternetConnection();
    if (!isInternetConnection) {
      throw HttpRequestException<String>(
        message: "Нет интернет соеденения",
        code: GlobalCoreConstants.negative,
        httpTypeError: HttpTypeError.notInternetConnection,
      );
    }
  }
  return null;
}

/// проверка интернет соеденения
Future<bool> _checkInternetConnection() async {
  /*var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;*/
  return true;
}

/// обработчик ошибок по типу ошибко [Dio]
/// [DioExceptionType] ошибка
String _handleDioExceptionType(DioException ex, [Map<String, dynamic>? data]) {
  switch (ex.type) {
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionTimeout:
      {
        return "Время таймаута истекло";
      }
    default:
      {
        if (ex.message?.contains('SocketException') ?? false) {
          return "Ошибка соеденения";
        }
        try {
          return data != null ? DefaultError.fromJson(data).message : "Ошибка сервера";
        } catch (e) {
          return "Ошибка сервера";
        }
      }
  }
}
