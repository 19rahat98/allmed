import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/feature/home_scren/presentation/content_banner/cubit/content_banner_cubit.dart';
import 'package:allmed/feature/home_scren/presentation/content_banner/ui/newpaper_banner_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsPaperBannersWidget extends StatefulWidget {
  const NewsPaperBannersWidget({Key? key}) : super(key: key);

  @override
  State<NewsPaperBannersWidget> createState() => _NewsPaperBannersWidgetState();
}

class _NewsPaperBannersWidgetState extends State<NewsPaperBannersWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContentBannerCubit()..getBanners(),
      child: BlocBuilder<ContentBannerCubit, CoreState>(
        builder: (context, state) {
          if (state is ContentBannerLoadedState) {
            final banners = state.banners;
            return Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 24),
              child: CarouselSlider.builder(
                itemCount: banners.length,
                options: CarouselOptions(aspectRatio: 350 / 380),
                itemBuilder: (context, page, _) => NewPaperBannerItem(
                  pageIndex: page,
                  banner: banners.elementAt(page),
                ),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 24),
            child: CarouselSlider.builder(
              itemCount: 3,
              options: CarouselOptions(aspectRatio: 350 / 380),
              itemBuilder: (context, page, _) => const NewPaperBannerShimmer(),
            ),
          );
        },
      ),
    );
  }
}
