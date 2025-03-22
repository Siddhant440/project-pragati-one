import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DotIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  final Color activeColor;
  final Color inactiveColor;
  final double size;
  final double spacing;

  const DotIndicator({
    Key? key,
    required this.count,
    required this.currentIndex,
    this.activeColor = AppColors.primaryPurple,
    this.inactiveColor = AppColors.dotIndicatorInactive,
    this.size = 8.0,
    this.spacing = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => Container(
          width: size,
          height: size,
          margin: EdgeInsets.symmetric(horizontal: spacing),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                index == currentIndex ? null : inactiveColor.withOpacity(0.6),
            gradient: index == currentIndex ? AppColors.purpleGradient : null,
          ),
        ),
      ),
    );
  }
}
