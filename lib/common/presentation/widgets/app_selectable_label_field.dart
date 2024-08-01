import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppSelectableLabelField extends StatelessWidget {
  const AppSelectableLabelField({
    Key? key,
    required this.label,
    required this.onTap,
    this.margin,
    this.value,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(12),
    ),
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  }) : super(key: key);

  /// лайдел текстового поля
  final String label;

  /// значение текстового поля
  final String? value;

  /// добавляет margin
  final EdgeInsetsGeometry? margin;

  /// добавляет паддинг для контента(label или text)
  final EdgeInsetsGeometry contentPadding;

  /// радиус округления
  final BorderRadius borderRadius;

  /// Обработчик нажатие
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: Container(
        margin: margin,
        padding: value?.isEmpty ?? true
            ? contentPadding
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.lightGray,
          ),
          borderRadius: borderRadius,
        ),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (value?.isEmpty ?? true) {
      return Text(
        label,
        maxLines: 1,
        textAlign: TextAlign.start,
        style: AppTextStyle.secondary.copyWith(fontWeight: FontWeight.w400),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          maxLines: 1,
          style: AppTextStyle.secondary.copyWith(fontWeight: FontWeight.w400, fontSize: 10),
        ),
        const HBox(4),
        Text(
          value ?? GlobalCoreConstants.empty,
          maxLines: 1,
          style: AppTextStyle.caption1,
        ),
      ],
    );
  }
}
