part of 'service_catalog_cubit.dart';

class ServiceCatalogCoreState extends CoreState {
  ServiceCatalogCoreState({
    this.catalog = const [],
  });

  final List<ServiceCatalogModel> catalog;

  @override
  List<Object> get props => [catalog];
}
