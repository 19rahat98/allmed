import 'package:allmed/common/core/presentation/abstract/bloc/core_cubit.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/address/user_address/data/model/addresses_dto.dart';
import 'package:allmed/feature/address/user_address/data/repository/address_repository.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:allmed/utils/extention/list_extention.dart';

part 'address_state.dart';

class AddressCubit extends CoreCubit {
  AddressCubit()
      : _repository = sl(),
        super(LoadAddressListState());

  final AddressRepository _repository;
  List<AddressDto> _addressList = [];

  Future<void> loadAddressList() async {
    final request = _repository.userAddressList();

    await launch<List<AddressDto>>(
      request: request,
      loading: (isLoading) => emit(
        UserAddressListState(addresses: _addressList, isLoading: isLoading),
      ),
      resultData: (result) {
        if (result.isEmpty) {
          emit(
            UserAddressListState(addresses: _addressList = result),
          );
        } else if (result.any((address) => address.selected)) {
          emit(
            UserAddressListState(addresses: _addressList = result),
          );
        } else {
          _addressList = result;
          changeMainAddress(_addressList.first.id);
        }
      },
      errorData: (_) => emit(
        CoreHttpErrorState(error: S.current.incorrectData),
      ),
    );
  }

  Future<void> deleteAddress(int id) async {
    final request = _repository.deleteAddress(id);

    await launch<void>(
      request: request,
      loading: (isLoading) => emit(
        UserAddressListState(addresses: _addressList, isLoading: true),
      ),
      resultData: (result) => loadAddressList(),
      errorData: (_) => emit(
        CoreHttpErrorState(error: S.current.incorrectData),
      ),
    );
  }

  Future<void> changeMainAddress(int id) async {
    final request = _repository.selectMainAddress(id);

    await launch<void>(
      request: request,
      loading: (isLoading) => emit(
        UserAddressListState(addresses: _addressList, isLoading: isLoading),
      ),
      resultData: (result) {
        _addressList = updateCheckedStatus(id, mainAddressIndex());
        emit(
          UserAddressListState(addresses: _addressList),
        );
      },
      errorData: (_) => emit(
        CoreHttpErrorState(error: S.current.incorrectData),
      ),
    );
  }

  List<AddressDto> updateCheckedStatus(int idToCheck, int idToUncheck) {
    return _addressList.map((address) {
      if (address.id == idToCheck) {
        return address.copyWith(checked: 1);
      } else if (address.id == idToUncheck) {
        return address.copyWith(checked: 0);
      }
      return address;
    }).toList();
  }

  int mainAddressIndex() => _addressList.firstWhereNull((element) => element.selected)?.id ?? 0;
}
