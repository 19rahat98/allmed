part of 'doctor_call_cubit.dart';

class DoctorCallInitial extends CoreState {
  final bool isLoading;

  DoctorCallInitial(this.isLoading);
}

class AvailableDoctorsList extends CoreState {
  final bool isLoading;
  final List<DoctorModel> doctors;

  AvailableDoctorsList(
    this.doctors, {
    this.isLoading = false,
  });

  AvailableDoctorsList copyWith({
    bool? isLoading,
    List<DoctorModel>? doctors,
    DoctorServiceModel? orderBaseInfo,
  }) {
    return AvailableDoctorsList(
      doctors ?? this.doctors,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [doctors, isLoading];
}

class EmptyAvailableListState extends CoreState {}

class OpenPaymentStepState extends CoreState {
  OpenPaymentStepState({
    required this.doctor,
    required this.orderId,
    required this.serviceData,
  });

  final int orderId;
  final DoctorModel doctor;
  final DoctorServiceModel serviceData;

  @override
  List<Object> get props => [serviceData, orderId, doctor];
}
