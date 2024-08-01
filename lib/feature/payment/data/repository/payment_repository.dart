import 'package:allmed/common/data/network/authorized_api_service.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/payment/data/model/payment_3ds_response.dart';
import 'package:allmed/feature/payment/data/model/user_card_model.dart';
import 'package:allmed/utils/http_call_utils.dart';

class PaymentRepository {
  PaymentRepository() : _apiService = sl();

  final AuthorizedApiService _apiService;

  /// Платим с помощью токена сгенерированного
  Future<Payment3dsResponse?> paymentWithCardCrypto(int orderId, String token) async {
    final param = {'order_id': orderId, 'card_cryptogram_packet': token};
    return safeApiCallWithCode(
      _apiService.payment(param),
      (json, code) {
        if (code == 200) return null;
        return Payment3dsResponse.fromJson(json);
      },
    );
  }

  Future<void> verify3ds(int transactionId, String paRes, int orderId, bool isSaveCard) {
    final param = {"transaction_id": transactionId, "pa_res": paRes};
    if (!isSaveCard) param.addAll({"order_id": orderId});
    final query = isSaveCard ? {'save_card': true} : null;
    return safeApiCallVoid(
      _apiService.step3ds(param, query),
    );
  }

  Future<Payment3dsResponse?> saveNewCard(String token) {
    final param = {'card_cryptogram_packet': token};
    return safeApiCallWithCode(
      _apiService.addCard(param),
      (json, code) {
        if (code == 200) return null;
        return Payment3dsResponse.fromJson(json);
      },
    );
  }

  Future<List<UserCardModel>> getUserCard() {
    return safeApiCall(
      _apiService.payCardsList(),
      UserCardModel.fromJsonList,
    );
  }

  Future<void> deleteCard(int id) {
    final data = {'user_card_id': id};
    return safeApiCallVoid(
      _apiService.deleteUserCard(data),
    );
  }

  Future<void> selectActiveCard(int id) {
    final data = {'user_card_id': id};
    return safeApiCallVoid(
      _apiService.selectCard(data),
    );
  }

  Future<void> payWithToken(int orderId, String token) {
    final data = {'order_id': orderId, 'token': token};
    return safeApiCallVoid(
      _apiService.payWithToken(data),
    );
  }
}
