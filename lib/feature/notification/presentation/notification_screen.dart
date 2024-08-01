import 'package:allmed/common/presentation/widgets/app_bars/common_app_bar.dart';
import 'package:allmed/feature/notification/presentation/widgets/notification_item_widget.dart';
import 'package:allmed/feature/notification/presentation/widgets/notification_rating_card.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(S.current.notification, enableBack: true),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            NotificationItemWidget(
              'Обновление v1.0.0',
              isSelected: true,
              subTitle:
                  '- Исправили уведомления \n- Баги при авторизации\n- Добавили новый функционал',
            ),
            NotificationStarCard(
              'Вызов врача',
              subTitle: 'Оцените услуги врача',
            ),
            NotificationItemWidget(
              'Добро пожаловать!',
              subTitle: 'Приветствуем вас в нашем приложение Allmed',
            ),
          ],
        ),
      ),
    );
  }
}
