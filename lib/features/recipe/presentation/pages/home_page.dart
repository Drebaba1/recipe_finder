// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_finder/core/constants/app_constants.dart';
import 'package:recipe_finder/core/providers/app_provider.dart';
import 'package:recipe_finder/core/widgets/error_widget.dart';
import 'package:recipe_finder/core/widgets/loading_widget.dart';
import 'package:recipe_finder/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_finder/features/recipe/presentation/pages/recipe_detail_page.dart';
import 'package:recipe_finder/features/recipe/presentation/providers/recipe_state.dart';
import 'package:recipe_finder/features/recipe/presentation/widgets/recipe_card.dart';
import 'package:recipe_finder/features/recipe/presentation/widgets/search_bar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recipeNotifierProvider);
    final notifier = ref.read(recipeNotifierProvider.notifier);
    final searchBarKey = GlobalKey<RecipeSearchBarState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            RecipeSearchBar(
              key: searchBarKey,
              initialValue: state.lastSearchTerm,
              onSearch: (term) => notifier.search(term),
              onClear: notifier.clearSearch,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: switch (state) {
                InitialRecipeState() => _buildInitialState(
                  context,
                  ref,
                  searchBarKey,
                ),
                LoadingRecipeState() => const LoadingWidget(),
                LoadedRecipeState() => _buildRecipeList(state.recipes),
                ErrorRecipeState() => ErrorDisplayWidget(
                  message: state.message,
                  onRetry: () => notifier.search(state.lastSearchTerm),
                ),
                EmptyRecipeState() => _buildEmptyState(context),
                _ => const SizedBox(),
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialState(
    BuildContext context,
    WidgetRef ref,
    GlobalKey<RecipeSearchBarState> searchBarKey,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Icon(
              Icons.restaurant_menu,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'Looking for Recipes?',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Discover thousands of delicious recipes from around the world.\n'
              'Search by ingredient, cuisine, or meal type to find your next favorite dish!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Icon(Icons.search, size: 36),
                  const SizedBox(height: 12),
                  Text(
                    'Try searching for:',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: ['Pasta', 'Chicken', 'Vegetarian', 'Salad']
                        .map(
                          (term) => ActionChip(
                            label: Text(term),
                            onPressed: () {
                              searchBarKey.currentState?.updateSearchText(term);
                              ref
                                  .read(recipeNotifierProvider.notifier)
                                  .search(term);
                            },
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeList(List<Recipe> recipes) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return RecipeCard(
          recipe: recipe,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetailPage(recipe: recipe),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.fastfood_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No recipes found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
