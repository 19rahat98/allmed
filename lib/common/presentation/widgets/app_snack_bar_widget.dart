import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_wbox_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

/// снэкбар для алертов при успешном сценарии
void successSnackBar(BuildContext context, String? title, {String? subTitle}) {
  return topSingleLineSnackBar(context, title ?? GlobalCoreConstants.empty);
}

/// снэкбар для алертов при возникновение ошибок
void errorSnackBar(BuildContext context, String? title, {String? subTitle, String? icon}) {
  return topSingleLineSnackBar(
    context,
    title?.isNotEmpty == true ? title! : S.current.errorOccurred,
  );
}

/// снэкбар для алертов при успешном изменении ордера
void successUpdateSnackBar(
  BuildContext context, {
  required String title,
  required String subtitle,
  Color? background,
}) {
  AnimationController? localAnimationController;
  return showTopSnackBar(
    Overlay.of(context),
    Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 16, 0, 16),
        decoration: BoxDecoration(
          color: background ?? AppColors.rdBlack,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: const Offset(0, 10),
              color: AppColors.black.withOpacity(.4),
              spreadRadius: 1,
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              IntrinsicWidth(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      AppSvgIcons.icInfoCircle,
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
              ),
              const WBox(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyle.caption1.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const HBox(8),
                    Text(
                      subtitle,
                      style: AppTextStyle.secondary.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => localAnimationController?.reverse(),
                splashRadius: 24,
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(
                  AppSvgIcons.icClose,
                  width: 16,
                  height: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    dismissType: DismissType.onSwipe,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    displayDuration: const Duration(milliseconds: 6000),
    dismissDirection: [DismissDirection.up, DismissDirection.horizontal],
    onAnimationControllerInit: (controller) => localAnimationController = controller,
  );
}

/// снэкбар сверху
void topSnackBar(
  BuildContext context,
  String title,
  String subTitle, {
  Widget? icon,
  Color? background,
}) {
  AnimationController? localAnimationController;
  return showTopSnackBar(
    Overlay.of(context),
    Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 16, 0, 16),
        decoration: BoxDecoration(
          color: background ?? AppColors.rdBlack,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: const Offset(0, 10),
              color: AppColors.black.withOpacity(.4),
              spreadRadius: 1,
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              IntrinsicWidth(
                child: Column(
                  children: [
                    icon ??
                        SvgPicture.asset(
                          AppSvgIcons.icInfoCircle,
                          width: 24,
                          height: 24,
                        ),
                  ],
                ),
              ),
              const WBox(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyle.caption1.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const HBox(8),
                    Flexible(
                      child: Text(
                        subTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.secondary.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => localAnimationController?.reverse(),
                splashRadius: 24,
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(
                  AppSvgIcons.icClose,
                  width: 16,
                  height: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    dismissType: DismissType.onSwipe,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    displayDuration: const Duration(milliseconds: 6000),
    dismissDirection: [DismissDirection.up, DismissDirection.horizontal],
    onAnimationControllerInit: (controller) => localAnimationController = controller,
  );
}

void topSingleLineSnackBar(
  BuildContext context,
  String title, {
  Widget? icon,
  Color? background,
}) {
  AnimationController? localAnimationController;
  return showTopSnackBar(
    Overlay.of(context),
    Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 0, 12),
        decoration: BoxDecoration(
          color: background ?? AppColors.rdBlack,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: const Offset(0, 10),
              color: AppColors.black.withOpacity(.4),
              spreadRadius: 1,
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              icon ??
                  SvgPicture.asset(
                    AppSvgIcons.icInfoCircle,
                    width: 24,
                    height: 24,
                  ),
              const WBox(12),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.caption1.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => localAnimationController?.reverse(),
                splashRadius: 24,
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(
                  AppSvgIcons.icClose,
                  width: 20,
                  height: 20,
                ),
              ),
              const WBox(4),
            ],
          ),
        ),
      ),
    ),
    reverseCurve: Curves.linear,
    dismissType: DismissType.onSwipe,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    displayDuration: const Duration(milliseconds: 6000),
    onAnimationControllerInit: (controller) => localAnimationController = controller,
    dismissDirection: [DismissDirection.up, DismissDirection.horizontal],
  );
}
