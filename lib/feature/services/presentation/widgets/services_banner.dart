import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_shimmer_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/doctor_service/presentation/ui/doctor_service_screen.dart';
import 'package:allmed/feature/services/presentation/cubit/service_catalog_cubit.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ServicesBanner extends StatelessWidget {
  const ServicesBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServiceCatalogCubit()..getServiceCatalogList(),
      child: BlocBuilder<ServiceCatalogCubit, ServiceCatalogCoreState>(
        builder: (context, state) {
          if (state.catalog.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.current.services,
                    style: AppTextStyle.title1.copyWith(
                      fontSize: 18,
                      color: AppColors.black,
                    ),
                  ),
                  ListView.separated(
                    itemCount: 2,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 16),
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, _) => const HBox(16),
                    itemBuilder: (context, _) => SizedBox(
                      height: 72,
                      child: AppShimmerWidget(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.current.services,
                  style: AppTextStyle.title1.copyWith(
                    fontSize: 18,
                    color: AppColors.black,
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.catalog.length,
                  padding: const EdgeInsets.only(top: 16),
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, _) => const HBox(16),
                  itemBuilder: (context, index) {
                    final item = state.catalog.elementAt(index);
                    if (index == 0) {
                      return ServiceTileItem(
                        onTap: () => pushScreen(
                          context,
                          screen: DoctorServiceScreen(item.serviceId),
                          withNavBar: false,
                        ),
                        title: item.name,
                        iconPath: item.image,
                        subTitle: S.current.houseCall,
                        trailingContent: Container(
                          width: 60,
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.current.find,
                                style: AppTextStyle.secondary.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                                color: AppColors.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return ServiceTileItem(
                      onTap: () => pushScreen(
                        context,
                        screen: DoctorServiceScreen(item.serviceId),
                        withNavBar: false,
                      ),
                      title: item.name,
                      iconPath: item.image,
                      subTitle: S.current.serviceProcessOnHome,
                      trailingContent: Container(
                        width: 60,
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.current.find,
                              style: AppTextStyle.secondary.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 14,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ServiceTileItem extends StatelessWidget {
  const ServiceTileItem({
    Key? key,
    required this.onTap,
    required this.title,
    required this.subTitle,
    this.trailingContent,
    this.leading,
    this.iconPath = AppIcons.icFirstAid,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final String iconPath;
  final Function() onTap;
  final Widget? leading;
  final Widget? trailingContent;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: onTap,
      tileColor: AppColors.superGray,
      splashColor: AppColors.secondary.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      title: Text(
        title,
        style: AppTextStyle.title2.copyWith(fontSize: 16),
      ),
      trailing: trailingContent,
      leading: leading ?? Image.network(iconPath),
      subtitle: Text(subTitle, style: AppTextStyle.secondary),
    );
  }
}
