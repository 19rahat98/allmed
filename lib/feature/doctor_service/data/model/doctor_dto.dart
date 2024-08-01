import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/feature/orders/data/model/order_request_model.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:intl/intl.dart';

class DoctorModel {
  final int id;
  final int integrationId;
  final String name;
  final String? phoneNumber;
  final String latitude;
  final String longitude;
  final String image;
  final String rating;
  final int active;
  final double distance;

  const DoctorModel({
    this.rating = '0',
    this.id = GlobalCoreConstants.zeroInt,
    this.integrationId = GlobalCoreConstants.zeroInt,
    this.active = GlobalCoreConstants.zeroInt,
    this.name = GlobalCoreConstants.empty,
    this.phoneNumber = GlobalCoreConstants.empty,
    this.latitude = GlobalCoreConstants.empty,
    this.longitude = GlobalCoreConstants.empty,
    this.image = GlobalCoreConstants.empty,
    this.distance = GlobalCoreConstants.zeroDouble,
  });

  bool get enable => active == 1;

  double get doctorRating => double.parse(rating);

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      rating: json['rating'] as String? ?? '0',
      id: json['id'] as int? ?? GlobalCoreConstants.zeroInt,
      integrationId: json['integration_id'] as int? ?? GlobalCoreConstants.zeroInt,
      name: json['name'] as String? ?? GlobalCoreConstants.empty,
      phoneNumber: json['phone_number'] as String? ?? GlobalCoreConstants.empty,
      latitude: json['latitude'] as String? ?? GlobalCoreConstants.empty,
      longitude: json['longitude'] as String? ?? GlobalCoreConstants.empty,
      image: json['image'] as String? ?? GlobalCoreConstants.empty,
      active: json['active'] as int? ?? GlobalCoreConstants.zeroInt,
      distance: (json['distance'] as num? ?? GlobalCoreConstants.zeroInt).toDouble(),
    );
  }
}

class DoctorServiceModel {
  final int serviceId;
  final String serviceName;
  final int addressId;
  final bool choice;
  final String servicePrice;
  final String endTime;
  final String startTime;
  final String day;
  final String dateTime;

  const DoctorServiceModel({
    this.choice = false,
    this.day = GlobalCoreConstants.empty,
    this.dateTime = GlobalCoreConstants.empty,
    this.endTime = GlobalCoreConstants.empty,
    this.startTime = GlobalCoreConstants.empty,
    this.servicePrice = GlobalCoreConstants.empty,
    this.serviceId = GlobalCoreConstants.zeroInt,
    this.serviceName = GlobalCoreConstants.empty,
    this.addressId = GlobalCoreConstants.zeroInt,
  });

  OrderRequestModel createOrderByParams(int doctorId) => OrderRequestModel(
        doctorId: doctorId,
        day: day,
        endDate: endTime,
        dateTime: dateTime,
        serviceId: serviceId,
        addressId: addressId,
        startDate: startTime,
        servicePrice: servicePrice,
      );

  factory DoctorServiceModel.fromJson(Map<String, dynamic> json) {
    return DoctorServiceModel(
      choice: json['choice'] as bool,
      serviceId: json['service_id'] as int,
      addressId: json['address_id'] as int,
      serviceName: json['service_name'] as String? ?? 'Терапевт',
      day: json['day'] as String? ?? GlobalCoreConstants.empty,
      dateTime: json['datetime'] as String? ?? GlobalCoreConstants.empty,
      servicePrice: json['service_price'] as String? ?? GlobalCoreConstants.empty,
      endTime: json['end_time'] as String? ?? GlobalCoreConstants.empty,
      startTime: json['start_time'] as String? ?? GlobalCoreConstants.empty,
    );
  }

  String get orderDay {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    final todayDate = formatter.format(now);
    if (todayDate == day) {
      return S.current.today;
    }

    return day;
  }

  String get orderTime => '$startTime-$endTime';

  String get price => '$servicePrice тг.';
}

class DoctorServiceResponse {
  final DoctorServiceModel data;
  final List<DoctorModel> doctors;

  DoctorServiceResponse({
    this.doctors = const [],
    this.data = const DoctorServiceModel(),
  });

  factory DoctorServiceResponse.fromJson(Map<String, dynamic> json) => DoctorServiceResponse(
        data: DoctorServiceModel.fromJson(json['data'] as Map<String, dynamic>),
        doctors: (json['doctors'] as List<dynamic>? ?? const [])
            .map(
              (doctorJson) => DoctorModel.fromJson(doctorJson as Map<String, dynamic>),
            )
            .toList(),
      );
}
