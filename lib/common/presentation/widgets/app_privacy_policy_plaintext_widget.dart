import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// футер виджет для политики конфиденциальности
class AppPrivacyPolicyTextWidget extends StatelessWidget {
  const AppPrivacyPolicyTextWidget({Key? key, this.onTapPrivacyPolicy}) : super(key: key);

  final void Function()? onTapPrivacyPolicy;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: S.current.registeringYouAgreeToThe,
        style: AppTextStyle.caption1,
        children: <TextSpan>[
          TextSpan(
            text: S.current.privacyPolicy,
            recognizer: TapGestureRecognizer()..onTap = onTapPrivacyPolicy,
            style: AppTextStyle.caption1.copyWith(color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
