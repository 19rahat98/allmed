import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/widgets/app_filled_color_button.dart';
import 'package:allmed/common/presentation/widgets/app_loading_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/address/new_address/presentation/cubit/select_address_cubit.dart';
import 'package:allmed/feature/address/new_address/presentation/ui/add_new_address_screen.dart';
import 'package:allmed/feature/address/new_address/presentation/ui/widgets/map_point.dart';
import 'package:allmed/feature/address/new_address/presentation/ui/widgets/yandex_map_screen.dart';
import 'package:allmed/feature/address/user_address/data/model/addresses_dto.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdditionalAddressBuilder extends StatelessWidget {
  const AdditionalAddressBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SelectAddressCubit()..initCubit(),
      child: const AdditionalAddressDetailScreen(),
    );
  }
}

class AdditionalAddressDetailScreen extends StatefulWidget {
  const AdditionalAddressDetailScreen({Key? key}) : super(key: key);

  @override
  State<AdditionalAddressDetailScreen> createState() => _AdditionalAddressDetailScreenState();
}

class _AdditionalAddressDetailScreenState extends State<AdditionalAddressDetailScreen> {
  late SelectAddressCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<SelectAddressCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectAddressCubit, CoreState>(
      buildWhen: (_, state) => state is SelectAddressCommonState,
      builder: (context, state) {
        if (state is SelectAddressCommonState) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              fit: StackFit.expand,
              children: [
                YandexMapScreen(
                  startPosition: state.startPosition,
                  onChangedPosition: _cubit.changePoint,
                ),
                MapPoint(showPoint: state.showPoint, address: state.address),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 40,
                  child: AppFilledColorButton(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddNewAddressBuilder(
                          addressData: AddressDto.fromGeoAddress(_cubit.geoAddress),
                        ),
                      ),
                    ),
                    height: 56,
                    borderRadiusRadii: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    color: state.showPoint ? AppColors.lightGray : AppColors.primaryColor,
                    child: Text(S.current.selectAddress, style: AppTextStyle.buttonStyle),
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 160,
                  child: InkWell(
                    onTap: _cubit.jumpToUserPosition,
                    child: SvgPicture.asset(AppSvgIcons.icMapArrow),
                  ),
                ),
                Positioned(
                  top: 64,
                  left: 20,
                  child: AppFilledColorButton(
                    onTap: () => Navigator.pop(context),
                    width: 40,
                    height: 40,
                    color: Colors.white.withOpacity(0.85),
                    borderRadiusRadii: 100,
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 12,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const AppLoadingWidget(
          isLoading: true,
          child: Scaffold(),
        );
      },
    );
  }
}
