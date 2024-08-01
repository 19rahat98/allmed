import 'dart:async';

import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/widgets/app_bars/app_question_mark_app_bar.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_keyboard_dismisser.dart';
import 'package:allmed/common/presentation/widgets/app_snack_bar_widget.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/auth/presentation/conform_number/cubit/conform_number_cubit.dart';
import 'package:allmed/feature/auth/presentation/create_password/ui/create_password_screen.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ConformNumberBuilder extends StatelessWidget {
  const ConformNumberBuilder(this.phoneNumber, {super.key, this.resetToken});

  final String? resetToken;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConformNumberCubit(),
      child: ConformNumberScreen(phoneNumber, resetToken: resetToken),
    );
  }
}

class ConformNumberScreen extends StatefulWidget {
  const ConformNumberScreen(this.phoneNumber, {super.key, this.resetToken});

  final String? resetToken;
  final String phoneNumber;

  @override
  State<ConformNumberScreen> createState() => _ConformNumberScreenState();
}

class _ConformNumberScreenState extends State<ConformNumberScreen> {
  late TextEditingController _picCodeController;
  late StreamController<ErrorAnimationType> _errorController;

  @override
  void initState() {
    super.initState();
    _picCodeController = TextEditingController();
    _errorController = StreamController<ErrorAnimationType>();
  }

  @override
  Widget build(BuildContext context) {
    return AppKeyboardDismisser(
      child: BlocListener<ConformNumberCubit, CoreState>(
        listener: (context, state) {
          if (state is ConformPhoneNumberSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => CreatePasswordBuilder(
                  token: state.token,
                  phoneNumber: widget.phoneNumber,
                  isResetPassword: state.isResetPassword,
                ),
              ),
            );
          } else if (state is ConformNumberHasError) {
            errorSnackBar(context, S.current.incorrectConformCode);
            _picCodeController.clear();
            _errorController.add(ErrorAnimationType.shake);
          }
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: const AppQuestionMarkAppBar(),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Column(
                children: [
                  Text(
                    S.current.conformCode,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
                    child: PinCodeTextField(
                      length: 6,
                      appContext: context,
                      autoFocus: true,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      keyboardType: TextInputType.number,
                      textStyle: GoogleFonts.ubuntu(
                        fontSize: 24,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      pinTheme: PinTheme(
                        activeBoxShadow: [],
                        inActiveBoxShadow: [],
                        activeColor: Colors.white,
                        inactiveColor: AppColors.lightGray,
                        selectedColor: AppColors.lightGray,
                        disabledColor: AppColors.lightGray,
                        errorBorderColor: const Color(0xFFF72E34),
                        activeFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        fieldOuterPadding: EdgeInsets.zero,
                        shape: PinCodeFieldShape.underline,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 50,
                        fieldWidth: 40,
                      ),
                      controller: _picCodeController,
                      errorAnimationController: _errorController,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      onCompleted: (v) =>
                          context.read<ConformNumberCubit>().verify(widget.phoneNumber, v, resetToken: widget.resetToken),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _errorController.close();
    _picCodeController.dispose();
  }
}
