import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

/// открываем любую ссылку вне приложения
Future<void> launchLinks(
  String link, {
  bool isOpenOnApp = false,
  LaunchLinksType type = LaunchLinksType.web,
}) async {
  final link0 = Uri.parse(
    createUriLink(link, type: type),
  );
  if (await canLaunchUrl(link0)) {
    await launchUrl(
      link0,
      mode: isOpenOnApp ? LaunchMode.externalApplication : LaunchMode.platformDefault,
    );
  }
}

String createUriLink(
  String value, {
  required LaunchLinksType type,
}) {
  switch (type) {
    case LaunchLinksType.email:
      return 'mailto: $value?';
    case LaunchLinksType.phone:
      return 'tel: $value';
    case LaunchLinksType.telegram:
      return 'https://t.me/$value';
    case LaunchLinksType.whatsApp:
      return 'https://wa.me/$value';
    case LaunchLinksType.web:
      return value;
  }
}

/// открывает приложение в магазине
void openStore() {
  StoreRedirect.redirect(
    iOSAppId: '1669200360',
    androidAppId: 'broker.investlink.io.investlink_broker',
  );
}

enum LaunchLinksType {
  web,
  whatsApp,
  telegram,
  email,
  phone,
}
