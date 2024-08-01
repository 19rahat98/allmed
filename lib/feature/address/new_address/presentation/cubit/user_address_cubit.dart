import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_cubit.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/address/user_address/data/model/addresses_dto.dart';
import 'package:allmed/feature/address/user_address/data/repository/address_repository.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

part 'user_address_state.dart';

class UserAddressCubit extends CoreCubit {
  UserAddressCubit()
      : _repository = sl(),
        super(UserAddressCommonState());

  final AddressRepository _repository;

  Point? addressPoint;

  void selectedPoint(Point? point) {
    addressPoint = point;
    emit(
      UserAddressCommonState(),
    );
  }

  Future<void> createNewAddress({
    String? address,
    String? building,
    String? apartment,
    String? entrance,
    String? intercom,
    String? floor,
    String? comment,
  }) async {
    final state = _getCommonState();
    if (address?.isEmpty ?? true) {
      emit(
        state.copyWith(addressError: S.current.fieldsRequiredToFill),
      );
      return;
    }
    if (building?.isEmpty ?? true) {
      emit(
        state.copyWith(apartmentError: S.current.fieldsRequiredToFill),
      );
      return;
    }

    final fullAddress = '$address, $building';

    final param = AddressDto(
      address: fullAddress,
      apartment: apartment ?? GlobalCoreConstants.empty,
      entrance: entrance ?? GlobalCoreConstants.empty,
      intercom: intercom ?? GlobalCoreConstants.empty,
      floor: floor ?? GlobalCoreConstants.empty,
      comment: comment ?? GlobalCoreConstants.empty,
      latitude: addressPoint?.latitude ?? GlobalCoreConstants.zeroInt,
      longitude: addressPoint?.longitude ?? GlobalCoreConstants.zeroInt,
    );
    final request = _repository.createAddress(param);

    await launch<void>(
      request: request,
      loading: (isLoading) => emit(
        state.copyWith(isLoading: isLoading),
      ),
      resultData: (result) => emit(
        AddressSuccessCreatedState(),
      ),
      errorData: (_) => emit(
        CoreHttpErrorState(error: S.current.incorrectData),
      ),
    );
  }

  Future<void> change(
    int id, {
    String? address,
    String? building,
    String? apartment,
    String? entrance,
    String? intercom,
    String? floor,
    String? comment,
  }) async {
    final state = _getCommonState();
    if (address?.isEmpty ?? true) {
      emit(
        state.copyWith(addressError: S.current.fieldsRequiredToFill),
      );
      return;
    }
    if (building?.isEmpty ?? true) {
      emit(
        state.copyWith(apartmentError: S.current.fieldsRequiredToFill),
      );
      return;
    }

    final fullAddress = '$address, $building';

    final param = AddressDto(
      address: fullAddress,
      apartment: apartment ?? GlobalCoreConstants.empty,
      entrance: entrance ?? GlobalCoreConstants.empty,
      intercom: intercom ?? GlobalCoreConstants.empty,
      floor: floor ?? GlobalCoreConstants.empty,
      comment: comment ?? GlobalCoreConstants.empty,
      latitude: addressPoint?.latitude ?? GlobalCoreConstants.zeroInt,
      longitude: addressPoint?.longitude ?? GlobalCoreConstants.zeroInt,
    );
    final request = _repository.changeAddress(param, id);

    await launch<void>(
      request: request,
      loading: (isLoading) => emit(
        state.copyWith(isLoading: isLoading),
      ),
      resultData: (result) => emit(
        AddressSuccessChangedState(),
      ),
      errorData: (_) => emit(
        CoreHttpErrorState(error: S.current.incorrectData),
      ),
    );
  }

  UserAddressCommonState _getCommonState() {
    if (state is UserAddressCommonState) {
      return state as UserAddressCommonState;
    }

    return UserAddressCommonState();
  }
}
