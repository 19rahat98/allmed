import 'package:allmed/common/presentation/widgets/app_logo_customer_pointer.dart';
import 'package:flutter/material.dart';

class LogoAnimationWidget extends StatefulWidget {
  const LogoAnimationWidget({super.key});

  @override
  State<LogoAnimationWidget> createState() => _LogoAnimationWidgetState();
}

class _LogoAnimationWidgetState extends State<LogoAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(200, 40),
          painter: AppLogoCustomPainter(_controller.value),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
