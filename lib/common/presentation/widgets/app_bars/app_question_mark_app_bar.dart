import 'dart:math' as math;

import 'package:allmed/common/presentation/widgets/app_wbox_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppQuestionMarkAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppQuestionMarkAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      titleSpacing: 0,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        padding: EdgeInsets.zero,
        icon: Transform.rotate(
          angle: math.pi / 2,
          child: SvgPicture.asset(
            AppSvgIcons.icAltArrowDown,
            color: AppColors.black,
            width: 23,
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          icon: SvgPicture.asset(
            AppSvgIcons.icQuestionCircle,
            color: AppColors.black,
            width: 23,
          ),
        ),
        const WBox(12),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Высота AppBar
}
