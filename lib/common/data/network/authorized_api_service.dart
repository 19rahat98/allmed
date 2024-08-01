import 'package:allmed/common/contants/global_network_constant.dart';
import 'package:dio/dio.dart';

/// сервис для авторизованной зоны
class AuthorizedApiService {
  AuthorizedApiService(this._httpClient);

  final Future<Dio> _httpClient;

  /// авторизация
  Future<Response> getProfile() async {
    final client = await _httpClient;
    return client.get<dynamic>('/profile');
  }

  /// Content banners list
  Future<Response> bannerList() async {
    final client = await _httpClient;
    return client.get<dynamic>('/banners');
  }

  /// Content FAQ list
  Future<Response> faqList() async {
    final client = await _httpClient;
    return client.get<dynamic>('/questions');
  }

  /// Content info list
  Future<Response> termsList() async {
    final client = await _httpClient;
    return client.get<dynamic>('/informations');
  }

  /// Content term info
  Future<Response> termsData(int id) async {
    final client = await _httpClient;
    return client.get<dynamic>('/informations/$id');
  }

  /// Pay with card
  Future<Response> payment(Map<String, dynamic> data) async {
    final client = await _httpClient;
    return client.post<dynamic>('/payment', data: data);
  }

  /// Add pay card
  Future<Response> addCard(Map<String, dynamic> data) async {
    final client = await _httpClient;
    return client.post<dynamic>(
      '/save-card',
      data: data,
      queryParameters: {'save_card': true},
    );
  }

  /// Get user cards list
  Future<Response> payCardsList() async {
    final client = await _httpClient;
    return client.get<dynamic>('/user-cards');
  }

  /// Get user cards list
  Future<Response> deleteUserCard(Map<String, dynamic> data) async {
    final client = await _httpClient;
    return client.delete<dynamic>('/user-cards/delete', data: data);
  }

  /// Get user cards list
  Future<Response> payWithToken(Map<String, dynamic> data) async {
    final client = await _httpClient;
    return client.post<dynamic>('/payment/token', data: data);
  }

  /// Select active card
  Future<Response> selectCard(Map<String, dynamic> data) async {
    final client = await _httpClient;
    return client.post<dynamic>('/user-cards/select', data: data);
  }

  /// Verify 3ds step
  Future<Response> step3ds(Map<String, dynamic> data, Map<String, dynamic>? query) async {
    final client = await _httpClient;
    return client.post<dynamic>('/3ds', data: data, queryParameters: query);
  }

  /// Задаем инфо про юзера
  Future<Response> setUserInfo(Map<String, dynamic> param) async {
    final client = await _httpClient;
    return client.post('/update-info', data: param);
  }

  Future<Response> updateUserProfile(Map<String, dynamic> param) async {
    final client = await _httpClient;
    return client.post('/update-profile', data: param);
  }

  /// Список адрессов юзеров
  Future<Response> getAddressList() async {
    final client = await _httpClient;
    return client.get('/addresses');
  }

  /// Список адрессов юзеров
  Future<Response> createNewAddress(Map<String, dynamic> data) async {
    final client = await _httpClient;
    return client.post('/addresses', data: data);
  }

  /// Список адрессов юзеров
  Future<Response> deleteAddressById(int id) async {
    final client = await _httpClient;
    return client.delete('/addresses/$id');
  }

  /// Список адрессов юзеров
  Future<Response> changeAddressInfo(int id, Map<String, dynamic> data) async {
    final client = await _httpClient;
    return client.put('/addresses/$id', data: data);
  }

  /// Список адрессов юзеров
  Future<Response> selectAddress(Map<String, dynamic> data) async {
    final client = await _httpClient;
    return client.put('/select-address', data: data);
  }

  /// Список услуг
  Future<Response> serviceList(String id) async {
    final client = await _httpClient;
    return client.get('/services/$id');
  }

  /// Список услуг
  Future<Response> chooseDoctor(Map<String, dynamic> data) async {
    final client = await _httpClient;
    return client.get('/services/show', data: data);
  }

  /// Список услуг
  Future<Response> serviceCatalog() async {
    final client = await _httpClient;
    return client.get('/catalogs');
  }

  /// Создать новый ордер
  Future<Response> createOrder(Map<String, dynamic> data) async {
    final client = await _httpClient;
    return client.post(
      '/orders',
      data: data,
      queryParameters: {'token': GlobalNetworkConstant.serverToken},
    );
  }

  /// Список ордеров юзера
  Future<Response> getOrderList() async {
    final client = await _httpClient;
    return client.get('/orders');
  }

  /// Завершаем ордер
  Future<Response> closeOrder(Map<String, dynamic> data) async {
    final client = await _httpClient;
    return client.put('/end-order', data: data);
  }

  /// Оставляем отзыв об ордоре
  Future<Response> addRatingToOrder(Map<String, dynamic> data) async {
    final client = await _httpClient;
    return client.post('/rating', data: data);
  }
}
