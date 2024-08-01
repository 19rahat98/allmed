import 'package:allmed/common/core/presentation/abstract/bloc/core_cubit.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/exception/exception.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/auth/data/model/reset_password_response.dart';
import 'package:allmed/feature/auth/data/model/verify_number_response_dto.dart';
import 'package:allmed/feature/auth/data/repository/auth_repository.dart';

part 'conform_number_state.dart';

class ConformNumberCubit extends CoreCubit {
  ConformNumberCubit()
      : _authRepository = sl(),
        super(ConformNumberCommonState());

  final AuthRepository _authRepository;

  void verify(String number, String code, {String? resetToken}) {
    if (resetToken?.isNotEmpty ?? false) {
      recoveryPassword(number, code, resetToken!);
      return;
    }
    verifyPhone(number, code);
  }

  Future<void> verifyPhone(String number, String code) async {
    final request = _authRepository.verifyNumber(number, code);

    await launchWithError<VerifyNumberResponseDto, HttpRequestException>(
      request: request,
      loading: (isLoading) => emit(
        ConformNumberCommonState(isLoading: isLoading),
      ),
      resultData: (result) => emit(
        ConformPhoneNumberSuccess(result.token),
      ),
      errorData: (_) => emit(
        ConformNumberHasError(),
      ),
    );
  }

  Future<void> recoveryPassword(String number, String code, String resetToken) async {
    final request = _authRepository.verifyNumberRecovery(number, code, resetToken);

    await launchWithError<ResetPasswordResponse, HttpRequestException>(
      request: request,
      loading: (isLoading) => emit(
        ConformNumberCommonState(isLoading: isLoading),
      ),
      resultData: (result) => emit(
        ConformPhoneNumberSuccess(result.resetToken, isResetPassword: true),
      ),
      errorData: (_) => emit(
        ConformNumberHasError(),
      ),
    );
  }
}
