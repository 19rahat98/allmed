import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/address/new_address/presentation/ui/add_new_address_screen.dart';
import 'package:allmed/feature/address/user_address/data/model/addresses_dto.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilledRegionTile extends StatelessWidget {
  const FilledRegionTile(
    this.addressData, {
    Key? key,
    required this.number,
    required this.address,
    required this.additionAddress,
  }) : super(key: key);

  final int number;
  final String address;
  final AddressDto addressData;
  final String additionAddress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AddNewAddressBuilder(addressData: addressData),
        ),
      ),
      tileColor: AppColors.superGray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      title: Text(
        address,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.ubuntu(
          fontSize: 16,
          color: AppColors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            additionAddress,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.ubuntu(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: AppColors.gray,
            ),
          ),
          Text(
            S.current.change,
            maxLines: 1,
            style: GoogleFonts.ubuntu(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryColor,
            ),
          )
        ],
      ),
      leading: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.secondary,
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: GoogleFonts.ubuntu(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
