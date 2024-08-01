import 'package:allmed/common/contants/global_dio_constant.dart';
import 'package:allmed/common/contants/global_network_constant.dart';
import 'package:allmed/common/data/network/authorized_api_service.dart';
import 'package:allmed/common/data/network/core_network.dart';
import 'package:allmed/common/data/network/unauthorized_api_service.dart';
import 'package:allmed/feature/address/new_address/data/geocoder_controller.dart';
import 'package:allmed/feature/address/user_address/data/repository/address_repository.dart';
import 'package:allmed/feature/auth/data/prefs/global_personal_secure_data_source.dart';
import 'package:allmed/feature/auth/data/repository/auth_repository.dart';
import 'package:allmed/feature/auth/data/repository/global_personal_secure_data_repository.dart';
import 'package:allmed/feature/doctor_service/data/repository/doctor_service_repository.dart';
import 'package:allmed/feature/home_scren/data/repository/content_repository.dart';
import 'package:allmed/feature/orders/data/repository/order_repository.dart';
import 'package:allmed/feature/payment/data/repository/payment_repository.dart';
import 'package:allmed/feature/services/data/repository/services_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initLocator() async {
  _commonModule();
  _apiServiceModule();
  await _dataSourceModule();
  _repositoryModule();
  _registerAuthorizedHttpClient();
  _useCaseModule();
}

void supportDiModule() {}

/// для общих зависимостей
void _commonModule() {
  /// Shared preferences
  final sharedPreferences = SharedPreferences.getInstance();
  sl
    ..registerSingletonAsync(() => sharedPreferences)
    ..registerSingleton(const FlutterSecureStorage())
    ..registerSingletonAsync(
      () => createHttpClient(GlobalNetworkConstant.apiUrl),
    );
}

void _apiServiceModule() {
  /// для неавторизованной зоны
  sl.registerSingleton(
    UnauthorizedApiService(sl.getAsync()),
  );
}

/// для локального хранения данных
Future<void> _dataSourceModule() async {
  sl.registerSingleton(GlobalPersonalSecureDataSource());
}

/// для репозиторий
void _repositoryModule() {
  sl
    ..registerFactory(AuthRepository.new)
    ..registerFactory(ContentRepository.new)
    ..registerFactory(AddressRepository.new)
    ..registerFactory(OrderRepository.new)
    ..registerFactory(PaymentRepository.new)
    ..registerFactory(ServicesRepository.new)
    ..registerFactory(DoctorServiceRepository.new)
    ..registerFactory(GlobalPersonalSecureDataRepository.new);
}

/// для useCase
void _useCaseModule() {
  sl.registerFactory(GeocoderController.new);
}

void _registerAuthorizedHttpClient() {
  sl
    ..registerSingletonAsync(
      () => createAuthorizedHttpClient(GlobalNetworkConstant.apiUrl),
      instanceName: GlobalDioConstant.authorized,
    )

    /// для авторизованной зоны
    ..registerSingleton(
      AuthorizedApiService(
        sl.getAsync(
          instanceName: GlobalDioConstant.authorized,
        ),
      ),
    );
}
