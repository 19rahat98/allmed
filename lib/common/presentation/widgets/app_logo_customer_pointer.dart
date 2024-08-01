import 'package:allmed/common/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppLogoCustomPainter extends CustomPainter {
  final double progress; // Прогресс анимации

  AppLogoCustomPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(22.288, 39.75);
    path_0.cubicTo(16.8848, 39.75, 11.4817, 42.0345, 9.23041, 43.6336);
    path_0.cubicTo(6.97906, 45.2328, 0, 51.6293, 0, 51.6293);
    path_0.lineTo(13.7329, 51.6293);
    path_0.cubicTo(13.7329, 51.6293, 19.3613, 47.0603, 27.0157, 46.6034);
    path_0.cubicTo(34.6701, 46.1466, 42.3246, 51.6293, 42.3246, 51.6293);
    path_0.lineTo(54.4817, 51.6293);
    path_0.lineTo(27.0157, 0);
    path_0.lineTo(0.900518, 47.7457);
    path_0.cubicTo(0.900518, 47.7457, 8.10464, 42.4914, 10.356, 41.1207);
    path_0.cubicTo(12.6073, 39.75, 20.4869, 38.6078, 20.4869, 38.6078);
    path_0.lineTo(18.6858, 37.694);
    path_0.lineTo(27.0157, 22.1595);
    path_0.lineTo(37.822, 41.1207);
    path_0.lineTo(36.6964, 42.4914);
    path_0.lineTo(40.7486, 47.7457);
    path_0.cubicTo(40.7486, 47.7457, 33.3193, 42.9483, 32.4189, 42.4914);
    path_0.cubicTo(32.3467, 42.4548, 32.2558, 42.4065, 32.1467, 42.3486);
    path_0.cubicTo(30.8949, 41.6832, 27.2582, 39.75, 22.288, 39.75);
    path_0.close();
    path_0.moveTo(49.0785, 0);
    path_0.lineTo(43.2252, 3.65523);
    path_0.lineTo(43.2252, 27.8707);
    path_0.lineTo(56.5078, 52.0862);
    path_0.lineTo(70.9162, 52.0862);
    path_0.lineTo(67.9896, 44.0905);
    path_0.lineTo(54.932, 44.0905);
    path_0.lineTo(54.932, 3.65523);
    path_0.lineTo(49.0785, 0);
    path_0.close();
    path_0.moveTo(58.9842, 3.65523);
    path_0.lineTo(64.8377, 0);
    path_0.lineTo(70.6912, 3.65523);
    path_0.lineTo(70.6912, 44.0905);
    path_0.lineTo(83.7488, 44.0905);
    path_0.lineTo(86.6754, 52.0862);
    path_0.lineTo(72.267, 52.0862);
    path_0.lineTo(68.6649, 42.9483);
    path_0.lineTo(58.9842, 42.9483);
    path_0.lineTo(58.9842, 3.65523);
    path_0.close();
    path_0.moveTo(96.8064, 30.6121);
    path_0.lineTo(89.6021, 30.6121);
    path_0.lineTo(89.6021, 52.0862);
    path_0.lineTo(96.8064, 52.0862);
    path_0.lineTo(96.8064, 38.6078);
    path_0.cubicTo(96.8064, 38.6078, 96.5811, 35.4095, 99.958, 35.4095);
    path_0.cubicTo(103.335, 35.4095, 103.11, 38.6078, 103.11, 38.6078);
    path_0.lineTo(103.11, 52.0862);
    path_0.lineTo(109.188, 52.0862);
    path_0.lineTo(109.188, 38.6078);
    path_0.cubicTo(109.188, 38.6078, 108.963, 35.4095, 112.34, 35.4095);
    path_0.cubicTo(115.717, 35.4095, 115.717, 38.6078, 115.717, 38.6078);
    path_0.lineTo(115.717, 52.0862);
    path_0.lineTo(122.246, 52.0862);
    path_0.lineTo(122.246, 35.8664);
    path_0.cubicTo(122.246, 33.8103, 119.995, 29.9267, 115.717, 29.9267);
    path_0.cubicTo(111.44, 29.9267, 109.188, 33.125, 109.188, 33.125);
    path_0.cubicTo(109.188, 33.125, 107.387, 29.9267, 103.11, 29.9267);
    path_0.cubicTo(98.8325, 29.9267, 96.8064, 33.125, 96.8064, 33.125);
    path_0.lineTo(96.8064, 30.6121);
    path_0.close();
    path_0.moveTo(147.045, 45.2328);
    path_0.cubicTo(145.5, 49.7579, 141.33, 53, 136.429, 53);
    path_0.cubicTo(130.212, 53, 125.173, 47.7837, 125.173, 41.3491);
    path_0.cubicTo(125.173, 34.9146, 130.212, 29.6983, 136.429, 29.6983);
    path_0.cubicTo(142.646, 29.6983, 147.686, 34.9146, 147.686, 41.3491);
    path_0.cubicTo(147.686, 41.8917, 147.65, 42.4254, 147.581, 42.9483);
    path_0.lineTo(132.827, 42.9483);
    path_0.lineTo(132.827, 44.7759);
    path_0.cubicTo(132.827, 45.4612, 133.728, 47.5172, 136.654, 47.5172);
    path_0.cubicTo(139.581, 47.5172, 140.482, 45.2328, 140.482, 45.2328);
    path_0.lineTo(147.045, 45.2328);
    path_0.close();
    path_0.moveTo(136.654, 35.181);
    path_0.cubicTo(140.079, 35.181, 140.482, 38.8362, 140.482, 38.8362);
    path_0.lineTo(132.827, 38.8362);
    path_0.cubicTo(132.827, 38.8362, 133.23, 35.181, 136.654, 35.181);
    path_0.close();
    path_0.moveTo(172, 22.8448);
    path_0.lineTo(164.796, 22.8448);
    path_0.lineTo(164.796, 32.581);
    path_0.cubicTo(163.172, 30.7861, 161.045, 29.6983, 158.717, 29.6983);
    path_0.cubicTo(153.619, 29.6983, 149.487, 34.9146, 149.487, 41.3491);
    path_0.cubicTo(149.487, 47.7837, 153.619, 53, 158.717, 53);
    path_0.cubicTo(161.045, 53, 163.172, 51.9122, 164.796, 50.1171);
    path_0.lineTo(164.796, 52.0862);
    path_0.lineTo(172, 52.0862);
    path_0.lineTo(172, 22.8448);
    path_0.close();
    path_0.moveTo(165.246, 41.1207);
    path_0.cubicTo(165.246, 44.401, 163.23, 47.0603, 160.743, 47.0603);
    path_0.cubicTo(158.257, 47.0603, 156.241, 44.401, 156.241, 41.1207);
    path_0.cubicTo(156.241, 37.8402, 158.257, 35.181, 160.743, 35.181);
    path_0.cubicTo(163.23, 35.181, 165.246, 37.8402, 165.246, 41.1207);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    // Анимация заливки с лева на право
    paint0Fill.shader = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: const [AppColors.primaryColor, AppColors.lightGray],
      stops: [progress, progress],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
