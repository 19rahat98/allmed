import 'package:allmed/common/contants/global_core_constants.dart';

class OrderRequestModel {
  final int doctorId;
  final int serviceId;
  final int addressId;
  final String day;
  final String dateTime;
  final String endDate;
  final String startDate;
  final String servicePrice;

  OrderRequestModel({
    this.day = GlobalCoreConstants.empty,
    this.dateTime = GlobalCoreConstants.empty,
    this.endDate = GlobalCoreConstants.empty,
    this.startDate = GlobalCoreConstants.empty,
    this.servicePrice = GlobalCoreConstants.empty,
    this.doctorId = GlobalCoreConstants.zeroInt,
    this.serviceId= GlobalCoreConstants.zeroInt,
    this.addressId= GlobalCoreConstants.zeroInt,
  });

  Map<String, dynamic> toJson() => {
    'choice': true,
    'day': day,
    'datetime': dateTime,
    'end_time': endDate,
    'start_time': startDate,
    'service_price': servicePrice,
    'doctor_id': doctorId,
    'service_id': serviceId,
    'address_id': addressId,
  };
}
