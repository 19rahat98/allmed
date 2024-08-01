import 'package:allmed/common/core/presentation/abstract/bloc/core_cubit.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/exception/exception.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/auth/data/model/global_auth_response_dto.dart';
import 'package:allmed/feature/auth/data/repository/auth_repository.dart';
import 'package:allmed/feature/auth/data/repository/global_personal_secure_data_repository.dart';
import 'package:allmed/generated/l10n.dart';

part 'sign_in_state.dart';

class SignInCubit extends CoreCubit {
  SignInCubit()
      : _authRepository = sl(),
        _dataRepository = sl(),
        super(SignInCommonState());

  final AuthRepository _authRepository;
  final GlobalPersonalSecureDataRepository _dataRepository;

  Future<void> logIn(String number, String password) async {
    final phoneNumber = '7$number';

    final request = _authRepository.login(phoneNumber, password);

    await launchWithAuthError<GlobalAuthResponseTokenDTO, HttpRequestException>(
      request: request,
      loading: (isLoading) => emit(
        SignInCommonState(isLoading: isLoading),
      ),
      resultData: (result) async {
        await _dataRepository.setAccessToken(result.access);
        await _dataRepository.setRefreshToken(result.refresh);
        emit(
          SuccessLogInState(),
        );
      },
      errorData: (error) {
        emit(
          SignInCommonState(errorMessage: ''),
        );

        emit(
          CoreHttpErrorState(error: S.current.incorrectData),
        );
      },
    );
  }
}
