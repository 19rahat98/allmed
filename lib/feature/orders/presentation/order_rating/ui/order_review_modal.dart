import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/widgets/app_filled_color_button.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_keyboard_dismisser.dart';
import 'package:allmed/common/presentation/widgets/app_label_textfield.dart';
import 'package:allmed/common/presentation/widgets/app_loading_widget.dart';
import 'package:allmed/common/presentation/widgets/app_snack_bar_widget.dart';
import 'package:allmed/common/presentation/widgets/star_rating.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/doctor_service/data/model/doctor_dto.dart';
import 'package:allmed/feature/orders/presentation/order_rating/cubit/order_rating_cubit.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderReviewModal extends StatefulWidget {
  const OrderReviewModal(
    this.doctor, {
    Key? key,
    required this.orderId,
  }) : super(key: key);

  final int orderId;
  final DoctorModel doctor;

  @override
  State<OrderReviewModal> createState() => _OrderReviewModalState();
}

class _OrderReviewModalState extends State<OrderReviewModal> {
  var _rating = 0.0;
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderRatingCubit>(
      create: (context) => OrderRatingCubit(),
      child: BlocConsumer<OrderRatingCubit, CoreState>(
        listener: (context, state) {
          if (state is CoreHttpErrorState) {
            errorSnackBar(context, state.error);
          } else if (state is OrderRatingSuccessUploaded) {
            Navigator.pop(context);
            successSnackBar(context, S.of(context).thankYouFirReview);
          }
        },
        builder: (context, state) {
          final isLoading = state is OrderRatingCommonState && state.isLoading;
          return AppLoadingWidget(
            isLoading: isLoading,
            child: AppKeyboardDismisser(
              child: Material(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const HBox(8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        padding: EdgeInsets.zero,
                        icon: SvgPicture.asset(AppSvgIcons.icClose),
                      ),
                    ),
                    const HBox(12),
                    CircleAvatar(
                      radius: 42,
                      backgroundImage: NetworkImage(widget.doctor.image),
                    ),
                    const HBox(16),
                    Text(
                      widget.doctor.name,
                      style: GoogleFonts.ubuntu(
                        fontSize: 16,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const HBox(56),
                    Text(
                      S.of(context).rateDoctorService,
                      style: GoogleFonts.ubuntu(
                        fontSize: 14,
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const HBox(8),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.superGray,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: AppStarRating(
                        rating: _rating,
                        size: 32,
                        spacing: 8,
                        onRatingChanged: (value) => setState(() => _rating = value),
                      ),
                    ),
                    const HBox(40),
                    AppLabelTextFieldWidget(
                      minLength: 10,
                      hintTextValue: S.current.comments,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    const HBox(40),
                    AppFilledColorButton(
                      onTap: () => context
                          .read<OrderRatingCubit>()
                          .addReview(widget.orderId, _rating, _commentController.text),
                      borderRadiusRadii: 100,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      child: Text(
                        S.current.send,
                        style: AppTextStyle.base.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const HBox(20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Future<void> showOrderReviewModalSheet(BuildContext context, DoctorModel doctor, int orderId) {
  return showModalBottomSheet<void>(
    context: context,
    elevation: 0,
    useSafeArea: true,
    useRootNavigator: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    backgroundColor: Colors.white,
    barrierColor: Colors.black.withOpacity(0.4),
    builder: (context) => OrderReviewModal(doctor, orderId: orderId),
  );
}
