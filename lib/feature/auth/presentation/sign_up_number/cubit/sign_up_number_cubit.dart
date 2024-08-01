import 'package:allmed/common/core/presentation/abstract/bloc/core_cubit.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/auth/data/model/create_account_response_dto.dart';
import 'package:allmed/feature/auth/data/repository/auth_repository.dart';

part 'sign_up_number_state.dart';

class SignUpNumberCubit extends CoreCubit {
  SignUpNumberCubit()
      : _authRepository = sl(),
        super(SignInNumberCommonState());

  final AuthRepository _authRepository;

  Future<void> createNewAccountFromPhoneNUmber(String number) async {
    final phoneNumber = '7$number';

    final request = _authRepository.createNewAccount(phoneNumber);

    await launch<CreateAccountResponseDto>(
      request: request,
      loading: (isLoading) => emit(
        SignInNumberCommonState(isLoading: isLoading),
      ),
      resultData: (result) => emit(
        SuccessCreatedNewNumberState(result.phoneNumber),
      ),
    );
  }
}
