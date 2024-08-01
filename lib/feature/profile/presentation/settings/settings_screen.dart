import 'package:allmed/common/presentation/widgets/app_bars/common_app_bar.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/feature/profile/presentation/profile_menu/ui/widgets/menu_tile_item.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(S.current.setting, enableBack: true),
      body: Column(
        children: [
          const HBox(24),
          MenuTileItem(
            onTap: () {},
            icon: AppSvgIcons.icNotificationBellOutline,
            title: S.current.notification,
          ),
          MenuTileItem(
            onTap: () {},
            icon: AppSvgIcons.icChinaLanguage,
            title: S.current.applicationLanguage,
          ),
          MenuTileItem(
            onTap: () {},
            icon: AppSvgIcons.icDeleteUser,
            title: S.current.deleteAccount,
          ),
        ],
      ),
    );
  }
}
