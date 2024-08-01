import 'package:allmed/common/presentation/widgets/app_wbox_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpToOrderWidget extends StatelessWidget {
  const HelpToOrderWidget({
    Key? key,
    this.mainColor = AppColors.black,
    this.borderColor = AppColors.lightGray,
  }) : super(key: key);

  const HelpToOrderWidget.dangerous({
    Key? key,
    this.mainColor = AppColors.error,
    this.borderColor = Colors.white,
  }) : super(key: key);

  final Color mainColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.fromLTRB(12, 8, 12, 0),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AppSvgIcons.icQuestionCircle,
              color: mainColor,
            ),
            const WBox(8),
            Text(
              S.current.helpToOrder,
              style: GoogleFonts.ubuntu(
                fontSize: 14,
                color: mainColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
