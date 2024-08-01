import 'dart:io';

import 'package:allmed/common/core/presentation/abstract/bloc/core_bloc_builder.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/widgets/app_bars/app_question_mark_app_bar.dart';
import 'package:allmed/common/presentation/widgets/app_filled_color_button.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_keyboard_dismisser.dart';
import 'package:allmed/common/presentation/widgets/app_label_textfield.dart';
import 'package:allmed/common/presentation/widgets/app_snack_bar_widget.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/auth/presentation/account_info/ui/set_account_info_screen.dart';
import 'package:allmed/feature/auth/presentation/create_password/cubit/create_password_cubit.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatePasswordBuilder extends StatelessWidget {
  const CreatePasswordBuilder({
    Key? key,
    required this.token,
    required this.phoneNumber,
    this.isResetPassword = false,
  }) : super(key: key);

  final String token;
  final String phoneNumber;
  final bool isResetPassword;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreatePasswordCubit(),
      child: CreatePasswordScreen(
        token: token,
        phoneNumber: phoneNumber,
        isResetPassword: isResetPassword,
      ),
    );
  }
}

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({
    Key? key,
    required this.token,
    required this.phoneNumber,
    this.isResetPassword = false,
  }) : super(key: key);

  final String token;
  final String phoneNumber;
  final bool isResetPassword;

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  late TextEditingController _passwordController;
  late TextEditingController _secondPasswordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _secondPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AppKeyboardDismisser(
      child: CoreUpgradeBlocBuilder<CreatePasswordCubit, CoreState>(
        listener: (context, state) {
          if (state is CreatePasswordHasError) {
            errorSnackBar(context, state.errorMessage);
          } else if (state is SuccessCreatedNewPassword) {
            if (state.isResetPassword) {
              successSnackBar(context, S.of(context).newPasswordHasBeenSaved);
              Navigator.pop(context);
              return;
            }
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const SetAccountInfoBuilder(),
              ),
            );
          }
        },
        builder: (context, _) => Scaffold(
          backgroundColor: Colors.white,
          appBar: const AppQuestionMarkAppBar(),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: Column(
              children: [
                Text(
                  S.current.createPassword,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ubuntu(
                    fontSize: 24,
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const HBox(8),
                Text(
                  S.current.passwordMustHaveAtLessEight,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ubuntu(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.gray,
                  ),
                ),
                const HBox(32),
                AppLabelTextFieldWidget(
                  isPassword: true,
                  label: S.current.password,
                  controller: _passwordController,
                ),
                const HBox(24),
                AppLabelTextFieldWidget(
                  isPassword: true,
                  label: S.current.repeatPassword,
                  controller: _secondPasswordController,
                ),
                const Spacer(),
                const HBox(24),
                SafeArea(
                  top: false,
                  child: AppFilledColorButton(
                    onTap: () => context.read<CreatePasswordCubit>().createPassword(
                          _passwordController.text,
                          _secondPasswordController.text,
                          widget.phoneNumber,
                          widget.token,
                          isResetPassword: widget.isResetPassword,
                        ),
                    borderRadiusRadii: 100,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    margin: EdgeInsets.only(bottom: Platform.isAndroid ? 24 : 0),
                    child: Text(
                      S.current.createPassword,
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
}
