import 'dart:io';

import 'package:path/path.dart';

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

extension FileExtension on File {
  String getFileName() {
    return basename(path);
  }

  Future<File> changeFileName(String newFileName) {
    final fileExtension = extension(path);
    final lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    final newPath =
        path.substring(0, lastSeparator + 1) + newFileName + fileExtension;
    return rename(newPath);
  }
}
