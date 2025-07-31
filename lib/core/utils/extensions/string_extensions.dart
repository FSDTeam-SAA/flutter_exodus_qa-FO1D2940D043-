extension StringExtensions on String {

  /// [Only First Letter]
  String capitalizeFirstLetter() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  /// [All First Letters]
  String get capitalizeFirstOfEach =>
      split(' ').map((str) => str.capitalizeFirstLetter()).join(' ');

  /// [Start with @ for username]
  /// Ensures the string starts with '@' for usernames
  String get startsWithAt {
    if (startsWith('@')) return this;
    return '@$this';
  }
}
