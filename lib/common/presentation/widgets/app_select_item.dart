import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSelectItem extends StatelessWidget {
  const AppSelectItem(
    this.title, {
    Key? key,
    this.onSelected,
    this.isSelected = false,
    this.padding = const EdgeInsets.only(),
  }) : super(key: key);

  final String title;
  final bool isSelected;
  final EdgeInsets padding;
  final Function()? onSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onTap: onSelected,
      contentPadding: padding,
      title: Text(
        title,
        style: GoogleFonts.ubuntu(
          fontSize: 16,
          color: AppColors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      leading: tickBuilder(),
    );
  }

  Widget tickBuilder() {
    if (isSelected) {
      return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.black,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: SvgPicture.asset(
          AppSvgIcons.icTickSquare,
          fit: BoxFit.none,
          height: 12,
          width: 12,
        ),
      );
    }

    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.gray,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
