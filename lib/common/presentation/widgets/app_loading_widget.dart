import 'package:allmed/common/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({
    Key? key,
    required this.child,
    this.isLoading = false,
  }) : super(key: key);

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Stack(
        children: [
          child,
          Positioned.fill(
            child: Container(
              color: AppColors.black.withOpacity(0.7),
              child: Center(
                child: LoadingAnimationWidget.inkDrop(color: Colors.white, size: 48),
              ),
            ),
          ),
        ],
      );
    }

    return child;
  }
}
