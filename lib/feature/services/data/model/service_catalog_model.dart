import 'package:allmed/common/contants/global_core_constants.dart';

class ServiceCatalogModel {
  ServiceCatalogModel({
    this.id = GlobalCoreConstants.zeroInt,
    this.name = GlobalCoreConstants.empty,
    this.image = GlobalCoreConstants.empty,
  });

  factory ServiceCatalogModel.fromJson(Map<String, dynamic> json) => ServiceCatalogModel(
        id: json['id'] as int? ?? GlobalCoreConstants.zeroInt,
        name: json['name'] as String? ?? GlobalCoreConstants.empty,
        image: json['full_image_url'] as String? ?? GlobalCoreConstants.empty,
      );

  static List<ServiceCatalogModel> fromJsonList(Map<String, dynamic>? jsonList) {
    final listData = jsonList?['catalogs'] as List<dynamic>? ?? [];
    return listData.map((data) => ServiceCatalogModel.fromJson(data)).toList();
  }

  String get serviceId => id.toString();

  final int id;
  final String name;
  final String image;
}
