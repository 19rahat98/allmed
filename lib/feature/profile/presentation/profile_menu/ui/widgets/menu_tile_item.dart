import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuTileItem extends StatelessWidget {
  const MenuTileItem({
    Key? key,
    required this.title,
    required this.onTap,
    this.icon = AppSvgIcons.icQuestionSquare,
  }) : super(key: key);

  final String icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4),
      child: ListTile(
        dense: true,
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        title: Text(
          title,
          style: GoogleFonts.ubuntu(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        leading: SvgPicture.asset(icon, width: 24, height: 24, color: AppColors.black),
      ),
    );
  }
}
