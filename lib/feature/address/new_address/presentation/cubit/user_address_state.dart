part of 'user_address_cubit.dart';

class UserAddressCommonState extends CoreState {
  final bool isLoading;
  final String? addressError;
  final String? apartmentError;

  UserAddressCommonState({
    this.addressError,
    this.apartmentError,
    this.isLoading = false,
  });

  UserAddressCommonState copyWith({
    bool? isLoading,
    bool? enableFields,
    String? addressError,
    String? apartmentError,
  }) =>
      UserAddressCommonState(
        addressError: addressError,
        apartmentError: apartmentError,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object> get props => [isLoading, addressError ?? 0, apartmentError ?? 0];
}

class AddressSuccessCreatedState extends CoreState {}


class AddressSuccessChangedState extends CoreState {}
