import 'dart:math' as math;

import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/auth/domain/entity/global_user_detail_entity.dart';
import 'package:allmed/feature/profile/presentation/edit_profile/ui/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ProfileAccountBanner extends StatelessWidget {
  const ProfileAccountBanner(this.user, {Key? key}) : super(key: key);

  final GlobalUserDetailEntity user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        onTap: () => pushScreen(
          context,
          withNavBar: false,
          screen: EditProfileScreen(user),
        ),
        dense: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        leading: Container(
          width: 56,
          height: 56,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.lightGray,
          ),
          child: Center(
            child: Text(
              user.firstSymbol,
              style: GoogleFonts.ubuntu(
                fontSize: 32,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title: Text(
          user.userFullName,
          style: GoogleFonts.ubuntu(
            fontSize: 18,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          user.userPhoneNumber,
          style: GoogleFonts.ubuntu(
            fontSize: 14,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: Transform.rotate(
          angle: -math.pi / 2,
          // Поворачиваем иконку на 180 градусов, если раскрыто
          child: SvgPicture.asset(AppSvgIcons.icAltArrowDown),
        ),
      ),
    );
  }
}
