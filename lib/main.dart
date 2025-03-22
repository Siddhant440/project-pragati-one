import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'theme/app_theme.dart';
import 'viewmodels/home_viewmodel.dart';
import 'views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Timer _timer;
  final homeViewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    // Refresh data periodically to ensure real-time updates
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      homeViewModel.refreshData();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => homeViewModel,
      child: MaterialApp(
        title: 'Project Progress',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
//main