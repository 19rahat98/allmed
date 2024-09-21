import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_loading_widget.dart';
import 'package:allmed/common/presentation/widgets/app_outline_button_widget.dart';
import 'package:allmed/common/presentation/widgets/app_snack_bar_widget.dart';
import 'package:allmed/common/presentation/widgets/app_wbox_widget.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/doctor_call_on_mode/presentation/ui/widgets/doctoc_order_card.dart';
import 'package:allmed/feature/doctor_service/data/model/doctor_dto.dart';
import 'package:allmed/feature/orders/presentation/order_conform/cubit/order_conform_cubit.dart';
import 'package:allmed/feature/orders/presentation/order_history/cubit/order_history_cubit.dart';
import 'package:allmed/feature/orders/presentation/order_rating/ui/order_review_modal.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OrderConformScreen extends StatelessWidget {
  const OrderConformScreen(
    this.doctor,
    this.service,
    this.orderId, {
    super.key,
    this.isFormHistory = false,
  });

  final int orderId;
  final bool isFormHistory;
  final DoctorModel doctor;
  final DoctorServiceModel service;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderConformCubit>(
      create: (context) => OrderConformCubit(),
      child: BlocConsumer<OrderConformCubit, CoreState>(listener: (context, state) {
        if (state is CoreHttpErrorState) {
          errorSnackBar(context, state.error);
        } else if (state is OrderSuccessClosed) {
          context.read<OrderHistoryCubit>().getOrdersList();
          if (isFormHistory) {
            Navigator.pop(context);
            successSnackBar(context, S.of(context).youClosedOrder);
            return;
          }
          Navigator.popUntil(context, ModalRoute.withName('/'));
          showOrderReviewModalSheet(context, doctor, orderId);
        }
      }, builder: (context, state) {
        final isLoading = state is OrderConformCommonState && state.isLoading;

        return AppLoadingWidget(
          isLoading: isLoading,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: AppColors.superGray,
              surfaceTintColor: AppColors.superGray,
              elevation: 0,
              automaticallyImplyLeading: false,
              actions: [
                SizedBox(
                  width: 32,
                  height: 32,
                  child: Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    color: Colors.white,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close_rounded,
                        size: 18,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
                const WBox(12),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ColoredBox(
                    color: AppColors.superGray,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            S.of(context).inspectionTime,
                            style: GoogleFonts.ubuntu(
                              fontSize: 16,
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const HBox(8),
                          Text(
                            service.orderTime,
                            style: GoogleFonts.ubuntu(
                              fontSize: 32,
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const HBox(8),
                          Text(
                            service.orderDay,
                            style: GoogleFonts.ubuntu(
                              fontSize: 16,
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          LoadingAnimationWidget.waveDots(color: AppColors.secondary, size: 74),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: AppOutlineButtonWidget(
                                borderRadiusRadii: 100,
                                borderColor: AppColors.lightGray,
                                color: Colors.white,
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.help_outlined,
                                      color: AppColors.black,
                                    ),
                                    const WBox(8),
                                    Text(
                                      S.of(context).orderProblem,
                                      style: GoogleFonts.ubuntu(
                                        fontSize: 14,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    const WBox(8),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                    child: Text(
                      S.of(context).info,
                      style: GoogleFonts.ubuntu(
                        fontSize: 20,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DoctorOrderCard(
                      doctor: doctor,
                      enableSelect: false,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.superGray,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                S.of(context).services,
                                style: GoogleFonts.ubuntu(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.gray,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                S.of(context).amount,
                                textAlign: TextAlign.end,
                                style: GoogleFonts.ubuntu(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.gray,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const HBox(8),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                service.serviceName,
                                style: GoogleFonts.ubuntu(
                                  fontSize: 16,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                service.price,
                                textAlign: TextAlign.end,
                                style: GoogleFonts.ubuntu(
                                  fontSize: 16,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomSheet: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(bottom: 30),
              child: AppOutlineButtonWidget(
                onTap: () => context.read<OrderConformCubit>().addReview(orderId),
                width: MediaQuery.of(context).size.width - 40,
                borderRadiusRadii: 100,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  S.current.closeOrder,
                  style: GoogleFonts.ubuntu(
                    fontSize: 16,
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
