import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/doctor_service/data/model/doctor_dto.dart';
import 'package:allmed/feature/orders/presentation/order_conform/ui/order_conform_screen.dart';
import 'package:allmed/feature/orders/presentation/order_history/cubit/order_history_cubit.dart';
import 'package:allmed/feature/services/presentation/widgets/services_banner.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CurrentCheckBanner extends StatelessWidget {
  const CurrentCheckBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderHistoryCubit, OrderHistoryListState>(
      builder: (context, state) {
        if (!state.isHaveActualOrder) return const SizedBox();

        final order = state.lastActualOrder;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.current.currentCheckup,
                style: AppTextStyle.title1.copyWith(
                  fontSize: 18,
                  color: AppColors.black,
                ),
              ),
              const HBox(16),
              ServiceTileItem(
                onTap: () => pushScreen(
                  context,
                  withNavBar: false,
                  screen: OrderConformScreen(
                    isFormHistory: true,
                    DoctorModel(
                      name: order.doctorName,
                      image: order.doctorImage,
                      active: 1,
                      rating: order.doctorRating,
                    ),
                    DoctorServiceModel(
                      choice: true,
                      servicePrice: order.servicePrice,
                      startTime: order.startTime,
                      endTime: order.endTime,
                      serviceName: order.serviceName,
                      day: order.day,
                    ),
                    order.id,
                  ),
                ),
                title: S.current.checkoutDoctor,
                subTitle: order.orderDate,
                leading: Image.asset(AppIcons.icCheckup),
                trailingContent: Container(
                  width: 76,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    S.current.goOver,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.secondary.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
