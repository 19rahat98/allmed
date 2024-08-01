import 'dart:math' as math;
import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/presentation/widgets/app_bars/common_app_bar.dart';
import 'package:allmed/common/presentation/widgets/app_wbox_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/address/user_address/presentation/cubit/address_cubit.dart';
import 'package:allmed/feature/doctor_call_on_mode/presentation/ui/choose_doctor_screen.dart';
import 'package:allmed/feature/doctor_call_on_mode/presentation/ui/widgets/call_on_mode_banner.dart';
import 'package:allmed/feature/doctor_service/data/model/doctor_dto.dart';
import 'package:allmed/feature/orders/presentation/order_schedule/ui/order_schedule_screen.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoctorCallOnTypeScreen extends StatelessWidget {
  const DoctorCallOnTypeScreen({
    super.key,
    this.price = GlobalCoreConstants.empty,
    this.serviceId = GlobalCoreConstants.zeroInt,
  });

  final int serviceId;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        S.of(context).serviceDoctor,
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
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: CallOnModeBanner(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChooseDoctorScreen(
                      title: S.of(context).doctorsForNearTime,
                      serviceData: DoctorServiceModel(
                        serviceId: serviceId,
                        servicePrice: price,
                        addressId: context.read<AddressCubit>().mainAddressIndex(),
                      ),
                    ),
                  ),
                ),
                title: S.of(context).callDoctorNow,
                icon: AppSvgIcons.icAddSquareOutline,
              ),
            ),
            const WBox(16),
            Expanded(
              child: CallOnModeBanner(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OrderScheduleScreen(
                      serviceId: serviceId,
                      addressId: context.read<AddressCubit>().mainAddressIndex(),
                    ),
                  ),
                ),
                title: S.of(context).scheduleCall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
