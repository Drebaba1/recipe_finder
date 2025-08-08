import 'package:recipe_finder/core/failure.dart';
import 'package:recipe_finder/core/network/network_info.dart';
import 'package:recipe_finder/features/recipe/data/datasources/recipe_remote_data_source.dart';
import 'package:recipe_finder/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_finder/features/recipe/domain/repositories/recipe_repository.dart';
import 'package:dartz/dartz.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RecipeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Recipe>>> searchRecipes(String term) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRecipes = await remoteDataSource.searchRecipes(term);
        return Right(remoteRecipes.map((model) => model.toEntity()).toList());
      } on ServerFailure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }
}
