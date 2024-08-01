import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_outline_button_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TechnicalWorkScreen extends StatelessWidget {
  const TechnicalWorkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(AppIcons.icPills, width: 170),
            ),
            const HBox(20),
            Text(
              S.current.technicalWork,
              style: AppTextStyle.biggest,
              textAlign: TextAlign.center,
            ),
            const HBox(32),
            Text(
              S.current.chillAndWork,
              style: GoogleFonts.inter(
                fontSize: 18,
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            const HBox(40),
            AppOutlineButtonWidget(
              onTap: () {},
              borderRadiusRadii: 16,
              child: Text(
                S.current.notifyCompletion,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
