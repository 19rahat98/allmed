import 'dart:math' as math;
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorTypeItem extends StatelessWidget {
  const DoctorTypeItem(
    this.title, {
    required this.onTap,
    super.key,
  });

  final Function() onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      tileColor: AppColors.superGray,
      title: Text(
        title,
        maxLines: 1,
        style: GoogleFonts.ubuntu(
          fontSize: 18,
          color: AppColors.black,
          fontWeight: FontWeight.w500,
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
