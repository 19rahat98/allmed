import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_cubit.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/exception/exception.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/doctor_service/data/model/service_dto.dart';
import 'package:allmed/feature/doctor_service/data/repository/doctor_service_repository.dart';

part 'doctor_service_state.dart';

class DoctorServiceCubit extends CoreCubit {
  DoctorServiceCubit()
      : _repository = sl(),
        super(DoctorServiceInitial());

  final DoctorServiceRepository _repository;

  Future<void> getServices(String id) async {
    final request = _repository.getServiceList(id);

    await launchWithError<List<ServiceDto>, HttpRequestException>(
      request: request,
      loading: (isLoading) => emit(
        DoctorServiceInitial(),
      ),
      resultData: (result) => emit(
        DoctorServiceListState(result),
      ),
      errorData: (error) => emit(
        CoreErrorExceptionState(error: error.message ?? GlobalCoreConstants.empty),
      ),
    );
  }
}
