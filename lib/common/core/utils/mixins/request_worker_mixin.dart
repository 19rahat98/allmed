import 'dart:async';
import 'dart:convert';

import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/exception/auth_error_entity.dart';
import 'package:allmed/common/exception/exception.dart';
import 'package:allmed/common/exception/registration_error_entity.dart';
import 'package:allmed/utils/http_call_utils.dart';

typedef CoreResultData<T> = void Function(T result);

/// результат выполнения загрузчика (лоадера)
typedef CoreLoadingData = void Function(bool isLoading);

mixin CoreRequestWorkedMixin {
  /// Timer для запроса
  Timer? timer;

  final String _defaultError = 'Произошла ошибка';

  /// показывает сообщение об ошибке с возможность передачи http кода
  /// [_errorMessage] сообщение об ошибке
  /// [code] http код ошибки
  Function(String errorMessage, int code)? showErrorHttpCallback;

  Function()? showAuthErrorCallback;

  /// показывает сообщение об ошибке при отсутвии интернета
  /// [_errorMessage] сообщение об ошибке
  Function(String errorMessage)? showErrorInternetConnection;

  /// показывает сообщение об ошибке при cбое самого приложения
  /// [_errorMessage] сообщение об ошибке
  Function(String errorMessage)? showErrorExceptionCallback;

  /// функиця безопастно запускает запрос без обработки пользовательской
  ///  ошибки(выводиться ошибки в стандартных полях предусмотренные сервером)
  /// [request] запрос принимает фнкция useCase
  /// [loading] callback функция информирующая старт загрузки
  /// [resultData] callback успешном результате
  /// [errorData]  callback при ошибке

  Future<void> launch<T>({
    required Future<T> request,
    CoreLoadingData? loading,
    CoreResultData<T>? resultData,
    CoreResultData<String>? errorData,
  }) async {
    loading?.call(true);
    try {
      final result = await request;
      loading?.call(false);
      resultData?.call(result);
    } on HttpRequestException catch (ex) {
      loading?.call(false);
      _makeHttpException<String>(ex, errorData);
    } catch (ex) {
      loading?.call(false);
      _makeException<String>(ex, errorData);
    }
  }

  /// функиця безопастного подслушование сокета, и с возможностю обработки
  ///  ошибки(выводиться ошибки в стандартных полях предусмотренные сервером)
  /// [socket] запрос принимает фнкция useCase
  /// [jsonCall] callback функция для парсинга списка
  /// [resultData] callback успешном результате
  /// [errorData]  callback при ошибке
  void listenSocketWithError<T>(
    Stream socket,
    ResponseListJson<T> jsonCall, {
    Function(T)? resultData,
    required CoreResultData<String> errorData,
  }) {
    try {
      socket.listen((dynamic event) {
        final result = jsonDecode(event as String) as List<dynamic>;
        final json = jsonCall.call(result);
        resultData?.call(json);
      });
    } catch (ex) {
      _makeException<String>(ex, errorData);
    }
  }

  /// функиця безопастно запускает запрос c обработкой пользовательской
  ///  ошибки c возможностью добавить задержку
  /// [delay] время задержки запроса
  /// [request] запрос принимает фнкция useCase
  /// [loading] callback функция информирующая старт загрузки
  /// [resultData] callback успешном результате
  /// [errorData]  callback при ошибке
  void launchDelayWithError<T, V extends HttpRequestException<V>>(
    int delay, {
    required Future<T> request,
    CoreLoadingData? loading,
    CoreResultData<T>? resultData,
    required Function(V) errorData,
  }) {
    _delay(delay, () async {
      loading?.call(true);
      try {
        final result = await request;
        loading?.call(false);
        resultData?.call(result);
      } on GlobalAuthException catch (ex) {
        loading?.call(false);
        _makeHttpException<V>(ex, errorData);
      } catch (ex, s) {
        loading?.call(false);
        _makeException<V>(s, errorData);
      }
    });
  }

  /// функиця безопастно запускает запрос c обработкой
  /// [request] запрос принимает фнкция useCase
  /// [loading] callback функция информирующая старт загрузки
  /// [resultData] callback успешном результате
  /// [errorData]  callback при ошибке
  Future<void> launchWithError<T, V>({
    required Future<T> request,
    CoreLoadingData? loading,
    CoreResultData<T>? resultData,
    required Function(V) errorData,
  }) async {
    loading?.call(true);
    try {
      final result = await request;
      loading?.call(false);
      resultData?.call(result);
    } on HttpRequestException catch (ex) {
      loading?.call(false);
      _makeHttpException<V>(ex, errorData);
    } catch (ex, s) {
      loading?.call(false);
      _makeException<V>(s, errorData);
    }
  }

  /// функиця безопастно запускает запрос c обработкой пользовательской
  ///  ошибки для авторизованных юзеров
  /// [request] запрос принимает фнкция useCase
  /// [loading] callback функция информирующая старт загрузки
  /// [resultData] callback успешном результате
  /// [errorData]  callback при ошибке
  Future<void> launchWithAuthError<T, V>({
    required Future<T> request,
    CoreLoadingData? loading,
    CoreResultData<T>? resultData,
    required Function(V?) errorData,
  }) async {
    loading?.call(true);
    try {
      final result = await request;
      loading?.call(false);
      resultData?.call(result);
    } on GlobalAuthException catch (ex) {
      loading?.call(false);
      _makeAuthHttpException<V>(ex, errorData);
    } on RegistrationException catch (ex) {
      loading?.call(false);
      _makeAuthHttpException<V>(ex, errorData);
    } catch (ex) {
      loading?.call(false);
      errorData(null);
    }
  }

  /// функиця безопастно запускает запрос без обработки пользовательской
  /// ошибки(выводиться ошибки в стандартных полях предусмотренные сервером)
  /// [delay] время задержки запроса
  /// [request] запрос принимает фнкция useCase
  void launchDelay(
    int delay, {
    required Function() request,
    required Function() onLoading,
  }) {
    if (timer?.isActive ?? false) timer?.cancel();
    onLoading.call();
    timer = Timer(Duration(milliseconds: delay), () {
      request.call();
    });
  }

  void clear() {
    timer?.cancel();
    timer = null;
  }

  /// отображает http ошибки
  void _makeHttpException<T>(
    HttpRequestException ex,
    CoreResultData<T>? errorData,
  ) {
    if (ex.httpTypeError == HttpTypeError.notInternetConnection) {
      showErrorInternetConnection?.call(
        ex.message ?? GlobalCoreConstants.empty,
      );
    }

    if (ex.code == 401) {
      showAuthErrorCallback?.call();
      return;
    }

    if (ex is T) {
      errorData?.call(ex as T);
      return;
    }

    if (ex.httpTypeError == HttpTypeError.http) {
      showErrorHttpCallback?.call(
        ex.message ?? GlobalCoreConstants.empty,
        ex.code,
      );
      return;
    }
  }

  /// отображает auth http ошибки
  void _makeAuthHttpException<T>(
    HttpRequestException<dynamic> ex,
    CoreResultData<T> errorData,
  ) {
    if (ex.httpTypeError == HttpTypeError.notInternetConnection) {
      showErrorInternetConnection?.call(
        ex.message ?? GlobalCoreConstants.empty,
      );
    }

    if (ex is T) {
      errorData.call(ex as T);
      return;
    }

    if (ex.httpTypeError == HttpTypeError.http) {
      showErrorHttpCallback?.call(
        ex.message ?? GlobalCoreConstants.empty,
        ex.code,
      );
      return;
    }
  }

  /// функция запускает таймер на определенное время
  void _delay(int delay, Function() run) {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(Duration(milliseconds: delay), () {
      run();
    });
  }

  /// отображает различные исключения
  void _makeException<T>(dynamic ex, CoreResultData<T>? errorData) {
    showErrorExceptionCallback?.call(_defaultError);
  }
}
