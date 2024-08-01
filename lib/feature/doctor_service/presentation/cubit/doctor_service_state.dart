part of 'doctor_service_cubit.dart';

class DoctorServiceInitial extends CoreState {}

class DoctorServiceListState extends CoreState {
  final List<ServiceDto> services;

  DoctorServiceListState(this.services);

  @override
  List<Object> get props => [services];
}
