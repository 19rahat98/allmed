import 'dart:math' as math;
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/screens/errors/404_error_page.dart';
import 'package:allmed/common/presentation/widgets/app_bars/common_app_bar.dart';
import 'package:allmed/common/presentation/widgets/app_filled_color_button.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_loading_widget.dart';
import 'package:allmed/common/presentation/widgets/app_shimmer_widget.dart';
import 'package:allmed/common/presentation/widgets/app_snack_bar_widget.dart';
import 'package:allmed/common/presentation/widgets/app_wbox_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/doctor_call_on_mode/presentation/cubit/doctor_call_cubit.dart';
import 'package:allmed/feature/doctor_call_on_mode/presentation/ui/widgets/doctoc_order_card.dart';
import 'package:allmed/feature/doctor_service/data/model/doctor_dto.dart';
import 'package:allmed/feature/orders/presentation/order_history/cubit/order_history_cubit.dart';
import 'package:allmed/feature/orders/presentation/order_schedule/ui/order_schedule_screen.dart';
import 'package:allmed/feature/payment/presentation/ui/payment_screen.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseDoctorScreen extends StatefulWidget {
  const ChooseDoctorScreen({
    super.key,
    this.date,
    required this.title,
    required this.serviceData,
  });

  final String title;
  final String? date;
  final DoctorServiceModel serviceData;

  @override
  State<ChooseDoctorScreen> createState() => _ChooseDoctorScreenState();
}

class _ChooseDoctorScreenState extends State<ChooseDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DoctorCallCubit()
        ..getDoctorsList(
          widget.serviceData.serviceId,
          widget.serviceData.addressId,
          date: widget.date,
        ),
      child: BlocConsumer<DoctorCallCubit, CoreState>(
        listener: (context, state) {
          if (state is OpenPaymentStepState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => PaymentScreen(
                  orderId: state.orderId,
                  doctorData: state.doctor,
                  service: state.serviceData,
                ),
              ),
              ModalRoute.withName('/'), // Условие, чтобы удалить все маршруты
            );
            context.read<OrderHistoryCubit>().getOrdersList();
          } else if (state is CoreErrorExceptionState) {
            errorSnackBar(context, state.error);
          }
        },
        buildWhen: (_, state) => state is AvailableDoctorsList || state is EmptyAvailableListState,
        builder: (context, state) {
          if (state is AvailableDoctorsList) {
            return AppLoadingWidget(
              isLoading: state.isLoading,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: CommonAppBar(
                  S.of(context).chooseSpecialist,
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
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: GoogleFonts.ubuntu(
                          fontSize: 16,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const HBox(16),
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.doctors.length,
                        separatorBuilder: (_, __) => const HBox(16),
                        itemBuilder: (context, index) => DoctorOrderCard(
                          onTap: () {
                            final doctor = state.doctors.elementAt(index);
                            context.read<DoctorCallCubit>().createOrder(doctor);
                          },
                          doctor: state.doctors.elementAt(index),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is EmptyAvailableListState) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: CommonAppBar(
                S.of(context).chooseSpecialist,
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
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Center(
                  child: Column(
                    children: [
                      const HBox(64),
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset(AppIcons.icMedicalRecord),
                      ),
                      const HBox(24),
                      Text(
                        S.of(context).thereNoAvailableDoctors,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ubuntu(
                          fontSize: 24,
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      AppFilledColorButton(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OrderScheduleScreen(
                              serviceId: widget.serviceData.serviceId,
                              addressId: widget.serviceData.addressId,
                            ),
                          ),
                        ),
                        borderRadiusRadii: 16,
                        margin: const EdgeInsets.only(top: 24),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.calendar_today_outlined, color: Colors.white),
                            const WBox(12),
                            Text(
                              S.of(context).chooseNearTime,
                              style: GoogleFonts.ubuntu(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is CoreErrorExceptionState) {
            return NetworkErrorPage(
              onRefresh: () => context.read<DoctorCallCubit>().getDoctorsList(
                    widget.serviceData.serviceId,
                    widget.serviceData.addressId,
                    date: widget.date,
                  ),
            );
          }

          final isLoading = state is DoctorCallInitial && state.isLoading;
          return AppLoadingWidget(
            isLoading: isLoading,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: CommonAppBar(
                S.of(context).chooseSpecialist,
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
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.ubuntu(
                        fontSize: 16,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      children: [
                        SizedBox(
                          height: 70,
                          child: AppShimmerWidget(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        const HBox(16),
                        SizedBox(
                          height: 75,
                          child: AppShimmerWidget(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        const HBox(16),
                        SizedBox(
                          height: 75,
                          child: AppShimmerWidget(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
