import 'package:allmed/common/presentation/widgets/app_wbox_widget.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';

class SelectPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SelectPageAppBar({
    required this.title,
    this.onBackButtonPressed,
    super.key,
  });

  final String title;
  final VoidCallback? onBackButtonPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      titleSpacing: 0,
      centerTitle: false,
      surfaceTintColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(title, style: AppTextStyle.title2),
      ),
      backgroundColor: Colors.white,
      actions: <Widget>[
        TextButton(
          onPressed: onBackButtonPressed,
          child: Text(
            S.current.back,
            style: AppTextStyle.caption1,
          ), // Текст кнопки
        ),
        const WBox(12),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Высота AppBar
}
