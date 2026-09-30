
String prettyCategory(String category) {
  return category
      .split('-')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');
}