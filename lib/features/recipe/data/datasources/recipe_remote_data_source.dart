import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_finder/core/constants/app_constants.dart';
import 'package:recipe_finder/core/failure.dart';
import 'package:recipe_finder/features/recipe/data/models/recipe_model.dart';

abstract class RecipeRemoteDataSource {
  Future<List<RecipeModel>> searchRecipes(String term);
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final http.Client client;

  RecipeRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RecipeModel>> searchRecipes(String term) async {
    final response = await client.get(
      Uri.parse(
        '${AppConstants.baseUrl}${AppConstants.searchEndpoint}?s=$term',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] == null) {
        return [];
      }
      return (data['meals'] as List)
          .map((meal) => RecipeModel.fromJson(meal))
          .toList();
    } else {
      throw ServerFailure('Failed to load recipes');
    }
  }
}
