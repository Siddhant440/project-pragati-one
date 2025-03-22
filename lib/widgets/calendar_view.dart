import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class CalendarView extends StatelessWidget {
  final double dotSize;
  final double dotSpacing;

  const CalendarView({
    Key? key,
    this.dotSize = 9.0,
    this.dotSpacing = 2.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get current date information
    final now = DateTime.now();
    final currentDay = now.day;
    final currentMonth = now.month;
    final daysInMonth = _daysInMonth(now.year, now.month);
    final daysRemaining = daysInMonth - currentDay;

    // Calculate number of rows needed (12 dots per row)
    final int rows = (daysInMonth / 12).ceil();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.navbarBackground
            : AppColors.navbarLightBackground,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.clockCircleBackground
                      : AppColors.calendarClockBackgroundLight,
                ),
                child: Icon(
                  Icons.access_time,
                  size: 18,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.navbarBackground
                      : Colors.black,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getMonthName(currentMonth),
                      style: context.calendarMonthText,
                    ),
                    Text(
                      '$daysRemaining Days Remaining',
                      style: context.calendarDaysText,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Display dot indicators in rows with exactly 12 dots
          for (int row = 0; row < rows; row++)
            Container(
              margin: EdgeInsets.only(bottom: row < rows - 1 ? 8 : 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  12,
                  (i) {
                    final int dayNumber = row * 12 + i + 1; // 1-indexed day
                    final bool isValidDay = dayNumber <= daysInMonth;
                    final bool isPastDay = dayNumber <= currentDay;

                    return Container(
                      width: dotSize,
                      height: dotSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: !isValidDay
                            ? Colors.transparent
                            : !isPastDay
                                ? (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppColors.textWhite.withOpacity(0.3)
                                    : AppColors.textDark.withOpacity(0.3))
                                : null,
                        gradient: isValidDay && isPastDay
                            ? AppColors.purpleGradient
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Calculate days in a month
  int _daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  // Get month name from month number
  String _getMonthName(int month) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthNames[month - 1];
  }
}
