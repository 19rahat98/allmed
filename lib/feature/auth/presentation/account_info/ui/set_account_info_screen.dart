import 'dart:io';

import 'package:allmed/common/core/presentation/abstract/bloc/core_bloc_builder.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/widgets/app_bars/app_question_mark_app_bar.dart';
import 'package:allmed/common/presentation/widgets/app_filled_color_button.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_keyboard_dismisser.dart';
import 'package:allmed/common/presentation/widgets/app_label_textfield.dart';
import 'package:allmed/common/presentation/widgets/app_loading_widget.dart';
import 'package:allmed/common/presentation/widgets/app_select_item.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/auth/presentation/account_info/cubit/set_account_info_cubit.dart';
import 'package:allmed/feature/auth/presentation/global_auth/cubit/global_auth_cubit.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SetAccountInfoBuilder extends StatelessWidget {
  const SetAccountInfoBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SetAccountInfoCubit(),
      child: const SetAccountInfoScreen(),
    );
  }
}

class SetAccountInfoScreen extends StatefulWidget {
  const SetAccountInfoScreen({Key? key}) : super(key: key);

  @override
  State<SetAccountInfoScreen> createState() => _SetAccountInfoScreenState();
}

class _SetAccountInfoScreenState extends State<SetAccountInfoScreen> {
  late TextEditingController _iin;
  late TextEditingController _lastName;
  late TextEditingController _firstName;

  @override
  void initState() {
    super.initState();
    _iin = TextEditingController();
    _lastName = TextEditingController();
    _firstName = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return CoreUpgradeBlocBuilder<SetAccountInfoCubit, CoreState>(
      listener: (context, state) {
        if (state is SuccessEnterUserInfoState) {
          Navigator.pop(context);
          context.read<GlobalAuthCubit>().checkVerifyStatus();
        }
      },
      buildWhen: (_, state) => state is SetAccountInfoCommonState,
      builder: (context, state) {
        if (state is SetAccountInfoCommonState) {
          return AppKeyboardDismisser(
            child: AppLoadingWidget(
              isLoading: state.isLoading,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: const AppQuestionMarkAppBar(),
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                  child: Column(
                    children: [
                      Text(
                        S.current.accountData,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ubuntu(
                          fontSize: 24,
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const HBox(8),
                      Text(
                        S.current.enterIinNumberToData,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ubuntu(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.gray,
                        ),
                      ),
                      const HBox(32),
                      AppLabelTextFieldWidget(
                        controller: _iin,
                        label: S.current.iin,
                        hintTextValue: 'XXXXXXXXXXXX',
                        isEnabled: !state.isKzCitizenship,
                      ),
                      const HBox(24),
                      AppLabelTextFieldWidget(
                        controller: _firstName,
                        label: S.current.yourName,
                      ),
                      const HBox(24),
                      AppLabelTextFieldWidget(
                        controller: _lastName,
                        label: S.current.yourSecondName,
                      ),
                      const HBox(8),
                      AppSelectItem(
                        S.current.notKzCitizen,
                        onSelected: () {
                          if (state.isKzCitizenship) {
                            _iin.clear();
                          } else {
                            _iin = TextEditingController(text: 'XXXXXXXXXXXX');
                          }
                          context.read<SetAccountInfoCubit>().changeCitizenshipStatus();
                        },
                        isSelected: state.isKzCitizenship,
                      ),
                      const Spacer(),
                      const HBox(24),
                      SafeArea(
                        top: false,
                        child: AppFilledColorButton(
                          onTap: () => context
                              .read<SetAccountInfoCubit>()
                              .setUserInfo(_iin.text, _firstName.text, _lastName.text),
                          borderRadiusRadii: 100,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          margin: EdgeInsets.only(bottom: Platform.isAndroid ? 24 : 0),
                          child: Text(
                            S.current.conformData,
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
    );
  }
}
