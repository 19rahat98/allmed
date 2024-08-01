import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/widgets/app_filled_color_button.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_label_textfield.dart';
import 'package:allmed/common/presentation/widgets/app_loading_widget.dart';
import 'package:allmed/common/presentation/widgets/app_modal_header.dart';
import 'package:allmed/common/presentation/widgets/app_wbox_widget.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/payment/data/model/payment_card_model.dart';
import 'package:allmed/feature/payment/presentation/cubit/payment_cubit.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddNewCardModal extends StatefulWidget {
  const AddNewCardModal(this.cubit, {this.onPay, super.key});

  final Function(PaymentCardModel)? onPay;
  final PaymentCubit cubit;

  @override
  State<AddNewCardModal> createState() => _AddNewCardModalState();
}

class _AddNewCardModalState extends State<AddNewCardModal> {
  final _cardController = TextEditingController();
  final _dateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardNumberController = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'\d')},
    type: MaskAutoCompletionType.lazy,
  );
  final _cvvNumberController = MaskTextInputFormatter(
    mask: '###',
    filter: {"#": RegExp(r'\d')},
    type: MaskAutoCompletionType.lazy,
  );
  final _cardDateController = MaskTextInputFormatter(
    mask: '##/##',
    filter: {"#": RegExp(r'\d')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void initState() {
    widget.cubit.removeErrors(GlobalCoreConstants.empty);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.cubit,
      child: BlocConsumer<PaymentCubit, CoreState>(
        listener: (context, state) {
          if (state is SuccessAddedNewCard) {
            Navigator.pop(context);
          }
        },
        buildWhen: (_, state) => state is PaymentCommonState,
        builder: (context, state) {
          if (state is PaymentCommonState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Material(
                color: Colors.white,
                clipBehavior: Clip.hardEdge,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: AppLoadingWidget(
                  isLoading: state.isLoading,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppModalHeader(S.of(context).newCard),
                      AppLabelTextFieldWidget(
                        controller: _cardController,
                        label: S.of(context).cardNumber,
                        errorMessage: state.cardNumberError,
                        onValueChanged: widget.cubit.removeErrors,
                        textInputFormatters: [_cardNumberController],
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      ),
                      Row(
                        children: [
                          const WBox(20),
                          Expanded(
                            child: AppLabelTextFieldWidget(
                              controller: _dateController,
                              errorMessage: state.cardDateError,
                              label: S.of(context).validityPeriod,
                              onValueChanged: widget.cubit.removeErrors,
                              textInputFormatters: [_cardDateController],
                              margin: const EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                          const WBox(12),
                          Expanded(
                            child: AppLabelTextFieldWidget(
                              label: S.of(context).cvv,
                              controller: _cvvController,
                              errorMessage: state.cardCvcError,
                              onValueChanged: widget.cubit.removeErrors,
                              textInputFormatters: [_cvvNumberController],
                              margin: const EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                          const WBox(20),
                        ],
                      ),
                      AppFilledColorButton(
                        onTap: () {
                          final card = PaymentCardModel(
                            cardCVC: _cvvNumberController.getMaskedText(),
                            cardDate: _cardDateController.getMaskedText(),
                            cardNumber: _cardNumberController.getMaskedText(),
                          );
                          widget.onPay?.call(card) ?? widget.cubit.actionWithCard(card);
                        },
                        borderRadiusRadii: 100,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        child: Text(
                          S.current.linkCard,
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
          }

          return const SizedBox();
        },
      ),
    );
  }
}

Future<void> showAddNewCardModalSheet(
  BuildContext context,
  PaymentCubit cubit, {
  Function(PaymentCardModel)? onPay,
}) {
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
    builder: (context) => AddNewCardModal(cubit, onPay: onPay),
  );
}
