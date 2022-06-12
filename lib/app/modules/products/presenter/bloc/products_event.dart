part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class GetProductsEvent extends ProductsEvent {}

class CreateProductsEvent extends ProductsEvent {}

class DeleteProductEvent extends ProductsEvent {
  final String id;

  const DeleteProductEvent(this.id);
}
