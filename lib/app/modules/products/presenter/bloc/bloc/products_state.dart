part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  final List<Product> products;
  final String? errorMessage;

  T when<T>({
    T Function(ProductsState state)? onState,
    T Function(ErrorState error)? onError,
    T Function()? onLoading,
  });
  const ProductsState({this.products = const [], this.errorMessage});

  @override
  List<Object> get props => [products];
}

class ListedState extends ProductsState {
  const ListedState({required List<Product> products, String? errorMessage})
      : super(products: products, errorMessage: errorMessage);

  @override
  T when<T>({
    T Function(ProductsState state)? onState,
    T Function(ErrorState error)? onError,
    T Function()? onLoading,
  }) {
    return onState!(this);
  }
}

class LoadingState extends ProductsState {
  @override
  T when<T>({
    T Function(ProductsState state)? onState,
    T Function(ErrorState error)? onError,
    T Function()? onLoading,
  }) {
    return onLoading!();
  }
}

class ErrorState extends ProductsState {
  const ErrorState(String? errorMessage) : super(errorMessage: errorMessage);

  @override
  T when<T>({
    T Function(ProductsState state)? onState,
    T Function(ErrorState error)? onError,
    T Function()? onLoading,
  }) {
    return onError!(this);
  }
}
