import 'package:product_list/app/core/errors/errors.dart';

class InvalidProductFailure implements Failure {
  @override
  String message;

  InvalidProductFailure({String? message})
      : message = message ?? 'Product is invalid';
}