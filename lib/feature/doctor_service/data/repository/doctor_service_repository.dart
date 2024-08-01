import 'package:allmed/common/data/network/authorized_api_service.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/doctor_service/data/model/doctor_dto.dart';
import 'package:allmed/feature/doctor_service/data/model/service_dto.dart';
import 'package:allmed/feature/orders/data/model/time_slot.dart';
import 'package:allmed/utils/date_time_utils.dart';
import 'package:allmed/utils/http_call_utils.dart';

class DoctorServiceRepository {
  DoctorServiceRepository() : _authorizedApiService = sl();

  /// Частные поля для API сервисов и источника данных.
  final AuthorizedApiService _authorizedApiService;

  /// Получаем информацию о юзере
  Future<List<ServiceDto>> getServiceList(String id) async {
    return safeApiCall<List<ServiceDto>>(
      _authorizedApiService.serviceList(id),
      ServiceDto.fromJsonList,
    );
  }

  /// Получаем информацию о юзере
  Future<DoctorServiceResponse> showAvailableDoctors(int serviceId, int addressId,
      {String? date}) async {
    final data = {
      'choice': true,
      'service_id': serviceId,
      'address_id': addressId,
      'day': date ?? roundToNearest30(DateTime.now()),
    };
    return safeApiCall<DoctorServiceResponse>(
      _authorizedApiService.chooseDoctor(data),
      DoctorServiceResponse.fromJson,
    );
  }

  /// Получаем информацию о доступых слотах времений
  Future<TimeSlotResponse> showAvailableTimeSlot(int serviceId, int addressId, String day) async {
    final data = {
      'day': day,
      'choice': false,
      'service_id': serviceId,
      'address_id': addressId,
    };
    return safeApiCall<TimeSlotResponse>(
      _authorizedApiService.chooseDoctor(data),
      TimeSlotResponse.fromJson,
    );
  }
}
