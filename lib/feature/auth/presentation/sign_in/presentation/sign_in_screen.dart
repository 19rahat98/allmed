import 'dart:io';

import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_bloc_builder.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/widgets/app_bars/app_question_mark_app_bar.dart';
import 'package:allmed/common/presentation/widgets/app_filled_color_button.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_keyboard_dismisser.dart';
import 'package:allmed/common/presentation/widgets/app_label_textfield.dart';
import 'package:allmed/common/presentation/widgets/app_loading_widget.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/auth/presentation/global_auth/cubit/global_auth_cubit.dart';
import 'package:allmed/feature/auth/presentation/recovery_password/presentation/recovery_password_screen.dart';
import 'package:allmed/feature/auth/presentation/sign_in/cubit/sign_in_cubit.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController _passwordController;
  late TextEditingController _phoneNumberController;

  final _phoneNumberFormatter = MaskTextInputFormatter(
    mask: '### ### ## ##',
    filter: {"#": RegExp(r'\d')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _phoneNumberController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: CoreUpgradeBlocBuilder<SignInCubit, CoreState>(
        listener: (context, state) {
          if (state is SuccessLogInState) {
            context.read<GlobalAuthCubit>().checkVerifyStatus();
            Navigator.pop(context);
          }
        },
        buildWhen: (_, state) => state is SignInCommonState,
        builder: (context, state) {
          if (state is SignInCommonState) {
            return AppLoadingWidget(
              isLoading: state.isLoading,
              child: AppKeyboardDismisser(
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: const AppQuestionMarkAppBar(),
                  body: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                    child: Column(
                      children: [
                        Text(
                          S.current.welcomeTo,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ubuntu(
                            fontSize: 24,
                            color: AppColors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const HBox(8),
                        Text(
                          S.current.enterNumberToAuth,
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
                            border: Border.all(
                              color: state.errorMessage != null
                                  ? AppColors.error
                                  : AppColors.lightGray,
                            ),
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
                        AppLabelTextFieldWidget(
                          isPassword: true,
                          label: S.current.password,
                          controller: _passwordController,
                          errorMessage: state.errorMessage,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RecoveryPasswordScreen(),
                              ),
                            ),
                            child: Text(
                              S.current.forgetPassword,
                              style: AppTextStyle.caption1.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        SafeArea(
                          top: false,
                          child: AppFilledColorButton(
                            onTap: () => context.read<SignInCubit>().logIn(
                                _phoneNumberFormatter.unmaskText(_phoneNumberController.text),
                                _passwordController.text),
                            borderRadiusRadii: 100,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            margin: EdgeInsets.only(bottom: Platform.isAndroid ? 24 : 0),
                            child: Text(
                              S.current.enter,
                              style: AppTextStyle.base.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
