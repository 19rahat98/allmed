import 'package:allmed/common/contants/global_core_constants.dart';

class BannerModel {
  final int id;
  final String title;
  final String urlStr;
  final String createdAt;
  final String sourceUrl;
  final String description;
  final String fullImageUrl;

  const BannerModel({
    this.sourceUrl = 'https://allmed.kz/',
    this.createdAt = '30 июн 2021 в 16:00',
    this.id = GlobalCoreConstants.zeroInt,
    this.title = GlobalCoreConstants.empty,
    this.urlStr = GlobalCoreConstants.empty,
    this.description = GlobalCoreConstants.empty,
    this.fullImageUrl = GlobalCoreConstants.empty,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json['id'] as int,
        title: json['title'] as String,
        sourceUrl: json['link'] as String,
        urlStr: json['url_name'] as String,
        description: json['description'] as String,
        fullImageUrl: json['full_image_url'] as String,
      );

  static List<BannerModel> fromJsonList(Map<String, dynamic> json) {
    final jsonList = json['banners'] as List<dynamic>? ?? [];
    return jsonList.map((json) => BannerModel.fromJson(json as Map<String, dynamic>)).toList();
  }
}
