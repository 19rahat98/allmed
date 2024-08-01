import 'package:allmed/common/core/presentation/abstract/bloc/core_cubit.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/home_scren/data/model/banner_model.dart';
import 'package:allmed/feature/home_scren/data/repository/content_repository.dart';

part 'content_banner_state.dart';

class ContentBannerCubit extends CoreCubit {
  ContentBannerCubit()
      : _repository = sl(),
        super(ContentBannerInitial());

  final ContentRepository _repository;

  Future<void> getBanners() async {
    final request = _repository.getBanners();
    await launch(
      request: request,
      resultData: (banners) => emit(
        ContentBannerLoadedState(banners),
      ),
    );
  }
}
