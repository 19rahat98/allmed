import 'package:allmed/common/data/network/authorized_api_service.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/services/data/model/service_catalog_model.dart';
import 'package:allmed/utils/http_call_utils.dart';

class ServicesRepository {
  ServicesRepository() : _authorizedApiService = sl();

  final AuthorizedApiService _authorizedApiService;

  Future<List<ServiceCatalogModel>> getServiceList() async {
    return safeApiCall<List<ServiceCatalogModel>>(
      _authorizedApiService.serviceCatalog(),
      ServiceCatalogModel.fromJsonList,
    );
  }
}
