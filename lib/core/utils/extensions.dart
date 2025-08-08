class InputConverter {
  String validateSearchTerm(String term) {
    if (term.isEmpty) {
      return 'Please enter a search term';
    }
    if (term.length < 3) {
      return 'Search term must be at least 3 characters';
    }
    return '';
  }
}
