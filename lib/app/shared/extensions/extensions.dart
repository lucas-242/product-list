extension StringExtensions on String {
  String capitalize() {
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}

extension EnumExtension on Enum {
  String toShortString() {
    return toString().split('.').last;
  }
}
