import 'package:allmed/common/presentation/widgets/app_filled_color_button.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_shimmer_widget.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/home_scren/data/model/banner_model.dart';
import 'package:allmed/feature/home_scren/presentation/content_banner/ui/banner_content_screen.dart';
import 'package:allmed/feature/home_scren/presentation/content_banner/ui/banner_indicator_widget.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class NewPaperBannerItem extends StatelessWidget {
  const NewPaperBannerItem({super.key, required this.pageIndex, required this.banner});

  final int pageIndex;
  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGray),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(banner.fullImageUrl),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 8, 26),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.0), // Transparent at the top
                  AppColors.rdBlack.withOpacity(0.3),
                ],
              ),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BannerIndicatorWidget(pageIndex),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          banner.title,
                          style: AppTextStyle.title1,
                        ),
                        const HBox(16),
                        AppFilledColorButton(
                          onTap: () => pushScreen(
                            context,
                            screen: BannerContentScreen(banner),
                          ),
                          width: 120,
                          color: Colors.white,
                          borderRadiusRadii: 100,
                          child: Text(
                            S.current.moreDetailed,
                            style: AppTextStyle.base,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NewPaperBannerShimmer extends StatelessWidget {
  const NewPaperBannerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 8, 26),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, AppColors.lightGray.withOpacity(0.5)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGray),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const BannerIndicatorWidget(0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 200,
                    height: 12,
                    child: AppShimmerWidget(),
                  ),
                  const HBox(16),
                  SizedBox(
                    width: 120,
                    height: 40,
                    child: AppShimmerWidget(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
