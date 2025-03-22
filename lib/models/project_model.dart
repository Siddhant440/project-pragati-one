class Project {
  final String name;
  final String imageUrl;
  final double progress;
  final int totalDots;
  final int completedDots;

  Project({
    required this.name,
    required this.imageUrl,
    required this.progress,
    required this.totalDots,
    required this.completedDots,
  });
}
