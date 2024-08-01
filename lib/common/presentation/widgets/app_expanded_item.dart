import 'dart:math' as math;

import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AppExpandedItem extends StatefulWidget {
  const AppExpandedItem({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final String title;
  final String subTitle;

  @override
  State<AppExpandedItem> createState() => _AppExpandedItemState();
}

class _AppExpandedItemState extends State<AppExpandedItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.superGray,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => setState(() => _isExpanded = !_isExpanded),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 500), // Корректировка времени анимации
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black, // Предположим, что это ваш AppColors.black
                        ),
                      ),
                    ),
                    Transform.rotate(
                      angle: _isExpanded ? 0 : math.pi,
                      // Поворачиваем иконку на 180 градусов, если раскрыто
                      child: SvgPicture.asset(AppSvgIcons.icAltArrowDown),
                    ),
                  ],
                ),
                if (_isExpanded) ...[
                  const HBox(12),
                  Text(
                    widget.subTitle,
                    style: GoogleFonts.ubuntu(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black, // Предположим, что это ваш AppColors.black
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
