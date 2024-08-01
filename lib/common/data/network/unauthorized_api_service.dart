import 'dart:async';
import 'package:dio/dio.dart';

/// сервис для неавторизованной зоны
class UnauthorizedApiService {
  UnauthorizedApiService(this._httpClient);

  final Future<Dio> _httpClient;

  /// авторизация
  Future<Response> signIn(Map<String, dynamic> param) async {
    final client = await _httpClient;
    return client.post<dynamic>('/auth_db/login/', data: param);
  }

  /// регистрация new phone number
  Future<Response> registrationNewPhoneNumber(Map<String, dynamic> param) async {
    final client = await _httpClient;
    return client.post<dynamic>('/register/', data: param);
  }

  /// востоновление пароля по phone number
  Future<Response> resetPassword(Map<String, dynamic> param) async {
    final client = await _httpClient;
    return client.post<dynamic>('/reset-password', data: param);
  }

  /// регистрация new route
  Future<Response> verifyPhoneNumber(Map<String, dynamic> param) async {
    final client = await _httpClient;
    return client.post<dynamic>('/verify-phone/', data: param);
  }

  /// Проверяем, рельно ли он владелец аккаунта
  Future<Response> verifyPhoneNumberForRecovery(Map<String, dynamic> param) async {
    final client = await _httpClient;
    return client.post<dynamic>('/verify-real-user-phone', data: param);
  }

  /// регистрация new route
  Future<Response> setPassword(Map<String, dynamic> param) async {
    final client = await _httpClient;
    return client.post<dynamic>('/set-password', data: param);
  }

  /// Сбрасываем пароль
  Future<Response> resetNewPassword(Map<String, dynamic> param) async {
    final client = await _httpClient;
    return client.post<dynamic>('/set-real-user-password', data: param);
  }

  /// SIGN IN
  Future<Response> login(Map<String, dynamic> param) async {
    final client = await _httpClient;
    return client.post<dynamic>('/login', data: param);
  }

  /// обновление токена
  Future<Response> refreshToken(String refreshToken) async {
    final client = await _httpClient;
    return client.post<dynamic>(
      '/refresh-token',
      data: {'refresh_token': refreshToken},
    );
  }
}
