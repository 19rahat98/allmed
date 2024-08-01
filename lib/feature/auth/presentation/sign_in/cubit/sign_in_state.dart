part of 'sign_in_cubit.dart';

class SignInCommonState extends CoreState {
  final bool isLoading;
  final String? errorMessage;

  SignInCommonState({this.isLoading = false, this.errorMessage});

  @override
  List<Object> get props => [isLoading, errorMessage ?? 0];
}

class SuccessLogInState extends CoreState {}
