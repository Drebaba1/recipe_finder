import 'package:recipe_finder/features/recipe/domain/entities/recipe.dart';

class RecipeModel {
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

  RecipeModel({
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

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    final ingredients = <String>[];
    final measures = <String>[];

    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add(ingredient);
        measures.add(measure ?? '');
      }
    }

    return RecipeModel(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? 'No name',
      thumbnail: json['strMealThumb'] ?? '',
      category: json['strCategory'] ?? '',
      area: json['strArea'] ?? '',
      ingredients: ingredients,
      measures: measures,
      instructions: json['strInstructions'] ?? 'No instructions provided',
      youtubeUrl: json['strYoutube'],
      sourceUrl: json['strSource'],
    );
  }

  Recipe toEntity() {
    return Recipe(
      id: id,
      name: name,
      thumbnail: thumbnail,
      category: category,
      area: area,
      ingredients: ingredients,
      measures: measures,
      instructions: instructions,
      youtubeUrl: youtubeUrl,
      sourceUrl: sourceUrl,
    );
  }
}
