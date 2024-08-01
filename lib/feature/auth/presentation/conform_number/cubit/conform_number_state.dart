part of 'conform_number_cubit.dart';

class ConformNumberCommonState extends CoreIndexedState {
  final bool isLoading;

  ConformNumberCommonState({this.isLoading = false});
}

class ConformNumberHasError extends CoreIndexedState {}

class ConformPhoneNumberSuccess extends CoreState {
  final String token;
  final bool isResetPassword;

  ConformPhoneNumberSuccess(this.token, {this.isResetPassword = false});
}
