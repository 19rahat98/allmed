import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/core/utils/mixins/request_worker_mixin.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/services/data/model/service_catalog_model.dart';
import 'package:allmed/feature/services/data/repository/services_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'service_catalog_state.dart';

class ServiceCatalogCubit extends Cubit<ServiceCatalogCoreState> with CoreRequestWorkedMixin {
  ServiceCatalogCubit()
      : _repository = sl(),
        super(ServiceCatalogCoreState());

  final ServicesRepository _repository;

  Future<void> getServiceCatalogList() async {
    final request = _repository.getServiceList();
    await launch<List<ServiceCatalogModel>>(
      request: request,
      resultData: (result) => emit(
        ServiceCatalogCoreState(catalog: result),
      ),
    );
  }
}
