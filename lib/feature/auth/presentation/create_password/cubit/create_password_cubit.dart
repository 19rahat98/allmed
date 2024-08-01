import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_cubit.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/auth/data/model/global_auth_response_dto.dart';
import 'package:allmed/feature/auth/data/repository/auth_repository.dart';
import 'package:allmed/feature/auth/data/repository/global_personal_secure_data_repository.dart';
import 'package:allmed/generated/l10n.dart';

part 'create_password_state.dart';

class CreatePasswordCubit extends CoreCubit {
  CreatePasswordCubit()
      : _authRepository = sl(),
        _dataRepository = sl(),
        super(CreatePasswordHasError(GlobalCoreConstants.empty));

  final AuthRepository _authRepository;
  final GlobalPersonalSecureDataRepository _dataRepository;

  Future<void> createPassword(
    String password,
    String secondaryPassword,
    String number,
    String code, {
    bool isResetPassword = false,
  }) async {
    if (password != secondaryPassword) {
      emit(
        CreatePasswordHasError(S.current.errorRepPasswordMismatch),
      );
      return;
    }

    if (isResetPassword) {
      recoveryPassword(password, number, code);
      return;
    }

    createNewPassword(password, number, code);
  }

  Future<void> recoveryPassword(String password, String number, String token) async {
    final request = _authRepository.resetNewPassword(number, password, token);

    await launch<void>(
      request: request,
      resultData: (result) => emit(
        SuccessCreatedNewPassword(isResetPassword: true),
      ),
    );
  }

  Future<void> createNewPassword(String password, String number, String code) async {
    final request =
        _authRepository.setPassword(phoneNumber: number, password: password, token: code);

    await launch<GlobalAuthResponseTokenDTO>(
      request: request,
      resultData: (result) async {
        await _dataRepository.setAccessToken(result.access);
        await _dataRepository.setRefreshToken(result.refresh);
        emit(
          SuccessCreatedNewPassword(isResetPassword: false),
        );
      },
    );
  }
}
