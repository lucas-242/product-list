import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_list/app/modules/products/infra/models/product_model.dart';

class ProductFirebaseModel extends ProductModel {
  ProductFirebaseModel({
    super.id,
    required super.title,
    required super.type,
    required super.filename,
    required super.price,
    required super.description,
    required super.width,
    required super.height,
    required super.rating,
    required super.createdAt,
    required super.updatedAt,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'type': type,
      'description': description,
      'filename': filename,
      'height': height,
      'width': width,
      'price': price,
      'rating': rating,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  factory ProductFirebaseModel.fromMap(Map<String, dynamic> map) {
    return ProductFirebaseModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      type: map['type'] ?? '',
      description: map['description'] ?? '',
      filename: map['filename'] ?? '',
      height: map['height']?.toDouble() ?? 0.0,
      width: map['width']?.toDouble() ?? 0.0,
      price: map['price']?.toDouble() ?? 0.0,
      rating: map['rating']?.toDouble() ?? 0.0,
      createdAt: map['createdAt']?.toDate(),
      updatedAt: map['updatedAt']?.toDate(),
    );
  }

  factory ProductFirebaseModel.fromProductModel(ProductModel productModel) {
    return ProductFirebaseModel(
      id: productModel.id,
      title: productModel.title,
      type: productModel.type,
      description: productModel.description,
      filename: productModel.filename,
      height: productModel.height,
      width: productModel.width,
      price: productModel.price,
      rating: productModel.rating,
      createdAt: productModel.createdAt,
      updatedAt: productModel.updatedAt,
    );
  }
}
