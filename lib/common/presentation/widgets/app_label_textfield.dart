import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

/// базовый виджет для работы текст филдом
class AppLabelTextFieldWidget extends StatefulWidget {
  const AppLabelTextFieldWidget({
    Key? key,
    this.color,
    this.label,
    this.autofillHints,
    this.onValueChanged,
    this.isEnabled = true,
    this.onShowTrailingWhen,
    this.trailingOnCompleted,
    this.onShowTrailing,
    this.trailing,
    this.controller,
    this.inputType,
    this.focusNode,
    this.errorMessage,
    this.maxLength,
    this.textInputAction,
    this.margin,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
    this.onTap,
    this.labelWidget,
    this.textInputFormatters,
    this.prefixIconPath,
    this.sufixIconPath,
    this.hintTextValue,
    this.onSubmitted,
    this.isTextCapitalizationUpperCase = true,
    this.readOnly = false,
    this.autofocus = false,
    this.isPassword = false,
    this.removeButton = false,
    this.minLength = 1,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
  }) : super(key: key);

  final bool autofocus;

  /// цвет контенера
  final Color? color;

  /// лайдел текстового поля
  final String? label;

  /// лайдел виджет текстового поля
  final Widget? labelWidget;

  /// слушатель при вводе значение в текстовое поле
  final ValueChanged<String>? onValueChanged;

  /// автивное/неактивное текстовое поле
  final bool isEnabled;
  final bool readOnly;

  /// функция по условию
  final bool Function(String value)? onShowTrailingWhen;

  /// Вызывается, когда пользователь указывает,
  /// что он закончил редактировать текст в поле.
  final void Function(String value)? onSubmitted;

  /// виджет справой стороны при условии [onShowTrailingWhen]
  final Widget? trailingOnCompleted;

  /// событие при показе [trailing]
  final void Function()? onShowTrailing;

  /// виджет справой стороны
  final Widget? trailing;

  /// флаг для опередения пароля (ЕСЛИ УКАЗАН ДАННЫЙ ФЛАГ,
  /// ТО ДРУГИЕ ИКОНКИ С ЛЕВОЙ СТОРОНЫ НЕ БУДУТ ОТОБРАЖАТЬСЯ)
  final bool isPassword;

  /// контроллер для ввода текста
  final TextEditingController? controller;

  /// указываем тип поля
  final TextInputType? inputType;

  final FocusNode? focusNode;

  /// сообщение об ошибке
  final String? errorMessage;

  /// максимальная длина символов
  final int? maxLength;
  final int minLength;

  /// показывает action на кравиатуре, работает во всмеми типами кроме int
  final TextInputAction? textInputAction;

  /// добавляет margin
  final EdgeInsetsGeometry? margin;

  /// добавляет паддинг для контента(label или text)
  final EdgeInsetsGeometry contentPadding;

  /// радиус округления
  final BorderRadius? borderRadius;

  /// размер шрифта, который пишет пользователь
  final double? fontSize;

  /// толщина шрифта, который пишет пользователь
  final FontWeight? fontWeight;

  /// событие нажатия по полю
  final void Function()? onTap;

  /// форматтируем текст по запросу
  final List<TextInputFormatter>? textInputFormatters;

  /// путь для prefix иконки
  final String? prefixIconPath;

  /// путь для sufix иконки
  final String? sufixIconPath;

  /// указываем текст подсказки
  final String? hintTextValue;

  /// Настраивает, как клавиатура будет выбирать
  /// клавиатуру в верхнем или нижнем регистре.
  final bool isTextCapitalizationUpperCase;

  final Iterable<String>? autofillHints;

  final bool removeButton;

  @override
  State<AppLabelTextFieldWidget> createState() => _AppLabelTextFieldWidgetState();
}

class _AppLabelTextFieldWidgetState extends State<AppLabelTextFieldWidget> {
  /// флаг указывающий на скрыть/паказать пароль
  var _isViewPassword = false;

  bool _isViewTrailing = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _getContainerColor(),
                  border: Border.all(
                    color: (widget.errorMessage?.isNotEmpty ?? false)
                        ? AppColors.error
                        : AppColors.lightGray,
                  ),
                  borderRadius: widget.borderRadius ??
                      const BorderRadius.all(
                        Radius.circular(16),
                      ),
                ),
                child: TextField(
                  key: widget.key,
                  autocorrect: false,
                  autofocus: widget.autofocus,
                  autofillHints: widget.autofillHints,
                  onTap: () => widget.onTap?.call(),
                  textInputAction: widget.textInputAction,
                  focusNode: widget.focusNode,
                  onChanged: _onValueChanged,
                  style: AppTextStyle.caption1.copyWith(
                    color: widget.isEnabled ? AppColors.black : AppColors.gray,
                  ),
                  textCapitalization: widget.isTextCapitalizationUpperCase
                      ? TextCapitalization.words
                      : TextCapitalization.none,
                  maxLength: widget.maxLength,
                  maxLines: widget.minLength,
                  obscureText: widget.isPassword ? !_isViewPassword : false,
                  controller: widget.controller,
                  onSubmitted: widget.onSubmitted,
                  inputFormatters: widget.textInputFormatters,
                  decoration: InputDecoration(
                    label: widget.labelWidget,
                    isDense: true,
                    prefixIcon: widget.prefixIconPath?.isNotEmpty ?? false
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: SvgPicture.asset(
                              widget.prefixIconPath!,
                              color: AppColors.lightGray,
                            ),
                          )
                        : null,
                    suffixIcon: suffixIcon(),
                    suffixIconConstraints: const BoxConstraints(
                      maxWidth: 40,
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      maxWidth: 40,
                    ),
                    hintText: widget.hintTextValue,
                    hintStyle: AppTextStyle.caption1.copyWith(
                      color: AppColors.gray,
                    ),
                    labelText: widget.label,
                    border: InputBorder.none,
                    counterText: GlobalCoreConstants.empty,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    labelStyle: GoogleFonts.ubuntu(
                      fontSize: 14,
                      color: AppColors.gray,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: widget.contentPadding,
                  ),
                  keyboardType: widget.inputType ?? TextInputType.text,
                  enabled: widget.isEnabled,
                  readOnly: widget.readOnly,
                ),
              ),
              _getTrailingWidget()
            ],
          ),
          Visibility(
            visible: widget.errorMessage?.isNotEmpty ?? false,
            child: Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Text(
                _getErrorMessage(),
                style: AppTextStyle.base.copyWith(
                  color: AppColors.error,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// выводит ошибку
  String _getErrorMessage() {
    final errorMessage = widget.errorMessage ?? GlobalCoreConstants.empty;
    return errorMessage;
  }

  /// при вводе значение в текстовое поле
  void _onValueChanged(String value) {
    final isPassword = widget.isPassword;
    final isShowTrailing = widget.onShowTrailingWhen?.call(value) ?? false;

    if (!isPassword) {
      if (isShowTrailing) {
        widget.onShowTrailing?.call();
        _isViewTrailing = true;
      } else {
        _isViewTrailing = false;
      }
      setState(() {});
    }

    final controller = widget.controller;
    final onValueChanged = widget.onValueChanged;

    onValueChanged?.call(
      controller?.value.text ?? value,
    );
  }

  Widget _getTrailingWidget() {
    final isPassword = widget.isPassword;

    if (isPassword) {
      return Padding(
        padding: const EdgeInsets.only(right: 22),
        child: InkWell(
          onTap: () {
            setState(() {
              _isViewPassword = !_isViewPassword;
            });
          },
          child: SvgPicture.asset(
            _isViewPassword
                ? AppSvgIcons.icVisibilityOffPassword
                : AppSvgIcons.icVisibilityPassword,
            color: AppColors.black,
          ),
        ),
      );
    }

    if (_isViewTrailing) {
      return widget.trailingOnCompleted ?? const SizedBox();
    }
    return widget.trailing ?? const SizedBox();
  }

  Widget suffixIcon() {
    if (widget.removeButton && (widget.controller?.text.isNotEmpty ?? false)) {
      return InkWell(
        onTap: () {
          widget.controller?.clear();
          widget.onValueChanged?.call(GlobalCoreConstants.empty);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 7,
          ),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.gray,
          ),
          child: SvgPicture.asset(AppSvgIcons.icClose),
        ),
      );
    } else if (widget.sufixIconPath?.isNotEmpty ?? false) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: SvgPicture.asset(
          widget.sufixIconPath!,
          color: AppColors.gray,
        ),
      );
    } else if (!widget.isEnabled) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: SvgPicture.asset(
          AppSvgIcons.icLockKeyhole,
          color: AppColors.lightGray,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Color _getContainerColor() {
    if (!widget.isEnabled && widget.color == null) {
      return AppColors.superGray;
    } else if (widget.errorMessage?.isEmpty ?? true) {
      return widget.color ?? Colors.transparent;
    }

    return Colors.white;
  }
}

class AppTextFieldIcon {
  AppTextFieldIcon({
    this.icon,
    this.height,
    this.width,
  });

  final String? icon;
  final double? width;
  final double? height;
}
