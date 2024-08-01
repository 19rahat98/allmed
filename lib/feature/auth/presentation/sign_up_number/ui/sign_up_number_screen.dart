import 'dart:io';

import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_bloc_builder.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/widgets/app_filled_color_button.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_keyboard_dismisser.dart';
import 'package:allmed/common/presentation/widgets/app_loading_widget.dart';
import 'package:allmed/common/presentation/widgets/app_privacy_policy_plaintext_widget.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/auth/presentation/conform_number/ui/conform_number_screen.dart';
import 'package:allmed/feature/auth/presentation/sign_in/presentation/sign_in_screen.dart';
import 'package:allmed/feature/auth/presentation/sign_up_number/cubit/sign_up_number_cubit.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignupNumberBuilder extends StatelessWidget {
  const SignupNumberBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpNumberCubit(),
      child: const SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _phoneNumberController;
  final _phoneNumberFormatter = MaskTextInputFormatter(
    mask: '### ### ## ##',
    filter: {"#": RegExp(r'\d')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AppKeyboardDismisser(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CoreUpgradeBlocBuilder<SignUpNumberCubit, CoreState>(
          listener: (context, state) {
            if (state is SuccessCreatedNewNumberState) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ConformNumberBuilder(state.phoneNumber),
                ),
              );
            }
          },
          buildWhen: (_, state) => state is SignInNumberCommonState,
          builder: (context, state) {
            if (state is SignInNumberCommonState) {
              return AppLoadingWidget(
                isLoading: state.isLoading,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 84, 20, 0),
                  child: Column(
                    children: [
                      Text(
                        S.current.createNewAccount,
                        style: GoogleFonts.ubuntu(
                          fontSize: 24,
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const HBox(8),
                      Text(
                        S.current.enterPhoneNumberInBottomTextField,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ubuntu(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.gray,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(top: 32, bottom: 24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.lightGray),
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Text(
                                '+7',
                                style: AppTextStyle.caption1,
                              ),
                              const VerticalDivider(
                                color: AppColors.lightGray,
                                indent: 0,
                                width: 20,
                                endIndent: 0,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _phoneNumberController,
                                  style: AppTextStyle.caption1,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: '--- --- -- --',
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    counterText: GlobalCoreConstants.empty,
                                    labelStyle: AppTextStyle.secondary
                                        .copyWith(fontWeight: FontWeight.w400),
                                    hintStyle: AppTextStyle.caption1.copyWith(
                                      color: AppColors.gray,
                                    ),
                                    contentPadding: const EdgeInsets.only(bottom: 3),
                                  ),
                                  inputFormatters: [_phoneNumberFormatter],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const AppPrivacyPolicyTextWidget(),
                      const HBox(12),
                      const Spacer(),
                      AppFilledColorButton(
                        onTap: () =>
                            context.read<SignUpNumberCubit>().createNewAccountFromPhoneNUmber(
                                  _phoneNumberFormatter.unmaskText(_phoneNumberController.text),
                                ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        borderRadiusRadii: 100,
                        child: Text(
                          S.current.continueRegistration,
                          style: AppTextStyle.base.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const HBox(12),
                      SafeArea(
                        top: false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.current.doYouHaveAccount,
                              style: AppTextStyle.caption1,
                            ),
                            TextButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignInScreen(),
                                ),
                              ),
                              child: Text(
                                S.current.enter,
                                style: AppTextStyle.caption1.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryColor,
                                ),
                              ), // Текст кнопки
                            ),
                          ],
                        ),
                      ),
                      HBox(Platform.isAndroid ? 24 : 0),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
