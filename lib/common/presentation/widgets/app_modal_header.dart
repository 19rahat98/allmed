import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppModalHeader extends StatelessWidget {
  const AppModalHeader(
    this.title, {
    Key? key,
    this.onTap,
    this.titlePadding = const EdgeInsets.fromLTRB(20, 12, 8, 8),
  }) : super(key: key);

  final String title;
  final void Function()? onTap;
  final EdgeInsets titlePadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: titlePadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyle.title2,
          ),
          IconButton(
            onPressed: onTap ?? () => Navigator.pop(context),
            padding: EdgeInsets.zero,
            icon: SvgPicture.asset(AppSvgIcons.icClose),
          ),
        ],
      ),
    );
  }
}
