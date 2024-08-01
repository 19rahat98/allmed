import 'dart:math' as math;

import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/screens/errors/404_error_page.dart';
import 'package:allmed/common/presentation/widgets/app_bars/common_app_bar.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_shimmer_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/doctor_service/presentation/ui/widgets/doctor_type_item.dart';
import 'package:allmed/feature/information/presentation/terms/cubit/terms_cubit.dart';
import 'package:allmed/feature/information/presentation/terms/ui/term_info_screen.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class TermsListScreen extends StatelessWidget {
  const TermsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TermsCubit()..getTermsList(),
      child: BlocBuilder<TermsCubit, CoreState>(
        builder: (context, state) {
          if (state is TermsState) {
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
                itemCount: state.data.length,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                separatorBuilder: (context, _) => const HBox(16),
                itemBuilder: (context, index) => DoctorTypeItem(
                  state.data.elementAt(index).title,
                  onTap: () => pushScreen(
                    context,
                    screen: TermInfoScreen(state.data.elementAt(index).id),
                  ),
                ),
              ),
            );
          } else if (state is CoreErrorExceptionState) {
            return NetworkErrorPage(
              onRefresh: context.read<TermsCubit>().getTermsList,
            );
          }
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: CommonAppBar(
              S.of(context).info,
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
