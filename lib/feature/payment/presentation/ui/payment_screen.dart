import 'dart:math' as math;

import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/widgets/app_bars/common_app_bar.dart';
import 'package:allmed/common/presentation/widgets/app_filled_color_button.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_loading_widget.dart';
import 'package:allmed/common/presentation/widgets/app_snack_bar_widget.dart';
import 'package:allmed/common/presentation/widgets/app_wbox_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/doctor_service/data/model/doctor_dto.dart';
import 'package:allmed/feature/orders/presentation/order_conform/ui/order_conform_screen.dart';
import 'package:allmed/feature/payment/data/model/user_card_model.dart';
import 'package:allmed/feature/payment/presentation/cubit/payment_cubit.dart';
import 'package:allmed/feature/payment/presentation/ui/widgets/add_new_card_modal.dart';
import 'package:allmed/feature/payment/presentation/ui/widgets/add_payment_method_button.dart';
import 'package:allmed/feature/payment/presentation/ui/widgets/payment_item_card.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    super.key,
    required this.orderId,
    required this.doctorData,
    this.service = const DoctorServiceModel(),
  });

  final int orderId;
  final DoctorModel doctorData;
  final DoctorServiceModel service;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentCubit()..getUserCards(widget.orderId),
      child: BlocConsumer<PaymentCubit, CoreState>(
        listener: (context, state) {
          if (state is SuccessPaymentState) {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => OrderConformScreen(
                  widget.doctorData,
                  widget.service,
                  widget.orderId,
                ),
              ),
            );
          } else if (state is CoreHttpErrorState) {
            errorSnackBar(context, state.error);
          }
        },
        buildWhen: (_, state) => state is PaymentCommonState,
        builder: (context, state) {
          if (state is PaymentCommonState) {
            return AppLoadingWidget(
              isLoading: state.isCanBeLoad,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: CommonAppBar(
                  S.of(context).payment,
                  enableBack: true,
                  leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    icon: Transform.rotate(
                      angle: math.pi / 2,
                      child: SvgPicture.asset(
                        AppSvgIcons.icAltArrowDown,
                        color: AppColors.black,
                        width: 23,
                      ),
                    ),
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: state.cardList?.length ?? 0,
                        separatorBuilder: (context, _) => const HBox(16),
                        itemBuilder: (context, index) {
                          final card = state.cardList?.elementAt(index) ?? UserCardModel();
                          return PaymentItemCard(
                            card.name,
                            active: card.active,
                            icVisa: card.isVisa,
                            onSelect: () => context.read<PaymentCubit>().selectCard(card.id),
                          );
                        },
                      ),
                      const HBox(16),
                      AddPaymentMethodButton(
                        onTap: () => showAddNewCardModalSheet(
                          context,
                          context.read<PaymentCubit>(),
                          onPay: context.read<PaymentCubit>().addNewCard
                        ),
                      ),
                    ],
                  ),
                ),
                bottomSheet: Container(
                  color: AppColors.superGray,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            '1 услуга',
                            style: GoogleFonts.ubuntu(
                              fontSize: 16,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const WBox(8),
                          Text(
                            '2 ч',
                            style: GoogleFonts.ubuntu(
                              fontSize: 16,
                              color: AppColors.gray,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.service.price,
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
                      AppFilledColorButton(
                        onTap: () => onPay(context, state),
                        height: 56,
                        borderRadiusRadii: 100,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(S.current.toPay, style: AppTextStyle.buttonStyle),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  void onPay(BuildContext ctx, PaymentCommonState state) {
    if (state.activeCard == null) {
      showAddNewCardModalSheet(
        ctx,
        ctx.read<PaymentCubit>(),
      );
      return;
    }
    ctx.read<PaymentCubit>().payWithToken(state.activeCard?.token);
  }
}
