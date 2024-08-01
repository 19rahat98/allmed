import 'package:allmed/common/presentation/widgets/app_outline_button_widget.dart';
import 'package:allmed/common/presentation/widgets/app_wbox_widget.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadAvatarWidget extends StatelessWidget {
  const UploadAvatarWidget(this.symbol, {Key? key}) : super(key: key);

  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 185,
            height: 185,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.lightGray,
            ),
            child: Center(
              child: Text(
                symbol,
                style: GoogleFonts.ubuntu(
                  fontSize: 100,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Center(
              child: AppOutlineButtonWidget(
                borderRadiusRadii: 100,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.camera_alt_rounded, color: AppColors.black),
                    const WBox(8),
                    Text(
                      S.current.add,
                      style: GoogleFonts.ubuntu(
                        fontSize: 14,
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
