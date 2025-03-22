import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class CustomMenuButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final bool isActive;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final double fontSize;

  const CustomMenuButton({
    Key? key,
    required this.title,
    this.icon,
    this.isActive = false,
    this.onPressed,
    this.width = 175,
    this.height = 34,
    this.fontSize = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        constraints: BoxConstraints.tightFor(width: width, height: 34),
        decoration: BoxDecoration(
          gradient: isActive ? null : null,
          color: isActive ? Colors.transparent : Colors.transparent,
          borderRadius: BorderRadius.circular(10), // 10px border radius
        ),
        child: !isActive
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: isDarkMode
                      ? AppColors.inactiveButtonBorderGradient
                      : AppColors.inactiveButtonBorderLightGradient,
                ),
                child: Container(
                  margin: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? AppColors.darkBackground
                        : AppColors.lightBackground,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: _buildButtonContent(context),
                ),
              )
            : Container(
                padding: EdgeInsets.all(1.5),
                decoration: BoxDecoration(
                  gradient: AppColors.activeButtonBorderGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.activeButtonGradient,
                    borderRadius: BorderRadius.circular(8.5),
                  ),
                  child: _buildButtonContent(context),
                ),
              ),
      ),
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isActive
        ? AppColors.textWhite
        : (isDarkMode ? AppColors.textWhite : AppColors.textDark);

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(width: 10),
          if (icon != null) ...[
            Icon(icon, color: iconColor, size: 16),
            SizedBox(width: 6),
          ],
          Expanded(
            child: Text(
              title,
              style: context.buttonText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 6),
          Icon(
            Icons.arrow_forward,
            size: 14,
            color: iconColor,
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
