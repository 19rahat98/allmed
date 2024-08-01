import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/data/network/authorized_api_service.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/orders/data/model/order_model.dart';
import 'package:allmed/feature/orders/data/model/order_request_model.dart';
import 'package:allmed/utils/http_call_utils.dart';

class OrderRepository {
  OrderRepository() : _apiService = sl();

  final AuthorizedApiService _apiService;

  /// Создать новый запис для вызова врача
  Future<int> createOrderForUser(OrderRequestModel data) async {
    return safeApiCall(
      _apiService.createOrder(data.toJson()),
      (json) => json['data']?['order_id'] as int? ?? GlobalCoreConstants.zeroInt,
    );
  }

  /// Получаем информацию обо всех ордерах
  Future<OrderHistoryModel> ordersList() async {
    return safeApiCall(_apiService.getOrderList(), OrderHistoryModel.fromJsonList);
  }

  /// Создаем отзыв об ордоре
  Future<void> addReviewToOrder(Map<String, dynamic> param) async {
    return safeApiCallVoid(
      _apiService.addRatingToOrder(param),
    );
  }

  /// Завершаем заказ
  Future<void> closeOrder(int orderId) async {
    final param = {"order_id": orderId};
    return safeApiCallVoid(
      _apiService.closeOrder(param),
    );
  }
}
