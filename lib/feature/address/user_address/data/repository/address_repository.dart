import 'package:allmed/common/data/network/authorized_api_service.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/address/user_address/data/model/addresses_dto.dart';
import 'package:allmed/utils/http_call_utils.dart';

class AddressRepository {
  AddressRepository() : _authorizedApiService = sl();

  final AuthorizedApiService _authorizedApiService;

  Future<List<AddressDto>> userAddressList() async {
    return safeApiCall<List<AddressDto>>(
      _authorizedApiService.getAddressList(),
      AddressDto.fromJsonList,
    );
  }

  Future<void> selectMainAddress(int id) async {
    final param = {'id': id};
    return safeApiCallVoid(
      _authorizedApiService.selectAddress(param),
    );
  }

  Future<void> createAddress(AddressDto data) async {
    return safeApiCallVoid(
      _authorizedApiService.createNewAddress(data.toJson()),
    );
  }

  Future<void> changeAddress(AddressDto data, int id) async {
    return safeApiCallVoid(
      _authorizedApiService.changeAddressInfo(
        id,
        data.toJson(),
      ),
    );
  }

  Future<void> deleteAddress(int id) async {
    return safeApiCallVoid(
      _authorizedApiService.deleteAddressById(id),
    );
  }
}
