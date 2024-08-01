part of 'order_history_cubit.dart';

class OrderHistoryListState extends CoreState {
  OrderHistoryListState(this.historyOrders);

  final OrderHistoryModel historyOrders;

  /// Объединяет завершенные и текущие заказы в один список.
  List<OrderFetchInfo> get orders => historyOrders.orders;

  /// Проверяет, нет ли завершенных или текущих заказов.
  bool get isEmpty => historyOrders.orders.isEmpty;

  /// Проверяет, есть ли текущие заказы.
  bool get isHaveActualOrder => historyOrders.inProgress.isNotEmpty;

  /// Получает дату и детали последнего текущего заказа.
  OrderModel get lastActualOrder => historyOrders.inProgress.last.orders.last;

  @override
  List<Object> get props => [historyOrders];
}