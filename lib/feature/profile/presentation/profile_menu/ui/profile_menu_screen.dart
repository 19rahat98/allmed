import 'package:allmed/common/contants/global_common_constants.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/screens/errors/404_error_page.dart';
import 'package:allmed/common/presentation/widgets/app_bars/common_app_bar.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/address/region/presentation/ui/region_screen.dart';
import 'package:allmed/feature/auth/presentation/global_auth/cubit/global_auth_cubit.dart';
import 'package:allmed/feature/contacts/presentation/ui/constacts_screen.dart';
import 'package:allmed/feature/information/presentation/faq/ui/faq_screen.dart';
import 'package:allmed/feature/information/presentation/terms/ui/terms_list_screen.dart';
import 'package:allmed/feature/notification/presentation/notification_screen.dart';
import 'package:allmed/feature/payment/presentation/ui/payment_method_screen.dart';
import 'package:allmed/feature/profile/presentation/profile_menu/ui/widgets/menu_tile_item.dart';
import 'package:allmed/feature/profile/presentation/profile_menu/ui/widgets/profile_account_banner.dart';
import 'package:allmed/feature/profile/presentation/settings/settings_screen.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ProfileMenuScreen extends StatefulWidget {
  const ProfileMenuScreen({super.key});

  @override
  State<ProfileMenuScreen> createState() => _ProfileMenuScreenState();
}

class _ProfileMenuScreenState extends State<ProfileMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalAuthCubit, CoreState>(
      builder: (context, state) {
        if (state is GlobalSuccessAuthState) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: CommonAppBar(S.current.profile),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  ProfileAccountBanner(state.userDetail),
                  const HBox(28),
                  MenuTileItem(
                    onTap: () => pushScreen(
                      context,
                      withNavBar: false,
                      screen: const RegionScreen(),
                    ),
                    icon: AppSvgIcons.icCompassSquare,
                    title: S.current.myAddress,
                  ),
                  MenuTileItem(
                    onTap: () => pushScreen(
                      context,
                      screen: const SettingsScreen(),
                      withNavBar: false,
                    ),
                    icon: AppSvgIcons.icSettings,
                    title: S.current.setting,
                  ),
                  MenuTileItem(
                    onTap: () => pushScreen(
                      context,
                      screen: const NotificationScreen(),
                      withNavBar: false,
                    ),
                    icon: AppSvgIcons.icNotificationBellOutline,
                    title: S.current.notification,
                  ),
                  MenuTileItem(
                    onTap: () => pushScreen(
                      context,
                      screen: const PaymentMethodsScreen(),
                      withNavBar: false,
                    ),
                    icon: AppSvgIcons.icPayCard,
                    title: S.current.paymentMethod,
                  ),
                  MenuTileItem(
                    onTap: () => pushScreen(
                      context,
                      withNavBar: true,
                      screen: const ContactsScreen(),
                    ),
                    icon: AppSvgIcons.icChatLine,
                    title: S.current.contact,
                  ),
                  MenuTileItem(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FaqScreen(isFromNavBar: false),
                      ),
                    ),
                    icon: AppSvgIcons.icQuestionCircle,
                    title: S.current.faq,
                  ),
                  MenuTileItem(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TermsListScreen(),
                      ),
                    ),
                    icon: AppSvgIcons.icInfoCircle,
                    title: S.current.info,
                  ),
                  MenuTileItem(
                    onTap: context.read<GlobalAuthCubit>().logOut,
                    icon: AppSvgIcons.icLogOut,
                    title: S.current.logOutAccount,
                  ),
                  const Spacer(),
                  const HBox(12),
                  Text(
                    GlobalCommonConstants.appVersion,
                    style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      color: AppColors.gray,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return NetworkErrorPage(
          onRefresh: context.read<GlobalAuthCubit>().getUserDetail,
        );
      },
    );
  }
}
