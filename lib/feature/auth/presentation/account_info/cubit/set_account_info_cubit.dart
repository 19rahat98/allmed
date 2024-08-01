import 'package:allmed/common/core/presentation/abstract/bloc/core_cubit.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/auth/data/repository/auth_repository.dart';

part 'set_accout_info_state.dart';

class SetAccountInfoCubit extends CoreCubit {
  SetAccountInfoCubit()
      : _authRepository = sl(),
        super(SetAccountInfoCommonState());

  final AuthRepository _authRepository;

  bool _isKzCitizenship = false;

  void changeCitizenshipStatus() {
    emit(
      SetAccountInfoCommonState(
        isLoading: false,
        isKzCitizenship: _isKzCitizenship = !_isKzCitizenship,
      ),
    );
  }

  Future<void> setUserInfo(String iin, String firstName, String lastName) async {
    final request = _authRepository.setUserData(
      iin,
      firstName,
      lastName,
      citizenshipStatus: _isKzCitizenship,
    );

    await launch<void>(
      request: request,
      loading: (isLoading) => emit(
        SetAccountInfoCommonState(
          isLoading: isLoading,
          isKzCitizenship: _isKzCitizenship = !_isKzCitizenship,
        ),
      ),
      resultData: (result) => emit(
        SuccessEnterUserInfoState(),
      ),
    );
  }
}
