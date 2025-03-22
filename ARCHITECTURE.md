# Project Progress Tracker - Technical Architecture

This document provides a detailed overview of the technical architecture of the Project Progress Tracker application.

## Architecture Overview

The application follows a structured architecture that separates concerns across different layers:

```
lib/
├── models/        # Data models
├── theme/         # Theming and styling definitions
├── utils/         # Utility functions and helpers
├── viewmodels/    # State management
├── views/         # UI screens
├── widgets/       # Reusable UI components
└── main.dart      # Application entry point
```

## Key Components

### State Management

The application uses the Provider package for state management. The primary ViewModel is:

- **HomeViewModel**: Manages the state for the home screen, including project data, progress metrics, and periodic data refreshes.

### Theming System

The theming system is designed to support both light and dark modes:

#### AppColors (lib/theme/app_colors.dart)

- Centralizes all color definitions
- Provides gradient definitions for UI components
- Includes helper methods to get theme-specific colors:
  - `getColor()`: Returns dark or light color based on theme
  - `getTextColor()`: Returns appropriate text color
  - `getBackgroundColor()`: Returns background color based on theme

#### AppTypography (lib/theme/app_typography.dart)

- Defines base text styles with varying sizes and weights
- Provides context extensions for getting theme-aware text styles
- Organized by UI component categories:
  - Navigation elements
  - Content elements
  - Progress card elements
  - Calendar elements
- Uses responsive font sizes that scale with screen dimensions

#### AppTheme (lib/theme/app_theme.dart)

- Defines complete theme data for both light and dark themes
- Configures global theme properties:
  - Card styling
  - Text theme
  - Bottom navigation bar theme
- Supports responsive sizing for theme elements

### Responsive Design System

The application implements a comprehensive responsive design system to adapt to different screen sizes and orientations:

#### ResponsiveSize (lib/utils/responsive_size.dart)

- Core utility class for calculating dimensions relative to screen size
- Uses a reference design width (375px) and height (812px) based on standard mobile design specs
- Provides methods for responsive calculations:
  - `width()`: Calculates responsive width values
  - `height()`: Calculates responsive height values
  - `fontSize()`: Determines appropriate font sizes with constraints
  - `spacing()`: Computes responsive padding and margin
  - `radius()`: Adjusts border radius values
- Includes device type detection for conditional layouts:
  - Mobile: < 600px width
  - Tablet: 600px - 1200px width
  - Desktop: > 1200px width
- Detects orientation (portrait vs. landscape)

#### ResponsiveLayout & OrientationLayout (lib/widgets/responsive_layout.dart)

- `ResponsiveLayout`: Widget that displays different content based on screen size
  - Accepts separate mobile, tablet, and desktop layouts
  - Automatically selects the appropriate layout based on screen width
  - Falls back to smaller layouts when larger ones aren't provided

- `OrientationLayout`: Widget that adapts to screen orientation
  - Displays different UI for portrait vs. landscape orientations
  - Useful for optimizing layout for different aspect ratios

- `ResponsiveGrid`: Adaptive grid system
  - Automatically adjusts number of columns based on available width
  - Maintains minimum item width constraints 
  - Handles spacing responsively

### UI Components

#### Custom Widgets

- **CustomMenuButton**: A button component that displays different styling for active/inactive states
- **DotIndicator**: Visual indicator for carousel navigation
- **ProjectCarousel**: Horizontally scrollable display of project cards

## Data Flow

1. The application initializes in `main.dart`, setting up the Provider for state management and responsive configuration
2. `HomeViewModel` refreshes data periodically to update project progress information
3. UI components consume data from the ViewModel and render it according to the current theme and screen size

## Theme & Responsive Adaptation

The application automatically adapts to both the system theme and screen dimensions:

### Theme Adaptation

```dart
MaterialApp(
  theme: AppTheme.lightTheme(context: context),
  darkTheme: AppTheme.darkTheme(context: context),
  themeMode: ThemeMode.system,
  // ...
)
```

### Responsive Layout Adaptation

Text scaling is managed through a custom builder in MaterialApp:

```dart
builder: (context, child) {
  final mediaQuery = MediaQuery.of(context);
  final textScaleFactor = mediaQuery.size.width / ResponsiveSize.referenceWidth;
  // Limit text scaling to reasonable bounds
  final constrainedTextScaleFactor = textScaleFactor.clamp(0.8, 1.2);
  
  return MediaQuery(
    data: mediaQuery.copyWith(
      textScaleFactor: constrainedTextScaleFactor
    ),
    child: child!,
  );
}
```

Component dimensions adapt using the ResponsiveSize utility:

```dart
// Example of responsive sizing in a component
Container(
  width: context.responsive.width(150),
  height: context.responsive.height(50),
  padding: EdgeInsets.all(context.responsive.spacing(16)),
)
```

## Best Practices Implemented

1. **Separation of Concerns**: UI, styling, and business logic are separated
2. **Consistent Typography**: All text styling is managed through the centralized typography system
3. **Theme-Aware Rendering**: Components adapt to light/dark themes automatically
4. **Reusable Components**: Widgets are designed to be reusable with customizable properties
5. **Performance Optimizations**: State updates are targeted and efficient
6. **Responsive Design**: Layout adapts to different screen sizes and orientations
7. **Appropriate Scaling**: Elements scale proportionally but within reasonable limits 