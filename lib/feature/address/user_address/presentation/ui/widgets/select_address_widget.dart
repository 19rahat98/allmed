import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/widgets/app_shimmer_widget.dart';
import 'package:allmed/common/presentation/widgets/app_wbox_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/address/user_address/presentation/cubit/address_cubit.dart';
import 'package:allmed/feature/address/user_address/presentation/ui/widgets/select_address_modal_sheet.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectAddressBanner extends StatelessWidget {
  const SelectAddressBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, CoreState>(
      builder: (context, state) {
        if (state is UserAddressListState && state.isLoading) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(
              width: 140,
              height: 24,
              child: AppShimmerWidget(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        } else if (state is UserAddressListState && state.mainAddress != null) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              height: 40,
              child: InkWell(
                onTap: () => showSelectAddressModalSheet(context),
                borderRadius: BorderRadius.circular(12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const WBox(12),
                    Flexible(
                      child: Text(
                        state.mainAddress!.address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.title2,
                      ),
                    ),
                    const WBox(10),
                    SvgPicture.asset(AppSvgIcons.icAltArrowDown),
                    const WBox(12),
                  ],
                ),
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: InkWell(
            onTap: () => showSelectAddressModalSheet(context),
            borderRadius: BorderRadius.circular(100),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const WBox(12),
                Text(
                  S.of(context).addAddress,
                  style: AppTextStyle.title2,
                ),
                const WBox(10),
                SvgPicture.asset(AppSvgIcons.icAltArrowDown),
                const WBox(12),
              ],
            ),
          ),
        );
      },
    );
  }
}
