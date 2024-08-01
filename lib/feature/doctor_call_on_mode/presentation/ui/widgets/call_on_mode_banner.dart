import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CallOnModeBanner extends StatelessWidget {
  const CallOnModeBanner({
    required this.title,
    required this.onTap,
    this.icon = AppSvgIcons.icCalendarOutline,
    super.key,
  });

  final String title;
  final String icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      tileColor: AppColors.superGray,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: SvgPicture.asset(icon, alignment: Alignment.centerLeft),
      ),
      //titleAlignment:ListTileTitleAlignment.threeLine,
      subtitle: Text(
        title,
        style: GoogleFonts.ubuntu(
          fontSize: 16,
          color: AppColors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
