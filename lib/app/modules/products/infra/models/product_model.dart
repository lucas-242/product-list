import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_list/app/modules/products/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    super.id,
    required super.title,
    required super.type,
    required super.filename,
    required super.price,
    super.description,
    super.width,
    super.height,
    super.rating,
    super.createdAt,
    super.updatedAt,
  });

  factory ProductModel.fromProduct(Product product) => ProductModel(
        id: product.id,
        title: product.title,
        type: product.type,
        description: product.description,
        filename: product.filename,
        height: product.height,
        width: product.width,
        price: product.price,
        rating: product.rating,
        createdAt: product.createdAt,
        updatedAt: product.updatedAt,
      );

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

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      type: map['type'] ?? '',
      description: map['description'] ?? '',
      filename: map['filename'] ?? '',
      height: map['height']?.toDouble() ?? 0.0,
      width: map['width']?.toDouble() ?? 0.0,
      price: map['price']?.toDouble() ?? 0.0,
      rating: map['rating']?.toDouble() ?? 0.0,
      createdAt: map['createdAt'].toDate(),
      updatedAt: map['updatedAt'].toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  ProductModel copyWith({
    String? id,
    String? title,
    String? type,
    String? description,
    String? filename,
    double? height,
    double? width,
    double? price,
    double? rating,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
      filename: filename ?? this.filename,
      height: height ?? this.height,
      width: width ?? this.width,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
