import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_cubit.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/auth/data/repository/auth_repository.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends CoreCubit {
  EditProfileCubit()
      : _authRepository = sl(),
        super(EditProfileCommonState());

  final AuthRepository _authRepository;

  Future<void> updateUserData(
    String name,
    String lastName, {
    String middleName = GlobalCoreConstants.empty,
    String bdy = GlobalCoreConstants.empty,
    String gender = GlobalCoreConstants.empty,
    String iin = GlobalCoreConstants.empty,
  }) async {
    final request = _authRepository.updateUserData(name, lastName,
        middleName: middleName, bdy: bdy, gender: gender, iin: iin);

    await launch<void>(
      request: request,
      loading: (isLoading) => emit(
        EditProfileCommonState(isLoading: isLoading),
      ),
      resultData: (result) => emit(
        SuccessChangedUserDataState(),
      ),
    );
  }
}
