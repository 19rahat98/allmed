import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/widgets/app_filled_color_button.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_loading_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/address/new_address/presentation/ui/add_new_address_screen.dart';
import 'package:allmed/common/presentation/widgets/app_modal_header.dart';
import 'package:allmed/feature/address/new_address/presentation/ui/additional_address_detail_screen.dart';
import 'package:allmed/feature/address/user_address/data/model/addresses_dto.dart';
import 'package:allmed/feature/address/user_address/presentation/cubit/address_cubit.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectAddressModalWidget extends StatelessWidget {
  const SelectAddressModalWidget({super.key, this.onContinue});

  final Function()? onContinue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, CoreState>(
      buildWhen: (_, state) => state is UserAddressListState,
      builder: (context, state) {
        if (state is UserAddressListState) {
          return Material(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            clipBehavior: Clip.hardEdge,
            child: AppLoadingWidget(
              isLoading: state.isLoading,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppModalHeader(S.current.whereCallDoctor),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.addresses.length,
                    padding: const EdgeInsets.only(bottom: 12),
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => const HBox(8),
                    itemBuilder: (context, index) => _AddressSelectorTileBox(
                      state.addresses.elementAt(index),
                    ),
                  ),
                  const _AddNewAddressTile(),
                  const HBox(20),
                  if (onContinue != null) ...[
                    AppFilledColorButton(
                      onTap: () {
                        if (state.addresses.isNotEmpty) {
                          Navigator.pop(context);
                          onContinue?.call();
                        }
                      },
                      height: 56,
                      borderRadiusRadii: 100,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      color: state.isEmpty ? AppColors.lightGray : AppColors.primaryColor,
                      child: Text(S.current.continueTxt, style: AppTextStyle.buttonStyle),
                    ),
                    const HBox(30),
                  ],
                ],
              ),
            ),
          );
        }

        return Material(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppModalHeader(S.current.whereCallDoctor),
              const _AddNewAddressTile(),
              const HBox(20),
              if (onContinue != null) ...[
                AppFilledColorButton(
                  onTap: () {
                    Navigator.pop(context);
                    onContinue?.call();
                  },
                  height: 56,
                  borderRadiusRadii: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(S.current.continueTxt, style: AppTextStyle.buttonStyle),
                ),
                const HBox(30),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _AddressSelectorTileBox extends StatelessWidget {
  const _AddressSelectorTileBox(this.address, {super.key});

  final AddressDto address;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          context.read<AddressCubit>().deleteAddress(address.id);
        }
      },
      key: ValueKey(address.id),
      dismissThresholds: const {
        DismissDirection.startToEnd: 2.00,
        DismissDirection.endToStart: 0.3,
      },
      background: const SizedBox.shrink(),
      secondaryBackground: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        color: AppColors.error,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.restore_from_trash_rounded,
            color: Colors.white,
          ),
        ),
      ),
      child: ListTile(
        onTap: () => context.read<AddressCubit>().changeMainAddress(address.id),
        dense: true,
        tileColor: Colors.white,
        contentPadding: const EdgeInsets.only(left: 22, right: 44),
        splashColor: AppColors.secondary.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          S.current.yourAddress,
          style: AppTextStyle.secondary,
        ),
        subtitle: Text(
          address.address,
          style: AppTextStyle.title2.copyWith(fontSize: 16),
        ),
        leading: Visibility(
          visible: address.selected,
          replacement: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.lightGray),
            ),
          ),
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.lightGray),
            ),
            padding: const EdgeInsets.all(5),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.black,
              ),
            ),
          ),
        ),
        trailing: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddNewAddressBuilder(addressData: address, enableChange: true),
            ),
          ),
          icon: SvgPicture.asset(AppSvgIcons.icPenOutline),
        ),
      ),
    );
  }
}

class _AddNewAddressTile extends StatelessWidget {
  const _AddNewAddressTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const AdditionalAddressBuilder(),
        ),
      ),
      dense: true,
      tileColor: Colors.white,
      contentPadding: const EdgeInsets.only(left: 22, right: 44),
      splashColor: AppColors.secondary.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        S.current.addressNewAddress,
        style: AppTextStyle.base.copyWith(fontSize: 16),
      ),
      leading: SvgPicture.asset(AppSvgIcons.icAddCircleOutline),
    );
  }
}

Future<void> showSelectAddressModalSheet(BuildContext context, {Function()? onContinue}) {
  return showModalBottomSheet<void>(
    context: context,
    elevation: 0,
    useSafeArea: true,
    useRootNavigator: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    backgroundColor: Colors.white,
    barrierColor: Colors.black.withOpacity(0.4),
    builder: (context) => SelectAddressModalWidget(onContinue: onContinue),
  );
}
