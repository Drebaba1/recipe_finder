import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_finder/core/network/network_info.dart';
import 'package:recipe_finder/core/providers/network_provider.dart';
import 'package:recipe_finder/core/utils/extensions.dart';
import 'package:recipe_finder/features/recipe/data/datasources/recipe_remote_data_source.dart';
import 'package:recipe_finder/features/recipe/data/repositories/recipe_repository_impl.dart';
import 'package:recipe_finder/features/recipe/domain/repositories/recipe_repository.dart';
import 'package:recipe_finder/features/recipe/domain/use_cases/search_recipes.dart';
import 'package:recipe_finder/features/recipe/presentation/providers/recipe_provider.dart';
import 'package:recipe_finder/features/recipe/presentation/providers/recipe_state.dart';

final recipeRemoteDataSourceProvider = Provider<RecipeRemoteDataSource>((ref) {
  return RecipeRemoteDataSourceImpl(client: http.Client());
});

final networkInfoProvider = Provider<NetworkInfo>((ref) {
  final connectivity = ref.watch(networkProvider);
  return NetworkInfoImpl(connectivity);
});

final recipeRepositoryProvider = Provider<RecipeRepository>((ref) {
  return RecipeRepositoryImpl(
    remoteDataSource: ref.read(recipeRemoteDataSourceProvider),
    networkInfo: ref.read(networkInfoProvider),
  );
});

final searchRecipesProvider = Provider<SearchRecipes>((ref) {
  return SearchRecipes(ref.read(recipeRepositoryProvider));
});

final recipeNotifierProvider =
    StateNotifierProvider<RecipeNotifier, RecipeState>((ref) {
      return RecipeNotifier(
        searchRecipes: ref.read(searchRecipesProvider),
        inputConverter: InputConverter(),
      );
    });
