part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  final List<Product> products;
  final String? message;

  T when<T>({
    T Function(ProductsState state)? onState,
    T Function(ErrorState error)? onError,
    T Function()? onNoData,
    T Function()? onLoading,
  });
  const ProductsState({this.products = const [], this.message});

  @override
  List<Object> get props => [products];
}

class ListedState extends ProductsState {
  const ListedState({required List<Product> products, String? message})
      : super(products: products, message: message);

  @override
  T when<T>({
    T Function(ProductsState state)? onState,
    T Function(ErrorState error)? onError,
    T Function()? onNoData,
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
    T Function()? onNoData,
    T Function()? onLoading,
  }) {
    return onLoading!();
  }
}

class ErrorState extends ProductsState {
  const ErrorState(String? message) : super(message: message);

  @override
  T when<T>({
    T Function(ProductsState state)? onState,
    T Function(ErrorState error)? onError,
    T Function()? onNoData,
    T Function()? onLoading,
  }) {
    return onError!(this);
  }
}

class NoDataState extends ProductsState {
  @override
  T when<T>({
    T Function(ProductsState state)? onState,
    T Function(ErrorState error)? onError,
    T Function()? onNoData,
    T Function()? onLoading,
  }) {
    return onNoData!();
  }
}
