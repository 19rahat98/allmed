import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef RatingChangeCallback = void Function(double rating);

class AppStarRating extends StatelessWidget {
  const AppStarRating({
    super.key,
    this.starCount = 5,
    this.spacing = 0.0,
    this.rating = 0.0,
    this.defaultIconData,
    this.onRatingChanged,
    this.color,
    this.size = 14,
    this.filledIconData,
    this.halfFilledIconData,
    this.allowHalfRating = true,
  });

  final int starCount;
  final double rating;
  final RatingChangeCallback? onRatingChanged;
  final Color? color;
  final double size;
  final bool allowHalfRating;
  final IconData? filledIconData;
  final IconData? halfFilledIconData;
  final IconData? defaultIconData;
  final double spacing;

  Widget buildStar(BuildContext context, int index) {
    Widget icon;
    if (index >= rating) {
      icon = SvgPicture.asset(
        AppSvgIcons.icStar,
        color: AppColors.lightGray,
        width: size,
      );
    } else if (index > rating - (allowHalfRating ? 1.0 : 0.5) && index < rating) {
      icon = SvgPicture.asset(
        AppSvgIcons.icStar,
        width: size,
        color: AppColors.lightGray,
      );
    } else {
      icon = SvgPicture.asset(
        AppSvgIcons.icStar,
        width: size,
        color: color ?? const Color(0xFFFFDA44),
      );
    }

    return GestureDetector(
      onTap: () {
        if (onRatingChanged != null) onRatingChanged?.call(index + 1.0);
      },
      onHorizontalDragUpdate: (dragDetails) {
        RenderBox box = context.findRenderObject() as RenderBox;
        var pos = box.globalToLocal(dragDetails.globalPosition);
        var i = pos.dx / size;
        var newRating = allowHalfRating ? i.round().toDouble() : i;
        if (newRating > starCount) {
          newRating = starCount.toDouble();
        }
        if (newRating < 0) {
          newRating = 0.0;
        }
        if (onRatingChanged != null) onRatingChanged?.call(newRating);
      },
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: spacing,
        children: List.generate(
          starCount,
          (index) => buildStar(context, index),
        ),
      ),
    );
  }
}
