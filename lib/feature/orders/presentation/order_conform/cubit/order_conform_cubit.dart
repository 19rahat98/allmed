import 'package:allmed/common/core/presentation/abstract/bloc/core_cubit.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/exception/exception.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/orders/data/repository/order_repository.dart';
import 'package:allmed/generated/l10n.dart';

part 'order_conform_state.dart';

class OrderConformCubit extends CoreCubit {
  OrderConformCubit()
      : _repository = sl(),
        super(
          OrderConformCommonState(false),
        );

  final OrderRepository _repository;

  Future<void> addReview(int orderId) async {
    final request = _repository.closeOrder(orderId);

    launchWithError<void, HttpRequestException>(
      request: request,
      loading: (isLoading) => emit(
        OrderConformCommonState(isLoading),
      ),
      resultData: (_) => emit(
        OrderSuccessClosed(),
      ),
      errorData: (error) => emit(
        CoreHttpErrorState(error: error.message ?? S.current.errorOccurred),
      ),
    );
  }
}
