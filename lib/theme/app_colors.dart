import 'package:flutter/material.dart';

/// App color constants to be used throughout the application
/// This helps maintain consistency and makes it easier to update colors
class AppColors {
  // Primary colors
  static const primaryPurple = Color(0xFF9747FF);
  static const primaryPurpleLight = Color(0xFFA7A0F8);
  static const primaryPurpleDark = Color(0xFF695CFF);

  // Background colors
  static const darkBackground = Color(0xFF0E0C1D);
  static const lightBackground = Color(0xFFF8F9FA); // Light mode background
  static const navbarBackground = Color(0xFF111029);
  static const navbarLightBackground = Color(0xFFFFFFFF); // Light mode navbar
  static const clockCircleBackground = Color(0xFFF4F4F4);
  static const darkPurpleBackground =
      Color(0xFF303356); // For error placeholder backgrounds
  static const calendarClockBackgroundLight = Color(0xFFF0F0F0);

  // Border colors
  static const borderLightGray = Color(0xFF8692A6);
  static const borderDarkGray = Color(0xFF343840);

  // Text/Icon colors
  static const textWhite = Colors.white; // Keep as we use this everywhere
  static const textDark = Color(0xFF1A202C); // Dark text for light mode
  static const navIconGrey = Color(0xFF484C52);
  static const navIconLightGrey = Color(0xFFADB5BD); // Light mode nav icons
  static const textGrey =
      Color(0xFFA0AEC0); // Used for subtitles, "Good Morning", etc.
  static const dotIndicatorInactive =
      Color(0xFFA0AEC0); // For carousel dot indicators

  // Avatar/Profile colors
  static const avatarBackgroundLight = Color(0xFFD3D3D3);
  static const avatarBackgroundDark = Color(0xFFAAAAAA);

  // Accent colors
  static const accentBlue = Color(0xFF0075FF);

  // Shadow colors
  static const shadowDark = Colors.black;
  static const shadowLight = Color(0xFFCCCCCC);

  // Gradient definitions - consolidated
  // Left-to-right purple gradient (standard for text, buttons, indicators)
  static const purpleGradient = LinearGradient(
    colors: [primaryPurpleDark, primaryPurpleLight],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Left-to-right purple gradient (standard for loader indicators)
  static const purpleIndicatorGradient = LinearGradient(
    colors: [primaryPurpleLight, primaryPurpleDark],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Diagonal purple gradient (used for containers)
  static const purpleDiagonalGradient = LinearGradient(
    colors: [primaryPurpleDark, primaryPurpleLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Inactive button border gradient (for dark mode)
  static const inactiveButtonBorderGradient = LinearGradient(
    colors: [borderLightGray, borderDarkGray],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Active button border gradient (lighter version for border)
  static const activeButtonBorderGradient = LinearGradient(
    colors: [
      Color(0xFF8472FF),
      Color(0xFFBBB5FA)
    ], // Lighter versions of primaryPurpleDark and primaryPurpleLight
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Mapping for clarity when used in different contexts
  static const activeButtonGradient = purpleGradient;
  static const containerGradient = purpleDiagonalGradient;
  static const navItemGradient = purpleGradient;
  static const progressBarGradient = purpleGradient;
  static const inactiveButtonBorderLightGradient = purpleGradient;

  // Shadow styles
  static List<BoxShadow> lightModeShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 4,
      offset: const Offset(0, 2),
    )
  ];

  static List<BoxShadow> navbarShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 4,
      offset: const Offset(0, -2),
    )
  ];

  static List<BoxShadow> notificationIconShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 20,
      offset: const Offset(0, 4),
    )
  ];

  // Helper method to get color based on brightness
  static Color getColor(
      BuildContext context, Color darkColor, Color lightColor) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? darkColor : lightColor;
  }

  // Helper method to get text color based on brightness
  static Color getTextColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? textWhite : textDark;
  }

  // Helper method to get background color based on brightness
  static Color getBackgroundColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? darkBackground : lightBackground;
  }
}
