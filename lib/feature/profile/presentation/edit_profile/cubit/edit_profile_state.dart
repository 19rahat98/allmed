part of 'edit_profile_cubit.dart';

class EditProfileCommonState extends CoreState {
  final bool isLoading;

  EditProfileCommonState({this.isLoading = false});

  @override
  List<Object> get props => [isLoading];
}

class SuccessChangedUserDataState extends CoreState {}