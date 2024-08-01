import 'package:allmed/common/contants/global_map_constants.dart';
import 'package:allmed/feature/address/new_address/data/geo_address.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart' as yandex;

class GeocoderController {
  final YandexGeocoder geocoder = YandexGeocoder(apiKey: GlobalMapConstants.yandexGeocoderApiKey);

  Future<GeoAddress> getAddressByLatLon(yandex.Point point) async {
    final GeocodeResponse geocodeFromPoint = await geocoder.getGeocode(
      ReverseGeocodeRequest(
        lang: Lang.ru,
        pointGeocode: (lat: point.latitude, lon: point.longitude),
      ),
    );

    final address = geocodeFromPoint.firstAddress?.formatted ?? 'Неизвестный адрес';
    return GeoAddress.parseAddress(address, point);
  }
}
