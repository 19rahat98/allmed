import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/feature/notification/presentation/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class NotificationBellWidget extends StatelessWidget {
  const NotificationBellWidget({
    Key? key,
    this.padding = const EdgeInsets.only(right: 8),
  }) : super(key: key);

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: IconButton(
        onPressed: () => pushScreen(
          context,
          withNavBar: false,
          screen: const NotificationScreen(),
        ),
        icon: SvgPicture.asset(AppSvgIcons.icNotificationBellOutline),
      ),
    );
  }
}
