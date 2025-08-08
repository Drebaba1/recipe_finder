import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constants/app_constants.dart';

class RecipeSearchBar extends StatefulWidget {
  final Function(String) onSearch;
  final VoidCallback onClear;
  final String initialValue;

  const RecipeSearchBar({
    super.key,
    required this.onSearch,
    required this.onClear,
    this.initialValue = '',
  });

  @override
  State<RecipeSearchBar> createState() => _RecipeSearchBarState();
}

class _RecipeSearchBarState extends State<RecipeSearchBar> {
  late final TextEditingController _searchController;
  bool _hasInput = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialValue);

    _searchController.addListener(() {
      setState(() {
        _hasInput = _searchController.text.isNotEmpty;
      });
    });
  }

  @override
  void didUpdateWidget(covariant RecipeSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _searchController.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search recipes...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _hasInput
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  widget.onClear();
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius * 2),
          borderSide: BorderSide.none,
        ),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: AppConstants.defaultPadding,
        ),
      ),
      onSubmitted: widget.onSearch,
    );
  }
}
