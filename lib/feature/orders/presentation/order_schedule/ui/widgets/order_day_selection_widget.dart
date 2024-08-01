import 'package:allmed/common/presentation/widgets/app_wbox_widget.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDaySelectionWidget extends StatelessWidget {
  const OrderDaySelectionWidget(
    this.dayList, {
    required this.onSelect,
    required this.selectedIndex,
    super.key,
  });

  final int selectedIndex;
  final List<String> dayList;
  final Function(int) onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        itemCount: dayList.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(20),
        separatorBuilder: (context, _) => const WBox(8),
        itemBuilder: (context, index) => ElevatedButton(
          onPressed: () => onSelect.call(index),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            backgroundColor: selectedIndex == index ? AppColors.black : AppColors.superGray,
          ),
          child: Text(
            index == 0
                ? S.of(context).today
                : index == 1
                    ? S.of(context).tomorrow
                    : dayList[index],
            style: GoogleFonts.ubuntu(
              fontSize: 15,
              color: selectedIndex == index ? Colors.white : Colors.black,
              fontWeight: selectedIndex == index ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
