import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/core/utils/mixins/request_worker_mixin.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/orders/data/model/order_model.dart';
import 'package:allmed/feature/orders/data/repository/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryListState> with CoreRequestWorkedMixin {
  OrderHistoryCubit()
      : _repository = sl(),
        super(
          OrderHistoryListState(
            const OrderHistoryModel(),
          ),
        );

  final OrderRepository _repository;

  Future<void> getOrdersList() async {
    final request = _repository.ordersList();

    await launch<OrderHistoryModel>(
      request: request,
      resultData: (result) => emit(
        OrderHistoryListState(result),
      ),
    );
  }
}
