part of 'sign_up_number_cubit.dart';

class SignInNumberCommonState extends CoreState {
  final bool isLoading;

  SignInNumberCommonState({this.isLoading = false});

  @override
  List<Object> get props => [isLoading];
}

class SuccessCreatedNewNumberState extends CoreIndexedState {
  final String phoneNumber;

  SuccessCreatedNewNumberState(this.phoneNumber);
}
