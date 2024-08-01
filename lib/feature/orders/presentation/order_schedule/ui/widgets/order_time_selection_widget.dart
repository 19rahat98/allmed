import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/orders/data/model/time_slot.dart';
import 'package:allmed/feature/orders/presentation/order_schedule/cubit/order_schedule_cubit.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeSelectionScreen extends StatelessWidget {
  const TimeSelectionScreen(this.timeSlot, {super.key, this.selectedSlot});

  final String? selectedSlot;
  final List<TimeSlotDto>? timeSlot;

  @override
  Widget build(BuildContext context) {
    final List<String> night = ["00:00", "01:00", "02:00", "03:00", "04:00", "05:00"];
    final List<String> morningTimes = ["06:00", "07:00", "08:00", "09:00", "10:00", "11:00"];
    final List<String> afternoonTimes = ["12:00", "13:00", "14:00", "15:00", "16:00", "17:00"];
    final List<String> eveningTimes = ["18:00", "19:00", "20:00", "21:00", "22:00", "23:00"];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildTimeSection(S.of(context).night, night),
          _buildTimeSection(S.of(context).morning, morningTimes),
          _buildTimeSection(S.of(context).day, afternoonTimes),
          _buildTimeSection(S.of(context).evening, eveningTimes),
        ],
      ),
    );
  }

  Widget _buildTimeSection(String title, List<String> times) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            title,
            style: GoogleFonts.ubuntu(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 2.6,
          ),
          itemCount: times.length,
          itemBuilder: (context, index) {
            final time = times.elementAt(index);
            final enable = timeSlot?.any((element) => element.formatTime == time) ?? false;
            return _buildTimeButton(context, time, enable);
          },
        ),
      ],
    );
  }

  Widget _buildTimeButton(BuildContext context, String time, bool enable) {
    final selected = enable ? selectedSlot == time : false;
    return OutlinedButton(
      onPressed: () {
        if (!enable) return;
        context.read<OrderScheduleCubit>().selectTimeSlot(time);
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: selected
            ? AppColors.secondary
            : enable
                ? Colors.white
                : AppColors.superGray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        side: const BorderSide(color: AppColors.lightGray),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
      child: Text(
        time,
        style: GoogleFonts.ubuntu(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: selected
              ? Colors.white
              : enable
                  ? AppColors.black
                  : AppColors.lightGray,
        ),
      ),
    );
  }
}
