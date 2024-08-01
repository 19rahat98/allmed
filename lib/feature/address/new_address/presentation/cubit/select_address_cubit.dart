import 'dart:developer';

import 'package:allmed/common/contants/global_map_constants.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_cubit.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/address/new_address/data/geo_address.dart';
import 'package:allmed/feature/address/new_address/data/geocoder_controller.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:geolocator/geolocator.dart';

part 'select_address_state.dart';

class SelectAddressCubit extends CoreCubit {
  SelectAddressCubit()
      : _geocoderController = sl(),
        super(SelectAddressInitState());

  String? _address;
  GeoAddress? geoAddress;
  final GeocoderController _geocoderController;
  Point position = const Point(latitude: 0, longitude: 0);

  Future<void> initCubit() async {
    position = await getCurrentLocation();
    if (position.latitude == 0 || position.longitude == 0) {
      position = GlobalMapConstants.almatyStartPoint;
    }

    geoAddress = await _geocoderController.getAddressByLatLon(position);

    emit(
      SelectAddressCommonState(
        showPoint: false,
        startPosition: position,
        address: _address = geoAddress?.formatted,
      ),
    );
  }

  Future<void> jumpToUserPosition() async {
    final userPoint = await getCurrentLocation();
    if (userPoint == position || userPoint.latitude == 0 || userPoint.longitude == 0) return;
    position = userPoint;
    emit(
      JumpToUserPositionState(position),
    );
  }

  Future<Point> getCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        log('Location services are disabled.', name: 'Geolocation: ');
        return const Point(latitude: 0, longitude: 0);
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          log('Location permissions are denied', name: 'Geolocation: ');
          return const Point(latitude: 0, longitude: 0);
        }
      }

      if (permission == LocationPermission.deniedForever) {
        log(
          'Location permissions are permanently denied, we cannot request permissions.',
          name: 'Geolocation: ',
        );

        return const Point(latitude: 0, longitude: 0);
      }

      // When we reach here, permissions are granted and we can continue accessing the position of the device.
      final position = await Geolocator.getLastKnownPosition();
      return Point(latitude: position?.latitude ?? 0, longitude: position?.longitude ?? 0);
    } catch (e) {
      return const Point(latitude: 0, longitude: 0);
    }
  }

  Future<void> changePoint(Point point, bool isFinished) async {
    if (isFinished) {
      position = point;
      geoAddress = await _geocoderController.getAddressByLatLon(position);

      final state = _getCommonState();
      emit(
        state.copyWith(
          showPoint: false,
          address: _address = geoAddress?.formatted,
        ),
      );
      return;
    }
    _address = null;
    emit(
      _getCommonState().copyWith(showPoint: true),
    );
  }

  SelectAddressCommonState _getCommonState() {
    if (state is SelectAddressCommonState) {
      return state as SelectAddressCommonState;
    }

    return SelectAddressCommonState(address: _address, showPoint: _address == null);
  }
}
