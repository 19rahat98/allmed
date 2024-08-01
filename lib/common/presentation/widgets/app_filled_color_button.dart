import 'dart:io';

import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/utils/mixins/ignore_double_tap_mixim.dart';
import 'package:flutter/material.dart';

/// кнопка с заполненным цветом
class AppFilledColorButton extends StatelessWidget with IgnoreDoubleTapMixin {
  AppFilledColorButton({
    Key? key,
    this.height,
    this.child,
    this.width,
    this.onTap,
    this.borderRadiusRadii = 0.0,
    this.padding,
    this.margin,
    this.color,
    this.shapeBorder,
    this.tapTargetSize,
    this.minimumSize,
  }) : super(key: key);

  // Опциональный параметр, определяющий радиус скругления границ виджета.
  final BorderRadius? shapeBorder;

  /// дочерний элемент
  final Widget? child;

  /// ширина
  final double? width;

  /// высота
  final double? height;

  /// внутреннний отступ
  final EdgeInsetsGeometry? padding;

  /// внешний отступ
  final EdgeInsetsGeometry? margin;

  /// округление фигуры
  final double borderRadiusRadii;

  final Color? color;

  /// обратный вызов при нажатии на виджет
  final GestureTapCallback? onTap;

  /// Минимальный размер области, которая может реагировать на нажатия.
  /// Используется для определения размера области вокруг дочернего элемента, реагирующей на взаимодействие.
  final MaterialTapTargetSize? tapTargetSize;

  /// Минимальный размер виджета.
  /// Может использоваться для гарантии, что виджет не будет меньше определённого размера, даже если его содержимое меньше.
  final Size? minimumSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin ?? EdgeInsets.only(bottom: Platform.isAndroid ? 24 : 0),
      decoration: BoxDecoration(
        borderRadius: shapeBorder ??
            BorderRadius.all(
              Radius.circular(borderRadiusRadii),
            ),
      ),
      child: ElevatedButton(
        onPressed: () {
          if (!isRedundantClick) {
            onTap?.call();
          }
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: minimumSize,
          tapTargetSize: tapTargetSize,
          padding: padding ?? EdgeInsets.zero,
          backgroundColor: color ?? AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: shapeBorder ?? BorderRadius.circular(borderRadiusRadii),
          ),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
