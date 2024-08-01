part of 'address_cubit.dart';

class LoadAddressListState extends CoreState {}

class UserAddressListState extends CoreState {
  final bool isLoading;
  final List<AddressDto> addresses;

  UserAddressListState({
    this.addresses = const [],
    this.isLoading = false,
  });

  bool get isEmpty => addresses.isEmpty;

  AddressDto? get mainAddress => addresses.firstWhereNull((element) => element.selected);

  @override
  List<Object> get props => [addresses,isLoading];
}
