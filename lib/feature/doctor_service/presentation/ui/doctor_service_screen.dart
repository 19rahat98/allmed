import 'dart:math' as math;
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/screens/errors/404_error_page.dart';
import 'package:allmed/common/presentation/widgets/app_bars/common_app_bar.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_shimmer_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/address/user_address/presentation/ui/widgets/select_address_modal_sheet.dart';
import 'package:allmed/feature/doctor_call_on_mode/presentation/ui/doctor_call_on_type_screen.dart';
import 'package:allmed/feature/doctor_service/presentation/cubit/doctor_service_cubit.dart';
import 'package:allmed/feature/doctor_service/presentation/ui/widgets/doctor_type_item.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoctorServiceScreen extends StatefulWidget {
  const DoctorServiceScreen(this.serviceId, {super.key});

  final String serviceId;

  @override
  State<DoctorServiceScreen> createState() => _DoctorServiceScreenState();
}

class _DoctorServiceScreenState extends State<DoctorServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorServiceCubit()..getServices(widget.serviceId),
      child: BlocBuilder<DoctorServiceCubit, CoreState>(
        builder: (context, state) {
          if (state is DoctorServiceListState) {
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
              body: ListView.separated(
                itemCount: state.services.length,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                separatorBuilder: (context, _) => const HBox(16),
                itemBuilder: (context, index) => DoctorTypeItem(
                  state.services.elementAt(index).name,
                  onTap: () => showSelectAddressModalSheet(
                    context,
                    onContinue: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DoctorCallOnTypeScreen(
                          serviceId: state.services.elementAt(index).id,
                          price: state.services.elementAt(index).expectedPrice,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else if (state is CoreErrorExceptionState) {
            return NetworkErrorPage(
              onRefresh: () => context.read<DoctorServiceCubit>().getServices(widget.serviceId),
            );
          }
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
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
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
          );
        },
      ),
    );
  }
}
