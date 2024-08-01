import 'package:allmed/common/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BannerIndicatorWidget extends StatelessWidget {
  const BannerIndicatorWidget(this.pageIndex, {Key? key}) : super(key: key);

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => Expanded(
          child: Container(
            height: 4,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: pageIndex >= index ? Colors.white : AppColors.lightGray,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  color: Colors.black.withOpacity(.08),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
