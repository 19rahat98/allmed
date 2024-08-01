import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/address/new_address/presentation/ui/additional_address_detail_screen.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class AddNewRegionButton extends StatelessWidget {
  const AddNewRegionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppColors.superGray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      onTap: () => pushScreen(
        context,
        withNavBar: false,
        screen: const AdditionalAddressBuilder(),
      ),
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      title: Text(
        S.current.addressNewAddress,
        style: GoogleFonts.ubuntu(
          fontSize: 16,
          color: AppColors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: SvgPicture.asset(AppSvgIcons.icAddCircleFilled),
    );
  }
}
