import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/feature/orders/data/model/order_model.dart';
import 'package:allmed/feature/orders/presentation/order_schedule/ui/widgets/order_doctor_info_block.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';

class OrderAddressBlock extends StatelessWidget {
  const OrderAddressBlock(this.order, {Key? key}) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrderDetailTileItem(
          title: 'Адрес',
          subTitle: order.address,
        ),
        Visibility(
          visible: order.addressApartment?.isNotEmpty ?? false,
          child: OrderDetailTileItem(
            title: S.of(context).appartamnet,
            subTitle: order.addressApartment ?? GlobalCoreConstants.empty,
          ),
        ),
        Visibility(
          visible: order.addressEntrance?.isNotEmpty ?? false,
          child: OrderDetailTileItem(
            title: S.of(context).entrance,
            subTitle: order.addressEntrance ?? GlobalCoreConstants.empty,
          ),
        ),
        Visibility(
          visible: order.addressIntercom?.isNotEmpty ?? false,
          child: OrderDetailTileItem(
            title: S.of(context).intercom,
            subTitle: order.addressIntercom ?? GlobalCoreConstants.empty,
          ),
        ),
        Visibility(
          visible: order.addressFloor?.isNotEmpty ?? false,
          child: OrderDetailTileItem(
            title: S.of(context).floor,
            subTitle: order.addressFloor ?? GlobalCoreConstants.empty,
          ),
        ),
        const HBox(12),
      ],
    );
  }
}
