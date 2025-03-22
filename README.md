# Project Progress Tracker

A Flutter application for tracking and visualizing project progress. This app provides a clean, modern UI with support for both light and dark themes, and features responsive design to adapt to any screen size.

## Features

- **Theme Support**: Automatically adapts to system theme (light/dark mode)
- **Responsive Design**: Adapts to different screen sizes and orientations
- **Project Progress Tracking**: Visual progress indicators for ongoing projects
- **Daily Reports**: Track daily progress with percentage indicators
- **Project Carousel**: Browse through multiple projects with a card-based UI
- **Custom UI Components**: Polished interface with consistent typography and color schemes

## Architecture

The application follows the MVVM (Model-View-ViewModel) architecture pattern:

### Folder Structure

lib/
├── models/        # Data models
├── theme/         # Theming and styling definitions
├── utils/         # Utility functions and helpers
├── viewmodels/    # State management
├── views/         # UI screens
├── widgets/       # Reusable UI components
└── main.dart      # Application entry point

### Key Components

#### Models
- `Project`: Data model representing a project with properties like name, progress, and image

#### ViewModels
- `HomeViewModel`: Manages the state for the home screen, including project data, progress metrics, and periodic data refreshes.

#### Views
- `HomeScreen`: Main UI screen displaying project progress, daily reports, and project carousel

#### Widgets
- `CustomMenuButton`: Interactive menu buttons with active/inactive states
- `DotIndicator`: Visual indicators for carousel navigation
- `ProjectCarousel`: Horizontally scrollable project cards
- `ProgressIndicator`: Custom visualizations of progress
- `CalendarView`: Monthly calendar with progress tracking
- `ResponsiveLayout`: Framework for adapting UI to different screen sizes
- `OrientationLayout`: Adjusts layout based on device orientation
- `ProjectCard`: Card component for displaying project information

### Responsive Design System

The application implements a comprehensive responsive design system to adapt to different screen sizes:

- **ResponsiveSize**: Core utility class for calculating dimensions relative to screen size
- **DeviceType Detection**: UI adapts based on device category (mobile, tablet, desktop)
- **Orientation Awareness**: Layouts adjust for portrait and landscape orientations
- **Proportional Sizing**: All dimensions are calculated relative to screen size

## Theming System

The theming system supports both light and dark modes:

- **AppColors**: Centralizes color definitions with theme-aware helper methods
- **AppTypography**: Defines text styles with context extensions for theming
- **AppTheme**: Configures complete theme data for both light and dark themes

## Dependencies

- `provider`: ^6.1.1 - State management
- `google_fonts`: ^6.1.0 - Typography
- `flutter_svg`: ^2.0.10+1 - SVG asset rendering
- `intl`: ^0.19.0 - Internationalization and date formatting


## Implementation Highlights

1. **Periodic Data Updates**: The app refreshes data automatically every minute to ensure real-time project progress tracking
2. **Consistent Typography**: All text styling is managed through the centralized typography system
3. **Theme-Aware Rendering**: Components adapt to light/dark themes automatically
4. **Reusable Components**: Widgets are designed to be reusable with customizable properties
5. **Efficient State Management**: Uses Provider for state management with targeted updates
