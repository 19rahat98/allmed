import 'package:allmed/common/presentation/widgets/app_bars/common_app_bar.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_shimmer_widget.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/orders/presentation/order_history/cubit/order_history_cubit.dart';
import 'package:allmed/feature/orders/presentation/order_history/ui/widgets/complited_order_item.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class OrdersHistoryScreen extends StatelessWidget {
  const OrdersHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(S.current.orderHistory),
      body: BlocBuilder<OrderHistoryCubit, OrderHistoryListState>(
        builder: (context, state) {
          if (state.isEmpty) {
            return RefreshIndicator(
              onRefresh: context.read<OrderHistoryCubit>().getOrdersList,
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).today,
                      style: GoogleFonts.ubuntu(
                        fontSize: 16,
                        color: AppColors.gray,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ListView.separated(
                      itemCount: 2,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 16),
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, _) => const HBox(16),
                      itemBuilder: (context, _) => SizedBox(
                        height: 72,
                        child: AppShimmerWidget(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return  RefreshIndicator(
            onRefresh: context.read<OrderHistoryCubit>().getOrdersList,
            child: ListView.separated(
              itemCount: state.orders.length,
              physics: const AlwaysScrollableScrollPhysics(),
              separatorBuilder: (context, _) => const HBox(24),
              padding: const EdgeInsets.fromLTRB(8, 24, 8, 100),
              itemBuilder: (context, index) {
                final orderInfo = state.orders.elementAt(index);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        orderInfo.orderDate,
                        style: GoogleFonts.ubuntu(
                          fontSize: 16,
                          color: AppColors.gray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    ...List.generate(
                      orderInfo.orders.length,
                      (orderIndex) => CompletedOrderItem(
                        orderInfo.orders.elementAt(orderIndex),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
