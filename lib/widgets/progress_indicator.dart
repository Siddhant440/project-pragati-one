import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'custom_progress_painter.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final double progress;
  final String label;
  final double size;

  const CustomCircularProgressIndicator({
    Key? key,
    required this.progress,
    required this.label,
    this.size = 120,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get current date
    final now = DateTime.now();
    final currentDay = now.day;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Custom progress indicator
        SizedBox(
          height: size,
          width: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Custom painter for the progress arc
              CustomPaint(
                size: Size(size, size),
                painter: CustomProgressPainter(
                  progress: progress,
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? AppColors.textWhite.withOpacity(0.1)
                          : AppColors.textDark.withOpacity(0.1),
                  progressColor: AppColors.primaryPurple,
                  strokeWidth: 15.0,
                  startAngle: 135, // Start from top-left
                  sweepAngle: 270, // 3/4 of a circle
                ),
              ),
              // Center text with date and month
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.accentBlue,
                    ),
                    child: Center(
                      child: Text(
                        '$currentDay',
                        style: context.dateNumberText,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    _getMonthName(now.month),
                    style: context.monthNameText,
                  ),
                ],
              ),
            ],
          ),
        ),

        // No spacing between circle and container
        Transform.translate(
          offset: Offset(
              0, -20), // Move the container up to overlap with the circle
          child: Container(
            width: 190,
            height: 50,
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.primaryPurpleDark,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '0%',
                        style: context.percentRangeText
                            .copyWith(color: AppColors.textWhite),
                      ),
                      Text(
                        '${(progress * 100).toInt()}%',
                        style: context.percentageText
                            .copyWith(color: AppColors.textWhite),
                      ),
                      Text(
                        '100%',
                        style: context.percentRangeText
                            .copyWith(color: AppColors.textWhite),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    label,
                    style: context.basedOnReportsText
                        .copyWith(color: AppColors.textWhite),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        throw Exception('Invalid month');
    }
  }
}
