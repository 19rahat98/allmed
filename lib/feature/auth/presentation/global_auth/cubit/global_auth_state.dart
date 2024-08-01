part of 'global_auth_cubit.dart';

class GlobalAuthInitial extends CoreState {}

class GlobalAuthStartState extends CoreState {}

class GlobalSuccessAuthState extends CoreState {
  final GlobalUserDetailEntity userDetail;

  GlobalSuccessAuthState(this.userDetail);

  @override
  List<Object> get props => [userDetail];
}

class GlobalFinishAuthState extends CoreState {
  final GlobalUserDetailEntity userDetail;

  GlobalFinishAuthState(this.userDetail);
}

class GlobalAuthLogOutState extends CoreState {}
