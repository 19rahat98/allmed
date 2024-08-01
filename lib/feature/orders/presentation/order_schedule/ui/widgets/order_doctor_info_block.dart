import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/orders/data/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDoctorInfoBlock extends StatelessWidget {
  const OrderDoctorInfoBlock(this.order, {Key? key}) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            order.serviceName,
            style: GoogleFonts.ubuntu(
              fontSize: 20,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        OrderDetailTileItem(
          title: 'Врач',
          subTitle: order.doctorName,
        ),
        OrderDetailTileItem(
          title: 'Время',
          subTitle: order.orderCreated,
        ),
        OrderDetailTileItem(
          title: 'Сумма',
          subTitle: order.price,
        ),
        const OrderDetailTileItem(
          title: 'Статус',
          subTitle: 'Завершен',
          subtitleColor: AppColors.primaryColor,
        ),
      ],
    );
  }
}

class OrderDetailTileItem extends StatelessWidget {
  const OrderDetailTileItem({
    Key? key,
    required this.title,
    required this.subTitle,
    this.subtitleColor = AppColors.black,
    this.padding =  const EdgeInsets.fromLTRB(20, 12, 20, 0),
  }) : super(key: key);

  final String title;
  final String subTitle;
  final EdgeInsets padding;
  final Color subtitleColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:padding,
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.ubuntu(
              fontSize: 16,
              color: AppColors.gray,
              fontWeight: FontWeight.w400,
            ),
          ),
          Expanded(
            child: Text(
              subTitle,
              textAlign: TextAlign.end,
              style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: subtitleColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
