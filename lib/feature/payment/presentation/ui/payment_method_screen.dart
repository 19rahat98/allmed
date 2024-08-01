import 'dart:math' as math;

import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/screens/errors/404_error_page.dart';
import 'package:allmed/common/presentation/widgets/app_bars/common_app_bar.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_snack_bar_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/payment/data/model/user_card_model.dart';
import 'package:allmed/feature/payment/presentation/cubit/payment_cubit.dart';
import 'package:allmed/feature/payment/presentation/ui/widgets/add_new_card_modal.dart';
import 'package:allmed/feature/payment/presentation/ui/widgets/add_payment_method_button.dart';
import 'package:allmed/feature/payment/presentation/ui/widgets/deleta_payment_way_alert.dart';
import 'package:allmed/feature/payment/presentation/ui/widgets/payment_item_card.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentCubit()..getUserCards(GlobalCoreConstants.negative),
      child: BlocConsumer<PaymentCubit, CoreState>(
        listener: (context, state) {
          if (state is SuccessAddedNewCard) {
            Navigator.pop(context);
            successSnackBar(context, S.of(context).cardSuccessAdded);
          } else if (state is SuccessCardDeleted) {
            Navigator.pop(context);
            successSnackBar(context, S.of(context).successCardDeleted);
          } else if (state is CoreHttpErrorState) {
            errorSnackBar(context, state.error);
          }
        },
        buildWhen: (_, state) => state is PaymentCommonState,
        builder: (context, state) {
          if (state is PaymentCommonState) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: CommonAppBar(
                S.of(context).paymentMethod,
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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
                          icVisa: card.isVisa,
                          onDelete: (_) => showDeletePaymentAlert(
                            context,
                            onDelete: () => context.read<PaymentCubit>().deleteCard(card.id),
                          ),
                        );
                      },
                    ),
                    const HBox(16),
                    AddPaymentMethodButton(
                      onTap: () => showAddNewCardModalSheet(
                        context,
                        context.read<PaymentCubit>(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is CoreErrorExceptionState) {
            return NetworkErrorPage(
              onRefresh: () =>
                  context.read<PaymentCubit>().getUserCards(GlobalCoreConstants.negative),
            );
          }
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: CommonAppBar(
              S.of(context).paymentMethod,
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: [
                  PaymentItemCard(
                    'Visa **** 000',
                    onDelete: (_) => showDeletePaymentAlert(context),
                  ),
                  const HBox(16),
                  PaymentItemCard(
                    'Visa **** 1111',
                    onDelete: (_) => showDeletePaymentAlert(context),
                  ),
                  const HBox(16),
                  const AddPaymentMethodButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
