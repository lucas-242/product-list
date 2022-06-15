part of 'update_product_bloc.dart';

enum UpdateProductStatus { success, error, update }

class UpdateProductState extends Equatable {
  final UpdateProductStatus status;
  final Product? initialProduct;
  final String title;
  final String description;
  final String type;
  final double price;
  final double rating;
  final double width;
  final double height;

  const UpdateProductState({
    this.status = UpdateProductStatus.update,
    this.initialProduct,
    this.title = '',
    this.description = '',
    this.type = '',
    this.price = 0,
    this.rating = 0,
    this.width = 0,
    this.height = 0,
  });

  UpdateProductState copyWith({
    Product? initialProduct,
    UpdateProductStatus? status,
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
    return UpdateProductState(
      initialProduct: initialProduct ?? this.initialProduct,
      status: status ?? this.status,
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
      height: height ?? this.height,
      width: width ?? this.width,
      price: price ?? this.price,
      rating: rating ?? this.rating,
    );
  }

  @override
  List<Object> get props => [
        status,
        title,
        description,
        type,
        price,
        rating,
        width,
        height,
      ];
}
