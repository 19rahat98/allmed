import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_wbox_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MapPoint extends StatelessWidget {
  const MapPoint({super.key, this.showPoint = false, this.address});

  final bool showPoint;
  final String? address;

  @override
  Widget build(BuildContext context) {
    if (showPoint) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppSvgIcons.icMapPoint, height: 56),
            Container(
              width: 4,
              height: 28,
              color: AppColors.black,
              margin: const EdgeInsets.only(bottom: 84),
            ),
          ],
        ),
      );
    }

    return Center(
      child: Container(
        padding: const EdgeInsets.all(8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width / 1.5,
        ),
        margin: const EdgeInsets.only(bottom: 84),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.lightGray),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppSvgIcons.icMapPointFilled),
            const WBox(8),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Точка вызова',
                    style: GoogleFonts.ubuntu(
                      fontSize: 11,
                      color: AppColors.gray,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const HBox(2),
                  Flexible(
                    child: Text(
                      address ?? GlobalCoreConstants.empty,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.ubuntu(
                        fontSize: 12,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
