import 'package:yandex_mapkit/yandex_mapkit.dart';

class GeoAddress {
  const GeoAddress({
    this.city,
    this.street,
    this.houseNumber,
    required this.country,
    this.point = const Point(longitude: 0, latitude: 0),
  });

  factory GeoAddress.parseAddress(String address, Point point) {
    final parts = address.split(',').map((part) => part.trim()).toList();
    final streetAddress = parts.length > 2 ? parts[2] : null;

    return GeoAddress(
      point: point,
      country: parts[0],
      city: parts.length > 1 ? parts[1] : null,
      street: capitalizeWords(streetAddress),
      houseNumber: parts.length > 3 ? parts[3] : null,
    );
  }

  String get formatted {
    if (street != null) {
      if (houseNumber != null) {
        return '$street, $houseNumber';
      }

      return street!;
    }
    return city ?? country;
  }

  static String? capitalizeWords(String? text) {
    if (text?.isEmpty ?? true) return text;

    return text?.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  final String country;
  final String? city;
  final String? street;
  final String? houseNumber;
  final Point point;
}
