import 'package:recipe_finder/features/recipe/domain/entities/recipe.dart';

abstract class RecipeState {
  final String lastSearchTerm;

  const RecipeState({required this.lastSearchTerm});
}

class InitialRecipeState extends RecipeState {
  const InitialRecipeState() : super(lastSearchTerm: '');
}

class LoadingRecipeState extends RecipeState {
  const LoadingRecipeState({required super.lastSearchTerm});
}

class LoadedRecipeState extends RecipeState {
  final List<Recipe> recipes;

  const LoadedRecipeState({
    required this.recipes,
    required super.lastSearchTerm,
  });
}

class ErrorRecipeState extends RecipeState {
  final String message;

  const ErrorRecipeState({
    required this.message,
    required super.lastSearchTerm,
  });
}

class EmptyRecipeState extends RecipeState {
  const EmptyRecipeState({required super.lastSearchTerm});
}
