import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modern_ecommerce/modern_ecommerce/theme/colors.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final Color? color;
  final bool isLight;

  const AppLogo({
    super.key,
    this.size = 120,
    this.color,
    this.isLight = false,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/logo/logo.svg',
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(
        color ?? (isLight ? Colors.white : MEColors.primary),
        BlendMode.srcIn,
      ),
    );
  }
} 