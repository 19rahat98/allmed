part of 'set_account_info_cubit.dart';

class SetAccountInfoCommonState extends CoreState {
  final bool isLoading;
  final bool isKzCitizenship;

  SetAccountInfoCommonState({this.isLoading = false, this.isKzCitizenship = false});

  @override
  List<Object> get props => [isLoading, isKzCitizenship];
}

class SuccessEnterUserInfoState extends CoreState {}