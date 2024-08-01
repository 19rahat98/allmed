import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderSymptomsInfoBlock extends StatelessWidget {
  const OrderSymptomsInfoBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.current.symptoms,
            style: GoogleFonts.ubuntu(
              fontSize: 20,
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const HBox(12),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _SymptomsItem('Температура'),
              _SymptomsItem('Боль в животе'),
              _SymptomsItem('Сыпь'),
              _SymptomsItem('Рвота'),
              _SymptomsItem('Запор'),
              _SymptomsItem('Насморк'),
              _SymptomsItem('Температура'),
            ],
          ),
          const HBox(8),
        ],
      ),
    );
  }
}

class _SymptomsItem extends StatelessWidget {
  const _SymptomsItem(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.lightGray),
      ),
      child: Text(
        title,
        style: GoogleFonts.ubuntu(
          fontSize: 14,
          color: AppColors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
