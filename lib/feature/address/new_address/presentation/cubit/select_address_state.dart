part of 'select_address_cubit.dart';

class SelectAddressInitState extends CoreState {}

class JumpToUserPositionState extends CoreState {
  final Point startPosition;

  JumpToUserPositionState(this.startPosition);

  @override
  List<Object> get props => [startPosition];
}

class SelectAddressCommonState extends CoreState {
  SelectAddressCommonState({
    this.address,
    this.showPoint = true,
    this.startPosition = const Point(latitude: 0, longitude: 0),
  });

  /// Метод для копирования состояния с возможностью изменения некоторых значений
  SelectAddressCommonState copyWith({
    bool? showPoint,
    String? address,
    Point? startPosition,
  }) {
    return SelectAddressCommonState(
      address: address ?? this.address,
      showPoint: showPoint ?? this.showPoint,
      startPosition: startPosition ?? this.startPosition,
    );
  }

  final bool showPoint;
  final String? address;
  final Point startPosition;

  @override
  List<Object> get props => [showPoint, address ?? 0, startPosition];
}
