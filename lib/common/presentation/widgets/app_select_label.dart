import 'package:allmed/common/theme/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSelectLabel extends StatelessWidget {
  const AppSelectLabel({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
      leading: SvgPicture.asset(AppSvgIcons.icCompassSquare, width: 24, height: 24),
    );
  }
}
