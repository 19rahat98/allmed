import 'package:allmed/common/contants/global_common_constants.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/contacts/presentation/ui/widgets/contact_methed_tile.dart';
import 'package:allmed/feature/information/presentation/faq/ui/faq_screen.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:allmed/utils/launcher_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 100,
        centerTitle: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                S.current.back,
                style: AppTextStyle.caption1,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(AppSvgIcons.icContactsFrame),
            const HBox(16),
            Text(
              S.current.contact,
              style: GoogleFonts.ubuntu(
                fontSize: 22,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const HBox(12),
            Text(
              S.current.ifYouHaveQuestionChatManager,
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                fontSize: 16,
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            const HBox(40),
            ContactMethodTile(
              onTap: () => pushScreen(
                context,
                withNavBar: true,
                screen: const FaqScreen(isFromNavBar: false),
              ),
              title: S.current.faq,
              subTile: 'Часто задаваемые вопросы',
            ),
            const HBox(16),
            ContactMethodTile(
              onTap: () => launchLinks(
                GlobalCommonConstants.whatsApp,
                type: LaunchLinksType.phone,
              ),
              title: S.current.chat,
              icon: AppSvgIcons.icChatLine,
              subTile: 'Месенджер Allmed',
            ),
            const HBox(16),
            ContactMethodTile(
              onTap: () => launchLinks(
                GlobalCommonConstants.phoneNumber,
                type: LaunchLinksType.phone,
              ),
              title: S.current.callToManager,
              icon: AppSvgIcons.icPhoneRounded,
              subTile: '24/7',
            ),
            const HBox(16),
            ContactMethodTile(
              onTap: () => launchLinks(GlobalCommonConstants.instagram),
              title: 'Instagram',
              icon: AppSvgIcons.icInstagram,
              subTile: 'Подпишитесь на нас',
            ),
            const HBox(16),
          ],
        ),
      ),
    );
  }
}
