import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/feature/address/user_address/presentation/ui/widgets/select_address_widget.dart';
import 'package:allmed/feature/home_scren/presentation/content_banner/ui/newpaper_banner_widget.dart';
import 'package:allmed/feature/notification/presentation/widgets/notification_bell_widget.dart';
import 'package:allmed/feature/orders/presentation/order_history/cubit/order_history_cubit.dart';
import 'package:allmed/feature/orders/presentation/order_history/ui/checkup_banner.dart';
import 'package:allmed/feature/services/presentation/widgets/services_banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: context.read<OrderHistoryCubit>().getOrdersList,
        child: const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(top: 48, bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectAddressBanner(),
                  NotificationBellWidget(),
                ],
              ),
              NewsPaperBannersWidget(),
              CurrentCheckBanner(),
              ServicesBanner(),
            ],
          ),
        ),
      ),
    );
  }
}
