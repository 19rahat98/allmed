import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/screens/errors/404_error_page.dart';
import 'package:allmed/common/presentation/widgets/app_bars/common_app_bar.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/address/region/presentation/ui/widgets/add_new_region_button.dart';
import 'package:allmed/feature/address/region/presentation/ui/widgets/filled_region_tile.dart';
import 'package:allmed/feature/address/user_address/presentation/cubit/address_cubit.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class RegionScreen extends StatelessWidget {
  const RegionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, CoreState>(
      builder: (context, state) {
        if (state is UserAddressListState) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: CommonAppBar(S.current.region, enableBack: true),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.current.myAddress,
                    style: GoogleFonts.ubuntu(
                      fontSize: 20,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const HBox(8),
                  Text(
                    S.current.setInfoAboutAddressForCallDoctor,
                    style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.gray,
                    ),
                  ),
                  const HBox(24),
                  const AddNewRegionButton(),
                  const HBox(16),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.addresses.length,
                    separatorBuilder: (context, _) => const HBox(16),
                    itemBuilder: (context, index) => FilledRegionTile(
                      state.addresses.elementAt(index),
                      number: index + 1,
                      address: state.addresses.elementAt(index).address,
                      additionAddress: state.addresses.elementAt(index).additional,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return NetworkErrorPage(
          onRefresh: context.read<AddressCubit>().loadAddressList,
        );
      },
    );
  }
}
