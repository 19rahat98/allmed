import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/data/network/authorized_api_service.dart';
import 'package:allmed/common/data/network/unauthorized_api_service.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/auth/data/model/create_account_response_dto.dart';
import 'package:allmed/feature/auth/data/model/global_auth_response_dto.dart';
import 'package:allmed/feature/auth/data/model/reset_password_response.dart';
import 'package:allmed/feature/auth/data/model/verify_number_response_dto.dart';
import 'package:allmed/feature/auth/data/repository/global_personal_secure_data_repository.dart';
import 'package:allmed/feature/auth/domain/entity/global_auth_reponse_entity.dart';
import 'package:allmed/feature/auth/domain/entity/global_user_detail_entity.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:allmed/utils/http_call_utils.dart';

/// Класс AuthRepository обрабатывает различные запросы,
/// связанные с аутентификацией и управлением учетными данными пользователя.
class AuthRepository {
  AuthRepository()
      : _apiService = sl(),
        _authorizedApiService = sl(),
        _personalSecureDataRepository = sl();

  /// Частные поля для API сервисов и источника данных.
  final UnauthorizedApiService _apiService;
  final AuthorizedApiService _authorizedApiService;
  final GlobalPersonalSecureDataRepository _personalSecureDataRepository;

  /// Получаем информацию о юзере
  Future<GlobalUserDetailEntity> getUserProfile() async {
    return safeApiCall<GlobalUserDetailEntity>(
      _authorizedApiService.getProfile(),
      GlobalUserDetailEntity.fromJson,
    );
  }

  /// обновление токена
  Future<GlobalAccessToken> refreshToken() async {
    final token = await _personalSecureDataRepository.refreshToken;
    final request = await safeApiCall<GlobalAuthResponseTokenDTO>(
      _apiService.refreshToken(token ?? GlobalCoreConstants.empty),
      GlobalAuthResponseTokenDTO.fromJson,
    );
    return GlobalAccessToken.fromDTO(request);
  }

  Future<CreateAccountResponseDto> createNewAccount(String phoneNumber) async {
    final param = {'phone_number': phoneNumber};
    return safeApiCall<CreateAccountResponseDto>(
      _apiService.registrationNewPhoneNumber(param),
      CreateAccountResponseDto.fromJson,
    );
  }

  Future<ResetPasswordResponse> recoveryPassword(String phoneNumber) async {
    final param = {'phone_number': phoneNumber};
    return safeApiCall<ResetPasswordResponse>(
      _apiService.resetPassword(param),
      ResetPasswordResponse.fromJson,
    );
  }

  /// Подтверждаем номер телефона
  Future<VerifyNumberResponseDto> verifyNumber(String phoneNumber, String smsCode) async {
    final param = {'phone_number': phoneNumber, 'sms_code': smsCode};
    return safeApiCall<VerifyNumberResponseDto>(
      _apiService.verifyPhoneNumber(param),
      VerifyNumberResponseDto.fromJson,
    );
  }

  /// Подтверждаем номер телефона
  Future<ResetPasswordResponse> verifyNumberRecovery(
      String number, String smsCode, String token) async {
    final param = {'phone_number': number, 'sms_code': smsCode, 'resetToken': token};
    return safeApiCall<ResetPasswordResponse>(
      _apiService.verifyPhoneNumberForRecovery(param),
      ResetPasswordResponse.fromJson,
    );
  }

  /// Подтверждаем номер телефона
  Future<void> resetNewPassword(String number, String password, String token) async {
    final param = {
      'phone_number': number,
      'resetToken': token,
      'password': password,
      'conf_password': password,
    };
    return safeApiCallVoid(_apiService.resetNewPassword(param));
  }

  /// Заполняем данные юзера
  Future<void> setUserData(
    String iin,
    String name,
    String lastName, {
    bool citizenshipStatus = false,
  }) async {
    final param = {
      'name': name,
      'last_name': lastName,
      'in_kz': citizenshipStatus,
      'iin': citizenshipStatus ? '0' : iin,
    };
    return safeApiCallVoid(
      _authorizedApiService.setUserInfo(param),
    );
  }

  /// Меняем данные юзера
  Future<void> updateUserData(
    String name,
    String lastName, {
    String middleName = GlobalCoreConstants.empty,
    String bdy = GlobalCoreConstants.empty,
    String gender = GlobalCoreConstants.empty,
    String iin = GlobalCoreConstants.empty,
  }) async {
    final sex = gender == GlobalCoreConstants.empty
        ? 0
        : gender == S.current.male
            ? 1
            : 2;
    final param = {
      'iin': iin,
      'bdy': bdy,
      'name': name,
      'gender': sex,
      'last_name': lastName,
      'middle_name': middleName,
    };
    return safeApiCallVoid(
      _authorizedApiService.updateUserProfile(param),
    );
  }

  Future<GlobalAuthResponseTokenDTO> setPassword({
    required String token,
    required String password,
    required String phoneNumber,
  }) async {
    final param = {
      'token': token,
      'password': password,
      'conf_password': password,
      'phone_number': phoneNumber,
    };
    return safeApiCall<GlobalAuthResponseTokenDTO>(
      _apiService.setPassword(param),
      GlobalAuthResponseTokenDTO.fromJson,
    );
  }

  /// Метод для логина, получаем токен для авторизации
  Future<GlobalAuthResponseTokenDTO> login(String phoneNumber, String password) async {
    final param = {
      'password': password,
      'phone_number': phoneNumber,
    };
    return safeApiCall<GlobalAuthResponseTokenDTO>(
      _apiService.login(param),
      GlobalAuthResponseTokenDTO.fromJson,
    );
  }
}
