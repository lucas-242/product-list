import 'dart:io';

import 'package:mime/mime.dart';
import 'package:product_list/app/modules/products/domain/errors/products_errors.dart';
import 'package:product_list/app/modules/products/domain/repositories/products_repository.dart';

abstract class UploadProductImage {
  Future<void> call(File image);
}

class UploadProductImageImpl implements UploadProductImage {
  final ProductsRepository repository;

  UploadProductImageImpl(this.repository);

  @override
  Future<void> call(File image) async {
    _validateImage(image.path);
    return await _uploadProductImage(image);
  }

  bool _validateImage(String path) {
    final mimeType = lookupMimeType(path);

    if (mimeType == null) {
      throw InvalidProductImageFailure();
    }
    return mimeType.startsWith('image/');
  }

  Future<void> _uploadProductImage(File image) async {
    await repository.uploadProductImage(image);
  }
}
