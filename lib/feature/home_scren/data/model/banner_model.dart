import 'package:allmed/common/contants/global_core_constants.dart';

class BannerModel {
  final int id;
  final String title;
  final String createdAt;
  final String sourceUrl;
  final String description;
  final String fullImageUrl;

  const BannerModel({
    this.sourceUrl = 'https://kizdar.net/',
    this.createdAt = '30 июн 2021 в 16:46',
    this.id = GlobalCoreConstants.zeroInt,
    this.title = GlobalCoreConstants.empty,
    this.description = GlobalCoreConstants.empty,
    this.fullImageUrl = GlobalCoreConstants.empty,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      fullImageUrl: json['full_image_url'] as String,
    );
  }

  String get urlStr => 'kizdar.net';

  static List<BannerModel> fromJsonList(Map<String, dynamic> json) {
    final jsonList = json['banners'] as List<dynamic>? ?? [];
    return jsonList.map((json) => BannerModel.fromJson(json as Map<String, dynamic>)).toList();
  }
}
