import 'package:dartz/dartz.dart';
import 'package:recipe_finder/core/failure.dart';
import 'package:recipe_finder/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_finder/features/recipe/domain/repositories/recipe_repository.dart';

class SearchRecipes {
  final RecipeRepository repository;

  SearchRecipes(this.repository);

  Future<Either<Failure, List<Recipe>>> call(String term) async {
    return await repository.searchRecipes(term);
  }
}
