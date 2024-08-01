import 'package:allmed/common/presentation/widgets/app_loading_widget.dart';
import 'package:allmed/common/theme/app_images.dart';
import 'package:allmed/feature/doctor_service/data/model/doctor_dto.dart';
import 'package:allmed/feature/orders/presentation/order_conform/ui/order_conform_screen.dart';
import 'package:flutter/material.dart';

class LoadingPayScreen extends StatefulWidget {
  const LoadingPayScreen(this.doctor, this.service, this.orderId, {super.key});

  final int orderId;
  final DoctorModel doctor;
  final DoctorServiceModel service;

  @override
  State<LoadingPayScreen> createState() => _LoadingPayScreenState();
}

class _LoadingPayScreenState extends State<LoadingPayScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(const Duration(seconds: 2)).whenComplete(
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => OrderConformScreen(widget.doctor, widget.service, widget.orderId),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppLoadingWidget(
        isLoading: true,
        child: Center(
          child: Image.asset(AppIcons.icToPay),
        ),
      ),
    );
  }
}
