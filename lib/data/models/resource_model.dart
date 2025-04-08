class ResourceModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final String? imageUrl;
  final int durationMinutes;

  ResourceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.imageUrl,
    required this.durationMinutes,
  });
}