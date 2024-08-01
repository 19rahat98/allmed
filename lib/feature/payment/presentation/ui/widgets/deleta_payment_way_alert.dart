import 'package:allmed/common/presentation/widgets/app_filled_color_button.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_outline_button_widget.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeletePaymentWayAlert extends StatelessWidget {
  const DeletePaymentWayAlert({this.onDelete, super.key});

  final Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).deletePaymentWay,
            style: GoogleFonts.ubuntu(
              fontSize: 16,
              color: AppColors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          const HBox(20), // Добавляем отступ между текстом и кнопками
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Кнопка "Нет"
              AppOutlineButtonWidget(
                onTap: () => Navigator.pop(context),
                color: Colors.white,
                borderRadiusRadii: 100,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  S.of(context).net,
                  style: GoogleFonts.ubuntu(
                    fontSize: 16,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              AppFilledColorButton(
                onTap: onDelete,
                color: AppColors.red,
                borderRadiusRadii: 100,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  S.of(context).yes,
                  style: GoogleFonts.ubuntu(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void showDeletePaymentAlert(BuildContext context, {Function()? onDelete}) => showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (BuildContext context) => DeletePaymentWayAlert(onDelete: onDelete),
    );
