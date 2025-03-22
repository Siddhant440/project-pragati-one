import 'package:flutter/material.dart';
import '../models/project_model.dart';

class HomeViewModel extends ChangeNotifier {
  String userName = "Shubham";
  double _overallProgress = 0.65; // Default value
  int daysRemaining = 15;

  List<Project> projects = [
    Project(
      name: "Project BedRock",
      imageUrl: "assets/images/concrete-construction.png",
      progress: 0.9,
      totalDots: 3,
      completedDots: 3,
    ),
  ];

  // Return the current overall progress
  double get overallProgress => _overallProgress;

  // Set the progress value and notify listeners
  set overallProgress(double value) {
    _overallProgress = value;
    notifyListeners();
  }

  // Calculate the percentage of month completed
  double get monthProgress {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    return now.day / daysInMonth;
  }

  // Recalculate and update all dynamic values
  void refreshData() {
    // Update overall progress (example: could be from API in real app)
    // For now, we'll use the month progress as the overall progress too
    _overallProgress = monthProgress;
    notifyListeners();
  }

  // Constructor
  HomeViewModel() {
    // Initialize with current data
    refreshData();
  }

  void updateDaysRemaining(int days) {
    daysRemaining = days;
    notifyListeners();
  }
}
