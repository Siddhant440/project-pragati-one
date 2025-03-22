import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// App typography constants to maintain consistent text styling throughout the app
class AppTypography {
  // Base text styles by weight & size - without color
  static final TextStyle s10w400 = GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    height: 1.2,
  );

  static final TextStyle s10w500 = GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );

  static final TextStyle s10w700 = GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static final TextStyle s12w400 = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.2,
  );

  static final TextStyle s12w500 = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );

  static final TextStyle s14w500 = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );

  static final TextStyle s16w700 = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static final TextStyle s18w600 = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  static final TextStyle s8w400 = GoogleFonts.poppins(
    fontSize: 8,
    fontWeight: FontWeight.w400,
    height: 1.2,
  );
}

// Extension methods on BuildContext for accessing typography
extension TypographyExtension on BuildContext {
  // Button text style
  TextStyle get buttonText => AppTypography.s10w500.copyWith(
        color: Theme.of(this).brightness == Brightness.dark
            ? AppColors.textWhite
            : AppColors.textDark,
      );

  // Carousel item text style
  TextStyle get carouselItemText => AppTypography.s12w500.copyWith(
        color: Theme.of(this).brightness == Brightness.dark
            ? AppColors.textWhite
            : AppColors.textDark,
      );

  // Header text styles
  TextStyle get greetingText => AppTypography.s14w500.copyWith(
        color: AppColors.textGrey,
      );

  TextStyle get nameText => AppTypography.s14w500.copyWith(
        color: Theme.of(this).brightness == Brightness.dark
            ? AppColors.textWhite
            : AppColors.textDark,
        fontWeight: FontWeight.bold,
      );

  // Navbar text styles
  TextStyle get navbarText => AppTypography.s12w400.copyWith(
        color: Theme.of(this).brightness == Brightness.dark
            ? AppColors.navIconGrey
            : AppColors.navIconLightGrey,
      );

  TextStyle get navbarTextActive => AppTypography.s12w400.copyWith(
        color: Colors.white, // Always white for gradient masking
      );

  // Progress card text styles
  TextStyle get dailyProgressTitle => AppTypography.s18w600.copyWith(
        color: Theme.of(this).brightness == Brightness.dark
            ? AppColors.textWhite
            : AppColors.textDark,
      );

  TextStyle get dailyProgressSubtitle => AppTypography.s12w500.copyWith(
        color: AppColors.textGrey,
      );

  TextStyle get dateNumberText => AppTypography.s8w400.copyWith(
        color: Theme.of(this).brightness == Brightness.dark
            ? AppColors.textDark
            : AppColors.textWhite,
      );

  TextStyle get monthNameText => AppTypography.s8w400.copyWith(
        color: Theme.of(this).brightness == Brightness.dark
            ? AppColors.textWhite
            : AppColors.textDark,
      );

  TextStyle get percentRangeText => AppTypography.s10w400.copyWith(
        color: Theme.of(this).brightness == Brightness.dark
            ? AppColors.textWhite
            : AppColors.textDark,
      );

  TextStyle get basedOnReportsText => AppTypography.s10w400.copyWith(
        color: (Theme.of(this).brightness == Brightness.dark
                ? AppColors.textWhite
                : AppColors.textDark)
            .withOpacity(0.8),
      );

  TextStyle get percentageText => AppTypography.s16w700.copyWith(
        color: Theme.of(this).brightness == Brightness.dark
            ? AppColors.textWhite
            : AppColors.textDark,
      );

  // Calendar text styles
  TextStyle get calendarMonthText => AppTypography.s12w500.copyWith(
        color: Theme.of(this).brightness == Brightness.dark
            ? AppColors.textWhite
            : AppColors.textDark,
      );

  TextStyle get calendarDaysText => AppTypography.s10w500.copyWith(
        color: (Theme.of(this).brightness == Brightness.dark
                ? AppColors.textWhite
                : AppColors.textDark)
            .withOpacity(0.6),
      );
}
