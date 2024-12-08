/// Category Model
/// Contains information about a product category
class Category {
  final String id;
  final String name;
  final String imageUrl;
  final String svgIcon;

  const Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.svgIcon,
  });
} 