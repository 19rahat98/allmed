part of 'create_password_cubit.dart';

class CreatePasswordHasError extends CoreIndexedState {
  final String errorMessage;

  CreatePasswordHasError(this.errorMessage);
}

class SuccessCreatedNewPassword extends CoreState {
  final bool isResetPassword;

  SuccessCreatedNewPassword({required this.isResetPassword});
}
