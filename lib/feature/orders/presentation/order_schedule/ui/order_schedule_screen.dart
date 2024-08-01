import 'dart:math' as math;
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/widgets/app_bars/common_app_bar.dart';
import 'package:allmed/common/presentation/widgets/app_filled_color_button.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_loading_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/doctor_call_on_mode/presentation/ui/choose_doctor_screen.dart';
import 'package:allmed/feature/orders/presentation/order_schedule/cubit/order_schedule_cubit.dart';
import 'package:allmed/feature/orders/presentation/order_schedule/ui/widgets/order_day_selection_widget.dart';
import 'package:allmed/feature/orders/presentation/order_schedule/ui/widgets/order_time_selection_widget.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderScheduleScreen extends StatefulWidget {
  const OrderScheduleScreen({
    super.key,
    required this.addressId,
    required this.serviceId,
  });

  final int serviceId;
  final int addressId;

  @override
  State<OrderScheduleScreen> createState() => _OrderScheduleScreenState();
}

class _OrderScheduleScreenState extends State<OrderScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderScheduleCubit()..initCubit(widget.serviceId, widget.addressId),
      child: BlocBuilder<OrderScheduleCubit, CoreState>(
        buildWhen: (_, state) => state is OrderScheduleCommonState,
        builder: (context, state) {
          if (state is OrderScheduleCommonState) {
            return AppLoadingWidget(
              isLoading: state.isLoading,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: CommonAppBar(
                  S.of(context).dateAndTime,
                  enableBack: true,
                  leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    icon: Transform.rotate(
                      angle: math.pi / 2,
                      child: SvgPicture.asset(
                        AppSvgIcons.icAltArrowDown,
                        color: AppColors.black,
                        width: 23,
                      ),
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      OrderDaySelectionWidget(
                        state.dayList,
                        selectedIndex: state.selectedDay,
                        onSelect: context.read<OrderScheduleCubit>().changeSelectedDay,
                      ),
                      TimeSelectionScreen(state.timeSlot, selectedSlot: state.selectedSlot),
                      const HBox(24),
                      AppFilledColorButton(
                        onTap: () {
                          if (state.selectedSlot == null) return;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChooseDoctorScreen(
                                date: state.selectedDate,
                                serviceData: state.serviceInfo,
                                title: S.of(context).doctorsFor + state.callToDoctor,
                              ),
                            ),
                          );
                        },
                        borderRadiusRadii: 100,
                        color: state.selectedSlot != null
                            ? AppColors.primaryColor
                            : AppColors.lightGray,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        child: Text(
                          S.current.ready,
                          style: AppTextStyle.buttonStyle,
                        ),
                      ),
                      const HBox(20),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox.expand();
        },
      ),
    );
  }
}
