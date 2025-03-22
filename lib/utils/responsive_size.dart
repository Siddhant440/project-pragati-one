import 'package:flutter/material.dart';

/// A utility class that provides tools for creating responsive layouts
class ResponsiveSize {
  /// The current screen width
  final double screenWidth;

  /// The current screen height
  final double screenHeight;

  /// The design reference width (based on figma or design specs)
  static const double referenceWidth = 375;

  /// The design reference height (based on figma or design specs)
  static const double referenceHeight = 812;

  /// Constructor takes screen dimensions from MediaQuery
  ResponsiveSize({
    required this.screenWidth,
    required this.screenHeight,
  });

  /// Create a ResponsiveSize instance from BuildContext
  factory ResponsiveSize.of(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return ResponsiveSize(
      screenWidth: mediaQuery.size.width,
      screenHeight: mediaQuery.size.height,
    );
  }

  /// Calculate a responsive width value based on reference design
  /// with constraints to ensure visibility on small screens
  double width(double value) {
    final scale = screenWidth / referenceWidth;
    // Don't go below 0.7 of the original size to keep things visible
    final adjustedScale = scale.clamp(0.7, 1.2);
    return value * adjustedScale;
  }

  /// Calculate a responsive height value based on reference design
  /// with constraints to ensure visibility on small screens
  double height(double value) {
    final scale = screenHeight / referenceHeight;
    // Don't go below 0.65 of the original size to keep things visible
    final adjustedScale = scale.clamp(0.65, 1.2);
    return value * adjustedScale;
  }

  /// Calculate responsive font size
  double fontSize(double size) {
    // Return fixed size without scaling to keep fonts consistent
    return size;
  }

  /// Calculate responsive spacing (padding, margin, etc.)
  /// with minimum values to avoid too small spacing
  double spacing(double value) {
    if (value <= 1) return value; // For hairline borders, keep exact value

    final scale = screenWidth / referenceWidth;
    final adjustedScale = scale.clamp(0.75, 1.2);

    // Minimum spacing values for better visibility
    final result = value * adjustedScale;
    if (value <= 4) return result.clamp(1.0, double.infinity);
    if (value <= 8) return result.clamp(2.0, double.infinity);
    if (value <= 16) return result.clamp(4.0, double.infinity);
    return result.clamp(6.0, double.infinity);
  }

  /// Calculate responsive radius (for borders, buttons, etc.)
  double radius(double value) {
    final scale = screenWidth / referenceWidth;
    final adjustedScale = scale.clamp(0.7, 1.2);
    return value * adjustedScale;
  }

  /// Determine device type based on screen width
  DeviceType get deviceType {
    if (screenWidth < 600) {
      return DeviceType.mobile;
    } else if (screenWidth < 1200) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  /// Check if the device is in landscape orientation
  bool get isLandscape => screenWidth > screenHeight;
}

/// Enum representing different device types based on screen size
enum DeviceType {
  mobile,
  tablet,
  desktop,
}

/// Extension method on BuildContext to easily access ResponsiveSize
extension ResponsiveContext on BuildContext {
  ResponsiveSize get responsive => ResponsiveSize.of(this);

  /// Shorthand for getting device type
  DeviceType get deviceType => ResponsiveSize.of(this).deviceType;

  /// Shorthand for checking if device is in landscape orientation
  bool get isLandscape => ResponsiveSize.of(this).isLandscape;
}
