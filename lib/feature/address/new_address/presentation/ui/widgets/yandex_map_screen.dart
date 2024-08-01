import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/feature/address/new_address/presentation/cubit/select_address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class YandexMapScreen extends StatefulWidget {
  const YandexMapScreen({
    super.key,
    required this.startPosition,
    required this.onChangedPosition,
  });

  final Point startPosition;
  final Function(Point, bool) onChangedPosition;

  @override
  State<YandexMapScreen> createState() => _YandexMapScreenState();
}

class _YandexMapScreenState extends State<YandexMapScreen> {
  final _mapZoom = 15.0;
  late final YandexMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SelectAddressCubit, CoreState>(
      listener: (context, state) {
        if (state is JumpToUserPositionState) {
          _mapController.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: widget.startPosition, zoom: _mapZoom),
            ),
            animation: const MapAnimation(duration: 1),
          );
          return;
        }
      },
      child: YandexMap(
        onMapCreated: (controller) async {
          _mapController = controller;
          await Future.delayed(const Duration(milliseconds: 100));
          await _mapController.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: widget.startPosition, zoom: _mapZoom),
            ),
            animation: const MapAnimation(duration: 1),
          );
        },
        cameraBounds: const CameraBounds(maxZoom: 20),
        onCameraPositionChanged: (cameraPosition, reason, finished) {
          widget.onChangedPosition.call(cameraPosition.target, finished);
        },
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
