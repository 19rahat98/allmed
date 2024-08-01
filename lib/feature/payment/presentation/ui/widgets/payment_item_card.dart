import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentItemCard extends StatelessWidget {
  const PaymentItemCard(
    this.title, {
    this.onDelete,
    this.onSelect,
    this.icVisa = false,
    this.active = false,
    super.key,
  });

  final bool icVisa;
  final String title;
  final bool active;
  final Function(int)? onDelete;
  final Function()? onSelect;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onSelect,
      dense: true,
      tileColor: AppColors.superGray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: EdgeInsets.fromLTRB(12, 6, onSelect != null ? 12 : 6, 6),
      title: Text(
        title,
        style: GoogleFonts.ubuntu(
          fontSize: 16,
          color: AppColors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: SizedBox(
        width: 40,
        child: Image.asset(icVisa ? AppIcons.icVisa : AppIcons.icMasterCard),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 38,
            child: IconButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              icon: SvgPicture.asset(AppSvgIcons.icInfoCircleFilled),
            ),
          ),
          Visibility(
            visible: onSelect != null,
            replacement: SizedBox(
              width: 38,
              child: IconButton(
                onPressed: () => onDelete?.call(2),
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(AppSvgIcons.icMinusCircle),
              ),
            ),
            child: Container(
              width: 24,
              height: 24,
              clipBehavior: Clip.hardEdge,
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.lightGray, width: 2),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: active ? AppColors.black : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
