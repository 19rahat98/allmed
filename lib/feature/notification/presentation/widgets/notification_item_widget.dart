import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget(
    this.title, {
    Key? key,
    required this.subTitle,
    this.isSelected = false,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.secondary : AppColors.superGray,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            '21 июня',
            style: GoogleFonts.ubuntu(
              fontSize: 12,
              color: isSelected ? Colors.white : AppColors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Система',
                style: GoogleFonts.ubuntu(
                  fontSize: 14,
                  color: AppColors.gray,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const HBox(8),
              Text(
                title,
                style: GoogleFonts.ubuntu(
                  fontSize: 20,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const HBox(8),
              Text(
                subTitle,
                style: GoogleFonts.ubuntu(
                  height: 2,
                  fontSize: 16,
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Divider(
                height: 48,
                indent: 0,
                endIndent: 0,
                thickness: 1,
                color: AppColors.lightGray,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
