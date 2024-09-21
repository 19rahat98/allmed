import 'dart:math' as math;

import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/home_scren/data/model/banner_model.dart';
import 'package:allmed/utils/launcher_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BannerContentScreen extends StatelessWidget {
  const BannerContentScreen(this.item, {super.key});

  final BannerModel item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 390,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(item.fullImageUrl),
                ),
              ),
              alignment: Alignment.topLeft,
              child: SafeArea(
                bottom: false,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  icon: Transform.rotate(
                    angle: math.pi / 2,
                    child: SvgPicture.asset(
                      AppSvgIcons.icAltArrowDown,
                      color: Colors.white,
                      width: 28,
                    ),
                  ),
                ),
              ),
            ),
            const HBox(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Text(
                item.title,
                style: AppTextStyle.title1.copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(item.description, style: AppTextStyle.caption1),
            ),
            const HBox(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Text(
                item.createdAt,
                style: AppTextStyle.base.copyWith(
                  color: AppColors.gray,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            InkWell(
              onTap: () => launchLinks(item.sourceUrl),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Источник: ',
                    style: AppTextStyle.caption1,
                    children: <TextSpan>[
                      TextSpan(
                        text: item.urlStr,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => launchLinks(item.sourceUrl),
                        style: AppTextStyle.caption1.copyWith(color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const HBox(40),
          ],
        ),
      ),
    );
  }
}
