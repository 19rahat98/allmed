import 'package:allmed/common/core/presentation/abstract/bloc/core_cubit.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/auth/data/model/reset_password_response.dart';
import 'package:allmed/feature/auth/data/repository/auth_repository.dart';

part 'recovery_password_state.dart';

class RecoveryPasswordCubit extends CoreCubit {
  RecoveryPasswordCubit()
      : _repository = sl(),
        super(RecoveryPasswordInitial());

  final AuthRepository _repository;

  Future<void> recoveryPassword(String number) async {
    final phoneNumber = '7$number';

    final request = _repository.recoveryPassword(phoneNumber);

    await launch<ResetPasswordResponse>(
      request: request,
      loading: (isLoading) => emit(
        RecoveryPasswordInitial(isLoading: isLoading),
      ),
      resultData: (result) => emit(
        RecoveryPasswordSuccessState(result),
      ),
    );
  }
}
