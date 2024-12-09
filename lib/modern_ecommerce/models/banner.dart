class PromoBanner {
  final String id;
  final String imageUrl;
  final String title;
  final String subtitle;
  final String? actionText;
  final String? actionRoute;
  final Map<String, dynamic>? actionParams;

  const PromoBanner({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    this.actionText,
    this.actionRoute,
    this.actionParams,
  });
} 