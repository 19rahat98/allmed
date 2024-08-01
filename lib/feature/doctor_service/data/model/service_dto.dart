import 'package:allmed/common/contants/global_core_constants.dart';

class ServiceDto {
  final int id;
  final int active;
  final int integrationId;
  final String name;
  final String price;
  final String image;
  final String createdAt;
  final String updatedAt;

  ServiceDto({
    this.id = GlobalCoreConstants.zeroInt,
    this.integrationId = GlobalCoreConstants.zeroInt,
    this.active = GlobalCoreConstants.zeroInt,
    this.name = GlobalCoreConstants.empty,
    this.price = GlobalCoreConstants.empty,
    this.image = GlobalCoreConstants.empty,
    this.createdAt = GlobalCoreConstants.empty,
    this.updatedAt = GlobalCoreConstants.empty,
  });

  factory ServiceDto.fromJson(Map<String, dynamic> json) {
    return ServiceDto(
      id: json['id'] as int? ?? GlobalCoreConstants.zeroInt,
      active: json['active'] as int? ?? GlobalCoreConstants.zeroInt,
      integrationId: json['integration_id'] as int? ?? GlobalCoreConstants.zeroInt,
      name: json['name'] as String? ?? GlobalCoreConstants.empty,
      price: json['price'] as String? ?? GlobalCoreConstants.empty,
      image: json['image'] as String? ?? GlobalCoreConstants.empty,
      createdAt: json['created_at'] as String? ?? GlobalCoreConstants.empty,
      updatedAt: json['updated_at'] as String? ?? GlobalCoreConstants.empty,
    );
  }

  String get expectedPrice => '$price тг.';

  static List<ServiceDto> fromJsonList(Map<String, dynamic> json) {
    var list = json['services'] as List?;
    return list?.map((i) => ServiceDto.fromJson(i)).toList() ?? [];
  }
}
