import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String type;
  final String description;
  final String filename;
  final double height;
  final double width;
  final double price;
  final double rating;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    this.id = '',
    required this.title,
    required this.type,
    this.description = '',
    required this.filename,
    this.height = 0,
    this.width = 0,
    required this.price,
    this.rating = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  bool get isValidTitle => title.isNotEmpty;
  bool get isValidType => type.isNotEmpty;
  bool get isValidPrice => price > 0;

  @override
  List<Object?> get props => [
        id,
        title,
        type,
        description,
        filename,
        height,
        width,
        price,
        rating,
        createdAt,
        updatedAt,
      ];
}
