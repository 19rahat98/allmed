import 'dart:math' as math;

import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactMethodTile extends StatelessWidget {
  const ContactMethodTile({
    Key? key,
    required this.title,
    required this.onTap,
    required this.subTile,
    this.icon = AppSvgIcons.icQuestionSquareOutline,
  }) : super(key: key);

  final String icon;
  final String title;
  final String subTile;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: SvgPicture.asset(icon),
      tileColor: AppColors.superGray,
      title: Text(
        title,
        maxLines: 1,
        style: GoogleFonts.ubuntu(
          fontSize: 16,
          color: AppColors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subTile,
        maxLines: 2,
        style: GoogleFonts.ubuntu(
          fontSize: 15,
          color: AppColors.gray,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Transform.rotate(
        angle: -math.pi / 2,
        // Поворачиваем иконку на 180 градусов, если раскрыто
        child: SvgPicture.asset(AppSvgIcons.icAltArrowDown),
      ),
    );
  }
}
