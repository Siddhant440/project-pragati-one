import 'package:flutter/material.dart';
import '../utils/responsive_size.dart';

/// A widget that displays different layouts based on screen size
class ResponsiveLayout extends StatelessWidget {
  /// Widget to display on mobile screens (< 600px wide)
  final Widget mobile;

  /// Widget to display on tablet screens (600px - 1200px wide)
  /// If null, the mobile widget will be used
  final Widget? tablet;

  /// Widget to display on desktop screens (> 1200px wide)
  /// If null, the tablet widget will be used if available, otherwise mobile
  final Widget? desktop;

  const ResponsiveLayout({
    Key? key,
    required this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType = context.deviceType;

        // Use the appropriate layout based on screen width
        switch (deviceType) {
          case DeviceType.desktop:
            return desktop ?? tablet ?? mobile;
          case DeviceType.tablet:
            return tablet ?? mobile;
          case DeviceType.mobile:
          default:
            return mobile;
        }
      },
    );
  }
}

/// A widget that adjusts its layout based on orientation
class OrientationLayout extends StatelessWidget {
  /// Widget to display in portrait orientation
  final Widget portrait;

  /// Widget to display in landscape orientation
  /// If null, the portrait widget will be used
  final Widget? landscape;

  const OrientationLayout({
    Key? key,
    required this.portrait,
    this.landscape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLandscape = context.isLandscape;

    // Use the appropriate layout based on orientation
    return isLandscape && landscape != null ? landscape! : portrait;
  }
}

/// A grid that adapts the number of columns based on screen width
class ResponsiveGrid extends StatelessWidget {
  /// The list of widgets to display in the grid
  final List<Widget> children;

  /// Minimum width for each grid item
  final double minItemWidth;

  /// Spacing between grid items
  final double spacing;

  /// Padding around the grid
  final EdgeInsets? padding;

  const ResponsiveGrid({
    Key? key,
    required this.children,
    this.minItemWidth = 150,
    this.spacing = 16,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final resp = context.responsive;
        final width = constraints.maxWidth;

        // Calculate how many items can fit per row
        final itemWidth = resp.width(minItemWidth);
        final crossAxisCount = (width / (itemWidth + spacing)).floor();

        // Ensure at least one column
        final columns = crossAxisCount > 0 ? crossAxisCount : 1;

        return GridView.builder(
          padding: padding,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: resp.spacing(spacing),
            mainAxisSpacing: resp.spacing(spacing),
            childAspectRatio: 1, // Can be customized if needed
          ),
          itemCount: children.length,
          itemBuilder: (context, index) => children[index],
        );
      },
    );
  }
}
