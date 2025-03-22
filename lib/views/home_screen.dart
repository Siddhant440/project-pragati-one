import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart'; // Add import for date formatting
import '../viewmodels/home_viewmodel.dart';
import '../widgets/progress_indicator.dart';
import '../widgets/custom_menu_button.dart';
import '../widgets/project_carousel.dart';
import '../widgets/calendar_view.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/snackbar_utils.dart';

class MenuItem {
  final String title;
  final IconData? icon;
  MenuItem(this.title, this.icon);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _activeMenuItem = 'DPR'; // Set initial active menu item
  int _selectedNavIndex = 2; // Default to Analytics tab

  final List<MenuItem> menuItems = [
    MenuItem('DPR', null),
    MenuItem('Cash OutFlow', null),
    MenuItem('Cash InFlow', null),
    MenuItem('Material Issues', null),
    MenuItem('M Reconciliation', null),
    MenuItem('Material Receipt', null),
    MenuItem('Go to Dashboard', null),
  ];

  final List<String> projectImages = [
    "assets/images/concrete-construction.png",
    "assets/images/concstruction-site.png",
    "assets/images/doha-construction.png",
  ];

  final List<String> projectNames = [
    "Project BedRock",
    "Project Atlas",
    "Project ShadowFX"
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppColors.getBackgroundColor(context),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: 16,
                top: 69,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.avatarBackgroundLight,
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/profile_pic.png',
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 40,
                                      height: 40,
                                      color: AppColors.avatarBackgroundDark,
                                      child: Icon(
                                        Icons.person,
                                        color: AppColors.getTextColor(context),
                                        size: 30,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Good Morning',
                                  style: context.greetingText,
                                ),
                                Text(
                                  'Shubham!',
                                  style: context.nameText,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 80),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                          child:
                              Theme.of(context).brightness == Brightness.light
                                  ? InkWell(
                                      onTap: () {},
                                      child: Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          boxShadow:
                                              AppColors.notificationIconShadow,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.notifications_outlined,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    )
                                  : IconButton(
                                      icon: Icon(Icons.notifications_outlined),
                                      color: AppColors.textWhite,
                                      onPressed: () {},
                                    ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),

                  // Main Content Area with Buttons on Left, Progress on Right
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column - Menu Buttons
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: LayoutBuilder(
                                  builder: (context, constraints) {
                                // Calculate available height based on right column height
                                // Daily progress (220) + spacing (16) + calendar (117) = 353
                                final double availableHeight = 353;

                                // Calculate button height and spacing
                                final int numberOfButtons = menuItems.length;
                                final double buttonHeight =
                                    34.0; // Fixed button height
                                final double totalButtonsHeight =
                                    buttonHeight * numberOfButtons;

                                // Calculate spacing to distribute remaining height
                                final double remainingHeight =
                                    availableHeight - totalButtonsHeight;
                                final double spacing =
                                    remainingHeight / (numberOfButtons - 1);

                                return SizedBox(
                                  height: availableHeight,
                                  child: ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: menuItems.length,
                                    separatorBuilder: (context, index) {
                                      return SizedBox(height: spacing);
                                    },
                                    itemBuilder: (context, index) {
                                      final item = menuItems[index];
                                      return CustomMenuButton(
                                        title: item.title,
                                        icon: item.icon,
                                        isActive: item.title == _activeMenuItem,
                                        onPressed: () {
                                          // Handle button press
                                          setState(() {
                                            _activeMenuItem = item.title;
                                          });
                                          // Show snackbar with button name
                                          SnackBarUtils.showSnackBar(
                                            context,
                                            message: '${item.title} selected',
                                          );
                                          print('${item.title} pressed');
                                        },
                                      );
                                    },
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 25),

                      // Right Column - Progress Card
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Column(
                            children: [
                              // Daily Progress container
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppColors.containerGradient
                                      : null,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? AppColors.lightBackground
                                      : null,
                                  boxShadow: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? AppColors.lightModeShadow
                                      : null,
                                ),
                                child: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Container(
                                        margin: const EdgeInsets.all(1),
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16, top: 12),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? AppColors.darkBackground
                                              : AppColors.lightBackground,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Daily Progress',
                                              style: context.dailyProgressTitle,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              DateFormat('MMMM d, yyyy')
                                                  .format(DateTime.now()),
                                              style:
                                                  context.dailyProgressSubtitle,
                                            ),
                                            SizedBox(height: 10),
                                            Center(
                                              child:
                                                  CustomCircularProgressIndicator(
                                                progress:
                                                    viewModel.monthProgress,
                                                label: 'Based on Reports',
                                                size: 110,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16, top: 12),
                                        decoration: BoxDecoration(
                                          color: AppColors.lightBackground,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Daily Progress',
                                              style: context.dailyProgressTitle,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              DateFormat('MMMM d, yyyy')
                                                  .format(DateTime.now()),
                                              style:
                                                  context.dailyProgressSubtitle,
                                            ),
                                            SizedBox(height: 10),
                                            Center(
                                              child:
                                                  CustomCircularProgressIndicator(
                                                progress:
                                                    viewModel.monthProgress,
                                                label: 'Based on Reports',
                                                size: 110,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ),

                              SizedBox(height: 16),

                              // Calendar container - full width
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppColors.containerGradient
                                      : null,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? AppColors.lightBackground
                                      : null,
                                  boxShadow: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? AppColors.lightModeShadow
                                      : null,
                                ),
                                child: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Container(
                                        margin: const EdgeInsets.all(1),
                                        child: CalendarView(),
                                      )
                                    : CalendarView(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Projects with curved path animation
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: ProjectCarousel(
                      projectImages: projectImages,
                      projectNames: projectNames,
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            color:
                Theme.of(context).brightness == Brightness.dark ? null : null,
            height: 76,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.navbarBackground
                  : AppColors.navbarLightBackground,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
                bottomLeft: Radius.zero,
                bottomRight: Radius.zero,
              ),
              boxShadow: Theme.of(context).brightness == Brightness.light
                  ? AppColors.navbarShadow
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(
                    0, 'assets/icons/navbar/navicon1.svg', 'Home', 24),
                _buildNavItem(
                    1, 'assets/icons/navbar/navicon2.svg', 'Cash Flow', 24,
                    showRupee: true),
                _buildNavItem(
                    2, 'assets/icons/navbar/navicon3.svg', 'Analytics', 24),
                _buildNavBarIcon(3, Icons.access_time, 'Progress', 24),
                _buildNavItem(
                    4, 'assets/icons/navbar/navicon5.svg', 'Material', 30),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(int index, String iconPath, String label, int size,
      {bool showRupee = false}) {
    final isSelected = index == _selectedNavIndex;

    return Expanded(
      child: InkWell(
        onTap: () => _handleNavTap(index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          height: 76, // Full height of navbar
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  isSelected
                      ? ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return AppColors.purpleGradient
                                .createShader(bounds);
                          },
                          child: SvgPicture.asset(
                            iconPath,
                            width: size.toDouble(),
                            height: size.toDouble(),
                            colorFilter: ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        )
                      : SvgPicture.asset(
                          iconPath,
                          width: size.toDouble(),
                          height: size.toDouble(),
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColors.navIconGrey
                                : AppColors.navIconLightGrey,
                            BlendMode.srcIn,
                          ),
                        ),
                  if (showRupee)
                    Positioned(
                      child: isSelected
                          ? ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return AppColors.purpleGradient
                                    .createShader(bounds);
                              },
                              child: Text(
                                '₹',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Text(
                              '₹',
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppColors.navIconGrey
                                    : AppColors.navIconLightGrey,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                ],
              ),
              SizedBox(height: 2),
              isSelected
                  ? ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return AppColors.purpleGradient.createShader(bounds);
                      },
                      child: Text(
                        label,
                        style: context.navbarTextActive,
                      ),
                    )
                  : Text(
                      label,
                      style: context.navbarText,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavBarIcon(int index, IconData icon, String label, int size) {
    final isSelected = index == _selectedNavIndex;

    return Expanded(
      child: InkWell(
        onTap: () => _handleNavTap(index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          height: 76, // Full height of navbar
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isSelected
                  ? ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return AppColors.purpleGradient.createShader(bounds);
                      },
                      child: Icon(
                        icon,
                        size: size.toDouble(),
                        color: Colors.white,
                      ),
                    )
                  : Icon(
                      icon,
                      size: size.toDouble(),
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.navIconGrey
                          : AppColors.navIconLightGrey,
                    ),
              SizedBox(height: 2),
              isSelected
                  ? ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return AppColors.purpleGradient.createShader(bounds);
                      },
                      child: Text(
                        label,
                        style: context.navbarTextActive,
                      ),
                    )
                  : Text(
                      label,
                      style: context.navbarText,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleNavTap(int index) {
    if (_selectedNavIndex != index) {
      setState(() {
        _selectedNavIndex = index;
      });

      // Show snack bar with the tapped navigation item
      String itemName = '';
      switch (index) {
        case 0:
          itemName = 'Home';
          break;
        case 1:
          itemName = 'Cash Flow';
          break;
        case 2:
          itemName = 'Analytics';
          break;
        case 3:
          itemName = 'Progress';
          break;
        case 4:
          itemName = 'Material';
          break;
      }

      SnackBarUtils.showSnackBar(
        context,
        message: '$itemName selected',
      );
    }
  }
}
