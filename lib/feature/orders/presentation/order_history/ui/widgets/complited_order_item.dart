import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/doctor_service/data/model/doctor_dto.dart';
import 'package:allmed/feature/orders/data/model/order_model.dart';
import 'package:allmed/feature/orders/presentation/order_history/ui/widgets/order_history_detail.dart';
import 'package:allmed/feature/orders/presentation/order_conform/ui/order_conform_screen.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CompletedOrderItem extends StatelessWidget {
  const CompletedOrderItem(this.order, {super.key});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (order.isOrderCompleted) {
          showOrderDetailModalSheet(context, order);
          return;
        }
        pushScreen(
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
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      title: Text(
        S.current.callingTherapistIn(order.serviceTitle) + order.formattedTime,
        style: AppTextStyle.caption1.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        order.address,
        style: GoogleFonts.ubuntu(
          fontSize: 12,
          color: AppColors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Image.asset(AppIcons.icFirstAid),
    );
  }
}
