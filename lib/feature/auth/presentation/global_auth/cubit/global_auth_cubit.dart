import 'package:allmed/common/core/presentation/abstract/bloc/core_cubit.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/exception/exception.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/auth/data/repository/auth_repository.dart';
import 'package:allmed/feature/auth/data/repository/global_personal_secure_data_repository.dart';
import 'package:allmed/feature/auth/domain/entity/global_user_detail_entity.dart';
import 'package:allmed/generated/l10n.dart';

part 'global_auth_state.dart';

class GlobalAuthCubit extends CoreCubit {
  GlobalAuthCubit()
      : _authRepository = sl(),
        _personalSecureDataRepository = sl(),
        super(GlobalAuthInitial());

  final AuthRepository _authRepository;
  final GlobalPersonalSecureDataRepository _personalSecureDataRepository;

  Future<void> startAuth() async {
    final accessToken = await _personalSecureDataRepository.accessToken;
    final refreshToken = await _personalSecureDataRepository.refreshToken;
    final isHaveToken = accessToken != null || refreshToken != null;
    if (isHaveToken) {
      return checkVerifyStatus();
    }

    emit(
      GlobalAuthStartState(),
    );
  }

  Future<GlobalUserDetailEntity?> getUserDetail() async {
    GlobalUserDetailEntity? user;
    final request = _authRepository.getUserProfile();

    await launchWithError<GlobalUserDetailEntity, HttpRequestException>(
      request: request,
      resultData: (result) => user = result,
      errorData: (error) => emit(
        CoreHttpErrorState(error: error.message ?? S.current.errorOccurred),
      ),
    );

    return user;
  }

  Future<void> checkVerifyStatus() async {
    final user = await getUserDetail();
    if (user != null) {
      if (user.isFinishedRegistration) {
        emit(
          GlobalSuccessAuthState(user),
        );
        return;
      }
      emit(
        GlobalFinishAuthState(user),
      );
      return;
    }

    emit(
      GlobalAuthStartState(),
    );
  }

  Future<void> logOut() async {
    await _personalSecureDataRepository.removeAccessToken();
    await _personalSecureDataRepository.removeRefreshToken();
    emit(
      GlobalAuthStartState(),
    );
  }
}
