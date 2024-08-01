import 'package:allmed/common/presentation/bottom_navigation/widgets/nav_bar_icon_item_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/address/user_address/presentation/cubit/address_cubit.dart';
import 'package:allmed/feature/home_scren/presentation/home_screen.dart';
import 'package:allmed/feature/information/presentation/faq/ui/faq_screen.dart';
import 'package:allmed/feature/orders/presentation/order_history/cubit/order_history_cubit.dart';
import 'package:allmed/feature/orders/presentation/order_history/ui/orders_history_screen.dart';
import 'package:allmed/feature/profile/presentation/profile_menu/ui/profile_menu_screen.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class AppBottomNavigation extends StatefulWidget {
  const AppBottomNavigation({Key? key}) : super(key: key);

  @override
  State<AppBottomNavigation> createState() => _AppBottomNavigationState();
}

class _AppBottomNavigationState extends State<AppBottomNavigation> {
  late PersistentTabController _controller;

  @override
  void initState() {
    context.read<AddressCubit>().loadAddressList();
    context.read<OrderHistoryCubit>().getOrdersList();
    _controller = PersistentTabController();
    super.initState();
  }

  /// табы нижней навигации
  List<PersistentTabConfig> get _tabs => [
        PersistentTabConfig(
          screen: const HomeScreen(),
          item: ItemConfig(
            icon: NavBarIconItemWidget(
              title: S.current.main,
              iconName: AppSvgIcons.icHomePageFilled,
              textColor: AppColors.primaryColor,
            ),
            inactiveIcon: NavBarIconItemWidget(
              title: S.current.main,
              iconName: AppSvgIcons.icHomePageOutline,
            ),
          ),
        ),
        PersistentTabConfig(
          screen: const OrdersHistoryScreen(),
          item: ItemConfig(
            icon: NavBarIconItemWidget(
              title: S.current.history,
              iconName: AppSvgIcons.icHistoryFilled,
              textColor: AppColors.primaryColor,
            ),
            inactiveIcon: NavBarIconItemWidget(
              title: S.current.history,
              iconName: AppSvgIcons.icHistoryOutline,
            ),
          ),
        ),
        PersistentTabConfig(
          screen: const FaqScreen(),
          item: ItemConfig(
            icon: NavBarIconItemWidget(
              title: S.current.support,
              iconName: AppSvgIcons.icQuestionSquare,
              textColor: AppColors.primaryColor,
            ),
            inactiveIcon: NavBarIconItemWidget(
              title: S.current.support,
              iconName: AppSvgIcons.icQuestionSquareOutline,
            ),
          ),
        ),
        PersistentTabConfig(
          screen: const ProfileMenuScreen(),
          item: ItemConfig(
            icon: NavBarIconItemWidget(
              title: S.current.profile,
              iconName: AppSvgIcons.icUserFilled,
              textColor: AppColors.primaryColor,
            ),
            inactiveIcon: NavBarIconItemWidget(
              title: S.current.profile,
              iconName: AppSvgIcons.icUserOutline,
            ),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: _tabs,
      navBarHeight: 54,
      controller: _controller,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
      ),
    );
  }
}
