class Recipe {
  final String id;
  final String name;
  final String thumbnail;
  final String category;
  final String area;
  final List<String> ingredients;
  final List<String> measures;
  final String instructions;
  final String? youtubeUrl;
  final String? sourceUrl;

  Recipe({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.category,
    required this.area,
    required this.ingredients,
    required this.measures,
    required this.instructions,
    this.youtubeUrl,
    this.sourceUrl,
  });
}
