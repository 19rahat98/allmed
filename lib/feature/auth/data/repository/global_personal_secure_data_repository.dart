import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/auth/data/prefs/global_personal_secure_data_source.dart';

class GlobalPersonalSecureDataRepository {
  GlobalPersonalSecureDataRepository() : _dataSource = sl();

  final GlobalPersonalSecureDataSource _dataSource;

  /// получает токен пользователя
  Future<String?> get accessToken => _dataSource.accessToken;

  /// получаем refresh токен полтзователя
  Future<String?> get refreshToken => _dataSource.refreshToken;

  /// получает номер телефона пользователя
  Future<String?> get phoneNumber => _dataSource.phoneNumber;

  /// получает пароль пользователя
  Future<String?> get password => _dataSource.password;

  /// получаем пин код пользователя
  Future<String?> get pinCode => _dataSource.pinCode;

  /// сохраняем данные об использовании биометрических данных
  void setUseBiometric(bool isUseBiometric) => _dataSource.setUseBiometric(isUseBiometric);

  /// получаем флаг использует ли пользователь биометрические данные
  Future<String?> get isUseBiometric => _dataSource.isUseBiometric;

  /// получаем userName пользователя
  Future<String?> get userName => _dataSource.userName;

  Future<String?> get userEmail => _dataSource.userEmail;

  Future<String?> get userPassword => _dataSource.password;

  /// записавыет токен пользователя
  Future<void> setAccessToken(String accessToken) => _dataSource.setAccessToken(accessToken);

  void setUserName(String userName) => _dataSource.setUserName(userName);

  void setUserEmail(String userEmail) => _dataSource.setUserName(userEmail);

  /// удаляет access токен пользователя
  Future<void> removeAccessToken() => _dataSource.removeAccessToken();

  /// удаляет refresh токен пользователя
  Future<void> removeRefreshToken() => _dataSource.removeRefreshToken();

  void removeUserEmail() => _dataSource.removeUserEmail();

  /// записывает refresh токен пользователя
  Future<void> setRefreshToken(String refreshToken) => _dataSource.setRefreshToken(refreshToken);

  /// записывает email пользователя
  void setEmailNumber(String email) => _dataSource.setUserEmail(email);

  /// записывает пароль пользователя
  void setPassword(String password) => _dataSource.setPassword(password);

  /// сохраняет пин код пользователя
  void savePinCode(String pinCode) => _dataSource.savePinCode(pinCode);

/*  /// записывает данные пользователя в json
  void setUserData(GlobalAuthUser user) =>
      _dataSource.setUserData(json.encode(user.toDTO().toJson()));

  /// возвращает данные юзера в json
  Future<GlobalAuthUser> get userData async {
    final userJson = await _dataSource.userData;
    final userDTOJson =
    userJson == null ? Map<String, dynamic>() : json.decode(userJson);
    final user = GlobalAuthUser.fromDTO(
      GlobalAuthUserDTO.fromJson(userDTOJson),
    );
    return user;
  }*/

  /// удаляет все данные связянные с пользователем
  Future<void> clearAllUserData() async => _dataSource.clearAll();

  /// очищает данные аутентификации(пин код и использование биометрии)
  void cleaAuthenticationData() => _dataSource.clearPinCodeAndBiometrics();

  /// удаляет авторизационные токены (при логауте очищаются только токены)
  void clearTokens() => _dataSource.clearTokens();
}
