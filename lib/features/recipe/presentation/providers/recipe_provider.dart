import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_finder/core/utils/extensions.dart';
import 'package:recipe_finder/features/recipe/domain/use_cases/search_recipes.dart';
import 'package:recipe_finder/features/recipe/presentation/providers/recipe_state.dart';

class RecipeNotifier extends StateNotifier<RecipeState> {
  final SearchRecipes searchRecipes;
  final InputConverter inputConverter;

  RecipeNotifier({required this.searchRecipes, required this.inputConverter})
    : super(const InitialRecipeState());

  Future<void> search(String term) async {
    final validationMessage = inputConverter.validateSearchTerm(term);
    if (validationMessage.isNotEmpty) {
      state = ErrorRecipeState(
        message: validationMessage,
        lastSearchTerm: term,
      );
      return;
    }

    state = LoadingRecipeState(lastSearchTerm: term);

    final result = await searchRecipes(term);

    result.fold(
      (failure) => state = ErrorRecipeState(
        message: failure.message,
        lastSearchTerm: term,
      ),
      (recipes) => state = recipes.isEmpty
          ? EmptyRecipeState(lastSearchTerm: term)
          : LoadedRecipeState(recipes: recipes, lastSearchTerm: term),
    );
  }

  void clearSearch() {
    state = const InitialRecipeState();
  }
}
