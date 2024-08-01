import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_modal_header.dart';
import 'package:allmed/feature/orders/data/model/order_model.dart';
import 'package:allmed/feature/orders/presentation/order_history/ui/widgets/help_to_order_widget.dart';
import 'package:allmed/feature/orders/presentation/order_schedule/ui/widgets/order_address_block.dart';
import 'package:allmed/feature/orders/presentation/order_schedule/ui/widgets/order_doctor_info_block.dart';
import 'package:allmed/feature/orders/presentation/order_schedule/ui/widgets/order_rating_card.dart';
import 'package:allmed/feature/orders/presentation/order_schedule/ui/widgets/order_symptoms_info_block.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';

class OrderDetailModel extends StatelessWidget {
  const OrderDetailModel(this.order, {Key? key}) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppModalHeader(S.current.orderDetail),
            const HBox(28),
            OrderDoctorInfoBlock(order),
            OrderRatingCard(order),
            const OrderSymptomsInfoBlock(),
            OrderAddressBlock(order),
            const HelpToOrderWidget.dangerous(),
            const HBox(24),
          ],
        ),
      ),
    );
  }
}

Future<void> showOrderDetailModalSheet(BuildContext context, OrderModel order) {
  return showModalBottomSheet<void>(
    context: context,
    elevation: 0,
    useSafeArea: true,
    useRootNavigator: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    backgroundColor: Colors.white,
    barrierColor: Colors.black.withOpacity(0.4),
    builder: (context) => OrderDetailModel(order),
  );
}
