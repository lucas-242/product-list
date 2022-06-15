import 'package:flutter/material.dart';

enum SnackBarType { success, error }

ScaffoldFeatureController getAppSnackBar({
  required BuildContext context,
  required String message,
  required SnackBarType type,
}) {
  final colors = Theme.of(context).colorScheme;
  final textColor = type == SnackBarType.error ? colors.error : colors.primary;
  final backgroudColor = type == SnackBarType.error
      ? colors.errorContainer
      : colors.primaryContainer;

  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroudColor,
    ),
  );
}
