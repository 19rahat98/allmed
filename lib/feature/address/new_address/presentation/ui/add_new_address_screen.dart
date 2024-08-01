import 'dart:io';

import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/widgets/app_bars/select_page_app_bar.dart';
import 'package:allmed/common/presentation/widgets/app_filled_color_button.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_keyboard_dismisser.dart';
import 'package:allmed/common/presentation/widgets/app_label_textfield.dart';
import 'package:allmed/common/presentation/widgets/app_loading_widget.dart';
import 'package:allmed/common/presentation/widgets/app_snack_bar_widget.dart';
import 'package:allmed/common/presentation/widgets/app_wbox_widget.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/address/new_address/presentation/cubit/user_address_cubit.dart';
import 'package:allmed/feature/address/user_address/data/model/addresses_dto.dart';
import 'package:allmed/feature/address/user_address/presentation/cubit/address_cubit.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:allmed/utils/text_inpute_formmatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewAddressBuilder extends StatelessWidget {
  const AddNewAddressBuilder({super.key, required this.addressData, this.enableChange = false});

  final bool enableChange;
  final AddressDto addressData;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserAddressCubit(),
      child: AddNewAddressScreen(address: addressData, enableChange: enableChange),
    );
  }
}

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key, required this.address, this.enableChange = false});

  final bool enableChange;
  final AddressDto address;

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  late UserAddressCubit _cubit;
  late TextEditingController _streetController;
  late TextEditingController _buildingController;
  late TextEditingController _apartmentController;
  late TextEditingController _entranceController;
  late TextEditingController _intercomController;
  late TextEditingController _floorController;
  late TextEditingController _commentController;

  @override
  void initState() {
    _cubit = context.read<UserAddressCubit>()..selectedPoint(widget.address.point);
    _streetController = TextEditingController(text: widget.address.formedAddress.first);
    _buildingController = TextEditingController(text: widget.address.formedAddress.last);
    _apartmentController = TextEditingController(text: widget.address.apartment);
    _entranceController = TextEditingController(text: widget.address.entrance);
    _intercomController = TextEditingController(text: widget.address.intercom);
    _floorController = TextEditingController(text: widget.address.floor);
    _commentController = TextEditingController(text: widget.address.comment);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserAddressCubit, CoreState>(
      buildWhen: (_, state) => state is UserAddressCommonState,
      listener: (context, state) {
        if (state is AddressSuccessCreatedState) {
          //Navigator.popUntil(context, ModalRoute.withName('/'));
          Navigator.pop(context);
          Navigator.pop(context);
          context.read<AddressCubit>().loadAddressList();
          successSnackBar(context, S.of(context).addressSuccessAdded);
        } else if (state is AddressSuccessChangedState) {
          Navigator.pop(context);
          context.read<AddressCubit>().loadAddressList();
          successSnackBar(context, S.of(context).addressSuccessChanged);
        } else if (state is CoreHttpErrorState) {
          errorSnackBar(context, state.error);
        }
      },
      builder: (context, state) {
        if (state is UserAddressCommonState) {
          return AppKeyboardDismisser(
            child: AppLoadingWidget(
              isLoading: state.isLoading,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: SelectPageAppBar(
                  title: S.current.addAddress,
                  onBackButtonPressed: () => Navigator.pop(context),
                ),
                body: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        child: Column(
                          children: [
                            AppLabelTextFieldWidget(
                              controller: _streetController,
                              label: S.current.address,
                              errorMessage: state.addressError,
                              textInputFormatters: [
                                CapitalizeWordsTextInputFormatter(),
                              ],
                            ),
                            const HBox(16),
                            AppLabelTextFieldWidget(
                              controller: _buildingController,
                              errorMessage: state.apartmentError,
                              label: S.current.appartamentNumber,
                              textInputFormatters: [
                                CapitalizeWordsTextInputFormatter(),
                              ],
                            ),
                            const HBox(16),
                            Row(
                              children: [
                                Expanded(
                                  child: AppLabelTextFieldWidget(
                                    controller: _apartmentController,
                                    label: S.current.appartamnet,
                                    textInputFormatters: [
                                      CapitalizeWordsTextInputFormatter(),
                                    ],
                                  ),
                                ),
                                const WBox(12),
                                Expanded(
                                  child: AppLabelTextFieldWidget(
                                    label: S.current.entrance,
                                    controller: _entranceController,
                                    textInputFormatters: [
                                      CapitalizeWordsTextInputFormatter(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const HBox(16),
                            Row(
                              children: [
                                Expanded(
                                  child: AppLabelTextFieldWidget(
                                    label: S.current.intercom,
                                    controller: _intercomController,
                                    textInputFormatters: [
                                      CapitalizeWordsTextInputFormatter(),
                                    ],
                                  ),
                                ),
                                const WBox(12),
                                Expanded(
                                  child: AppLabelTextFieldWidget(
                                    label: S.current.floor,
                                    controller: _floorController,
                                  ),
                                ),
                              ],
                            ),
                            const HBox(16),
                            AppLabelTextFieldWidget(
                              label: S.current.comments,
                              controller: _commentController,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      AppFilledColorButton(
                        onTap: () {
                          if (widget.enableChange) {
                            _cubit.change(
                              widget.address.id,
                              address: _streetController.text,
                              building: _buildingController.text,
                              apartment: _apartmentController.text,
                              entrance: _entranceController.text,
                              intercom: _intercomController.text,
                              floor: _floorController.text,
                              comment: _commentController.text,
                            );
                            return;
                          }
                          _cubit.createNewAddress(
                            address: _streetController.text,
                            building: _buildingController.text,
                            apartment: _apartmentController.text,
                            entrance: _entranceController.text,
                            intercom: _intercomController.text,
                            floor: _floorController.text,
                            comment: _commentController.text,
                          );
                        },
                        height: 56,
                        borderRadiusRadii: 100,
                        color: AppColors.primaryColor,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, Platform.isAndroid ? 24 : 0),
                        child: Text(S.current.addAddress, style: AppTextStyle.buttonStyle),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return const SizedBox.expand();
      },
    );
  }
}
