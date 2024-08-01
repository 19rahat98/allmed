import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_cubit.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/exception/exception.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/doctor_service/data/model/doctor_dto.dart';
import 'package:allmed/feature/doctor_service/data/repository/doctor_service_repository.dart';
import 'package:allmed/feature/orders/data/repository/order_repository.dart';
import 'package:allmed/generated/l10n.dart';

part 'doctor_call_state.dart';

class DoctorCallCubit extends CoreCubit {
  DoctorCallCubit()
      : _repository = sl(),
        _orderRepository = sl(),
        super(DoctorCallInitial(false));

  final OrderRepository _orderRepository;
  final DoctorServiceRepository _repository;

  List<DoctorModel> doctors = const [];
  DoctorServiceModel serviceData = const DoctorServiceModel();

  Future<void> createOrder(DoctorModel doctor) async {
    final state = _commonState();
    final request = _orderRepository.createOrderForUser(
      serviceData.createOrderByParams(doctor.id),
    );

    await launchWithError<int, HttpRequestException>(
      request: request,
      loading: (isLoading) => emit(
        state.copyWith(isLoading: isLoading),
      ),
      resultData: (result) => emit(
        OpenPaymentStepState(orderId: result, serviceData: serviceData, doctor: doctor),
      ),
      errorData: (error) => emit(
        CoreErrorExceptionState(error: error.message ?? S.current.errorOccurred),
      ),
    );
  }

  Future<void> getDoctorsList(int serviceId, int addressId, {String? date}) async {
    final request = _repository.showAvailableDoctors(serviceId, addressId, date: date);

    await launchWithError<DoctorServiceResponse, HttpRequestException>(
      request: request,
      loading: (isLoading) => emit(
        DoctorCallInitial(isLoading),
      ),
      resultData: (result) {
        if (result.doctors.isEmpty) {
          emit(EmptyAvailableListState());
          return;
        }
        serviceData = result.data;
        emit(
          AvailableDoctorsList(doctors = result.doctors),
        );
      },
      errorData: (_) => emit(
        CoreErrorExceptionState(error: GlobalCoreConstants.empty),
      ),
    );
  }

  AvailableDoctorsList _commonState() {
    if (state is AvailableDoctorsList) {
      return state as AvailableDoctorsList;
    }

    return AvailableDoctorsList(doctors);
  }
}
