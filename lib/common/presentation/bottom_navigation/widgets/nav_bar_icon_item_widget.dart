import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBarIconItemWidget extends StatelessWidget {
  const NavBarIconItemWidget({
    Key? key,
    this.textColor,
    required this.title,
    required this.iconName,
  }) : super(key: key);

  final String iconName;
  final Color? textColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          iconName,
          width: 22,
          height: 22,
        ),
        const HBox(4),
        Expanded(
          child: Material(
            color: Colors.transparent,
            child: Text(
              title,
              style: AppTextStyle.navBar.copyWith(color: textColor),
            ),
          ),
        ),
      ],
    );
  }
}
