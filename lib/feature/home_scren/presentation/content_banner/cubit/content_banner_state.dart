part of 'content_banner_cubit.dart';

class ContentBannerInitial extends CoreState {}

class ContentBannerLoadedState extends CoreState {
  final List<BannerModel> banners;

  ContentBannerLoadedState(this.banners);
}
