import 'package:allmed/common/core/presentation/abstract/bloc/core_cubit.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/exception/exception.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/orders/data/repository/order_repository.dart';
import 'package:allmed/generated/l10n.dart';

part 'order_rating_state.dart';

class OrderRatingCubit extends CoreCubit {
  OrderRatingCubit()
      : _repository = sl(),
        super(
          OrderRatingCommonState(false),
        );

  final OrderRepository _repository;

  Future<void> addReview(int orderId, double rating, String? comment) async {
    final param = {
      "comment": comment,
      "order_id": orderId,
      "rating": rating.toStringAsFixed(0),
    };
    final request = _repository.addReviewToOrder(param);

    launchWithError<void, HttpRequestException>(
      request: request,
      loading: (isLoading) => emit(
        OrderRatingCommonState(isLoading),
      ),
      resultData: (_) => emit(
        OrderRatingSuccessUploaded(),
      ),
      errorData: (error) => emit(
        CoreHttpErrorState(error: error.message ?? S.current.incorrectData),
      ),
    );
  }
}
