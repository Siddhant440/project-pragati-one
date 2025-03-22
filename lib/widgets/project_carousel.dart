import 'package:flutter/material.dart';
import 'dart:async';
import 'dot_indicator.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class ProjectCarousel extends StatefulWidget {
  final List<String> projectImages;
  final List<String> projectNames;
  final double height;

  const ProjectCarousel({
    Key? key,
    required this.projectImages,
    required this.projectNames,
    this.height = 290,
  }) : super(key: key);

  @override
  State<ProjectCarousel> createState() => _ProjectCarouselState();
}

class _ProjectCarouselState extends State<ProjectCarousel>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Use a large initial page value to avoid reaching boundaries too quickly
    _pageController = PageController(
      initialPage:
          widget.projectImages.length * 10, // Start from a large middle value
      viewportFraction: 0.7, // Show partial previous/next images
    );

    // Start auto-scrolling
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        // Always move forward, looping will be handled by onPageChanged
        _pageController.nextPage(
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: Column(
        children: [
          // Image carousel in a stack for animation
          Container(
            height: 220, // Reduced to make room for project name below
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Image carousel with curved path animation
                Positioned(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        // Always keep track of current image index using modulo
                        _currentPage = page % widget.projectImages.length;

                        // Only jump if we get too close to either end to prevent abrupt changes
                        // This provides a large buffer before needing to reset
                        if (page < widget.projectImages.length * 5) {
                          // If getting close to the beginning, jump forward
                          _pageController.jumpToPage(
                              page + widget.projectImages.length * 10);
                        } else if (page > widget.projectImages.length * 15) {
                          // If getting close to the end, jump backward
                          _pageController.jumpToPage(
                              page - widget.projectImages.length * 10);
                        }
                      });
                    },
                    // Allow "infinite" number of pages
                    itemCount: null,
                    itemBuilder: (context, index) {
                      // Use modulo to repeat images for infinite scrolling
                      final imageIndex = index % widget.projectImages.length;

                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          double value = 0;
                          if (_pageController.position.haveDimensions) {
                            value =
                                index.toDouble() - (_pageController.page ?? 0);
                            // Use smaller scale value to clamp effect
                            value = (value * 0.5).clamp(-1.0, 1.0);
                          }

                          // Create the curved path effect:
                          // Use a parabolic/semi-circular path
                          // For horizontal position: we keep the existing layout from PageView
                          // For vertical position: we apply a parabolic function
                          // When value is -1 or 1 (sides), y is higher (lower on screen)
                          // When value is 0 (center), y is lower (higher on screen)
                          double verticalOffset = 120 *
                              value *
                              value; // Parabolic function for semi-circular path

                          // Calculate scale factor - largest at center, smaller at sides
                          // Use 1 - abs(value) to make center = 1.0 and sides = smaller
                          // Center image is full size, side images are 85% of full size
                          double scaleFactor =
                              0.85 + (0.15 * (1 - value.abs()));

                          return Transform.translate(
                            offset: Offset(0, verticalOffset),
                            child: Transform.scale(
                              scale: scaleFactor,
                              child: Align(
                                alignment: Alignment.center,
                                child: child,
                              ),
                            ),
                          );
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadowDark.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 2,
                              )
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              widget.projectImages[imageIndex],
                              height: 204, // Updated size
                              width: 275, // Updated size
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 204, // Updated size
                                  width: 275, // Updated size
                                  color: AppColors.darkPurpleBackground,
                                  child: Center(
                                    child: Icon(
                                      Icons.construction,
                                      size: 48,
                                      color: AppColors.primaryPurple,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Project name below images
          Text(
            widget.projectNames[_currentPage],
            style: context.carouselItemText,
          ),

          SizedBox(height: 12),

          // Dots indicator
          DotIndicator(
            count: widget.projectImages.length,
            currentIndex: _currentPage,
          ),
        ],
      ),
    );
  }
}
