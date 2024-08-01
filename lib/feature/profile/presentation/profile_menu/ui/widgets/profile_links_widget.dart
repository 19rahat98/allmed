import 'package:allmed/common/presentation/screens/errors/404_error_page.dart';
import 'package:allmed/common/presentation/screens/errors/hard_update_screen.dart';
import 'package:allmed/common/presentation/screens/errors/technical_work_screen.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ProfileLinksWidget extends StatelessWidget {
  const ProfileLinksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => pushScreen(
            context,
            withNavBar: false,
            screen: const TechnicalWorkScreen(),
          ),
          icon: SvgPicture.asset(
            AppSvgIcons.icLinkedinCircle,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            AppSvgIcons.icYoutubeCircle,
          ),
        ),
        IconButton(
          onPressed: () => pushScreen(
            context,
            withNavBar: false,
            screen: const HardUpdateScreen(),
          ),
          icon: SvgPicture.asset(
            AppSvgIcons.icInstagramCircle,
          ),
        ),
      ],
    );
  }
}
