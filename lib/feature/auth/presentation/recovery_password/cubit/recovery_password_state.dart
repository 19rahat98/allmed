part of 'recovery_password_cubit.dart';

class RecoveryPasswordInitial extends CoreState {
  final bool isLoading;

  RecoveryPasswordInitial({this.isLoading = false});

  @override
  List<Object> get props => [isLoading];
}

class RecoveryPasswordSuccessState extends CoreState {
  final ResetPasswordResponse result;

  RecoveryPasswordSuccessState(this.result);
}
