import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/utils/mixins/ignore_double_tap_mixim.dart';
import 'package:flutter/material.dart';

class AppOutlineButtonWidget extends StatelessWidget with IgnoreDoubleTapMixin {
  AppOutlineButtonWidget({
    super.key,
    this.height,
    this.child,
    this.width,
    this.onTap,
    this.color,
    this.constraints,
    this.borderRadiusRadii = 0.0,
    this.borderWidth = 1.0,
    this.borderColor = AppColors.lightGray,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  });

  /// дочерний элемент
  final Widget? child;

  /// ширина
  final double? width;

  /// высота
  final double? height;

  /// внутреннний отступ
  final EdgeInsetsGeometry padding;

  /// округление фигуры
  final double borderRadiusRadii;

  /// обратный вызов при нажатии на виджет
  final GestureTapCallback? onTap;

  /// цвет виджета
  final Color? color;

  /// цвет виджета
  final Color borderColor;

  /// толщина границы
  final double borderWidth;

  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: constraints ??
          BoxConstraints(
            minHeight: height ?? 0,
            minWidth: width ?? 0,
          ),
      child: OutlinedButton(
        onPressed: () {
          if (!isRedundantClick) {
            onTap?.call();
          }
        },
        style: OutlinedButton.styleFrom(
          elevation: 0,
          padding: padding,
          backgroundColor: color,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          side: BorderSide(
            width: borderWidth,
            color: borderColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusRadii),
          ),
        ),
        child: child,
      ),
    );
  }
}
