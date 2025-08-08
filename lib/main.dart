import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_finder/core/utils/theme.dart';
import 'package:recipe_finder/features/recipe/presentation/pages/splash.dart';

void main() {
  runApp(const ProviderScope(child: RecipeFinderApp()));
}

class RecipeFinderApp extends StatelessWidget {
  const RecipeFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Finder',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
