import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/star_rating.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/doctor_service/data/model/doctor_dto.dart';
import 'package:allmed/feature/orders/data/model/order_model.dart';
import 'package:allmed/feature/orders/presentation/order_rating/ui/order_review_modal.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderRatingCard extends StatelessWidget {
  const OrderRatingCard(this.order, {super.key});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HBox(24),
          Text(
            S.current.rateDoctorService,
            style: GoogleFonts.ubuntu(
              fontSize: 20,
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const HBox(12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.superGray,
              borderRadius: BorderRadius.circular(8),
            ),
            child: AppStarRating(
              onRatingChanged: (_) => showOrderReviewModalSheet(
                context,
                DoctorModel(name: order.doctorName, image: order.doctorImage, active: 1),
                order.id,
              ),
              size: 24,
              rating: 0,
            ),
          ),
        ],
      ),
    );
  }
}
