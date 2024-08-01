import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar(this.title, {super.key, this.enableBack = false, this.leading});

  final String title;
  final bool enableBack;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      titleSpacing: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: GoogleFonts.ubuntu(
          fontSize: 22,
          color: AppColors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      leadingWidth: enableBack ? 80 : 20,
      leading: enableBack ? leading ?? Center(
        child: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            S.current.back,
            style: AppTextStyle.caption1,
          ),
        ),
      ) : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Высота AppBar
}
