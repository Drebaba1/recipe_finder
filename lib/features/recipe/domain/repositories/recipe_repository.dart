import 'package:dartz/dartz.dart';
import 'package:recipe_finder/core/failure.dart';
import 'package:recipe_finder/features/recipe/domain/entities/recipe.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<Recipe>>> searchRecipes(String term);
}
