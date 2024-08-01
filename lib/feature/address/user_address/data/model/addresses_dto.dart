import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/feature/address/new_address/data/geo_address.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class AddressDto {
  AddressDto({
    this.id = GlobalCoreConstants.zeroInt,
    this.cityId = GlobalCoreConstants.zeroInt,
    this.userId = GlobalCoreConstants.zeroInt,
    this.address = GlobalCoreConstants.empty,
    this.latitude = GlobalCoreConstants.zeroInt,
    this.longitude = GlobalCoreConstants.zeroInt,
    this.apartment = GlobalCoreConstants.empty,
    this.entrance = GlobalCoreConstants.empty,
    this.intercom = GlobalCoreConstants.empty,
    this.floor = GlobalCoreConstants.empty,
    this.checked = GlobalCoreConstants.zeroInt,
    this.active = GlobalCoreConstants.zeroInt,
    this.comment = GlobalCoreConstants.empty,
    this.createdAt = GlobalCoreConstants.empty,
    this.updatedAt = GlobalCoreConstants.empty,
  });

  factory AddressDto.fromGeoAddress(GeoAddress? address) => AddressDto(
        address: address?.formatted ?? GlobalCoreConstants.empty,
        latitude: address?.point.latitude ?? 0,
        longitude: address?.point.longitude ?? 0,
      );

  factory AddressDto.fromJson(Map<String, dynamic> json) => AddressDto(
        id: json['id'] as int? ?? GlobalCoreConstants.zeroInt,
        cityId: json['city_id'] as int? ?? GlobalCoreConstants.zeroInt,
        userId: json['user_id'] as int? ?? GlobalCoreConstants.zeroInt,
        checked: json['checked'] as int? ?? GlobalCoreConstants.zeroInt,
        active: json['active'] as int? ?? GlobalCoreConstants.zeroInt,
        address: json['address'] as String? ?? GlobalCoreConstants.empty,
        apartment: json['apartment'] as String? ?? GlobalCoreConstants.empty,
        intercom: json['intercom'] as String? ?? GlobalCoreConstants.empty,
        entrance: json['entrance'] as String? ?? GlobalCoreConstants.empty,
        floor: json['floor'] as String? ?? GlobalCoreConstants.empty,
        comment: json['comment'] as String? ?? GlobalCoreConstants.empty,
        createdAt: json['created_at'] as String? ?? GlobalCoreConstants.empty,
        updatedAt: json['created_at'] as String? ?? GlobalCoreConstants.empty,
        latitude: num.tryParse(json['latitude'] as String? ?? '0') ?? GlobalCoreConstants.zeroInt,
        longitude: num.tryParse(json['longitude'] as String? ?? '0') ?? GlobalCoreConstants.zeroInt,
      );

  Point get point =>Point(latitude: latitude.toDouble(), longitude: longitude.toDouble());

  AddressDto copyWith({
    int? id,
    int? cityId,
    int? userId,
    String? address,
    num? latitude,
    num? longitude,
    String? apartment,
    String? entrance,
    String? intercom,
    String? floor,
    int? checked,
    int? active,
    String? comment,
    String? createdAt,
    String? updatedAt,
  }) {
    return AddressDto(
      id: id ?? this.id,
      cityId: cityId ?? this.cityId,
      userId: userId ?? this.userId,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      apartment: apartment ?? this.apartment,
      entrance: entrance ?? this.entrance,
      intercom: intercom ?? this.intercom,
      floor: floor ?? this.floor,
      checked: checked ?? this.checked,
      active: active ?? this.active,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'apartment': apartment,
      'entrance': entrance,
      'intercom': intercom,
      'floor': floor,
      'checked': checked,
      'active': active,
      'comment': comment,
    };
  }

  final int id;
  final int cityId;
  final int userId;
  final String address;
  final num latitude;
  final num longitude;
  final String apartment;
  final String entrance;
  final String intercom;
  final String floor;
  final int checked;
  final int active;
  final String comment;
  final String createdAt;
  final String updatedAt;

  String get additional {
    String additionalAddress = '';
    if (apartment != GlobalCoreConstants.empty) {
      additionalAddress += '$apartment ${S.current.appartamnet}';
    }
    if (entrance != GlobalCoreConstants.empty) {
      if (additionalAddress.isNotEmpty) {
        additionalAddress += ',$entrance ${S.current.entrance}';
      } else {
        additionalAddress += '$entrance ${S.current.entrance}';
      }
    }
    if (intercom != GlobalCoreConstants.empty) {
      if (additionalAddress.isNotEmpty) {
        additionalAddress += ',$intercom ${S.current.intercom}';
      } else {
        additionalAddress += '$intercom ${S.current.intercom}';
      }
    }
    if (floor != GlobalCoreConstants.empty) {
      if (additionalAddress.isNotEmpty) {
        additionalAddress += ',$floor ${S.current.floor}';
      } else {
        additionalAddress += '$floor ${S.current.floor}';
      }
    }
    return additionalAddress;
  }

  List<String> get formedAddress => address.split(',');

  bool get selected => checked == 1;

  static List<AddressDto> fromJsonList(Map<String, dynamic> json) {
    final list = json['addresses'] as List<dynamic>? ?? [];
    return list.map((e) => AddressDto.fromJson(e as Map<String, dynamic>)).toList();
  }
}
