part of 'update_product_bloc.dart';

abstract class UpdateProductEvent extends Equatable {
  const UpdateProductEvent();

  @override
  List<Object> get props => [];
}

class UpdateProductTitleEvent extends UpdateProductEvent {
  final String title;

  const UpdateProductTitleEvent(this.title);

  @override
  List<Object> get props => [title];
}

class UpdateProductDescriptionEvent extends UpdateProductEvent {
  final String description;

  const UpdateProductDescriptionEvent(this.description);

  @override
  List<Object> get props => [description];
}

class UpdateProductTypeEvent extends UpdateProductEvent {
  final String type;

  const UpdateProductTypeEvent(this.type);

  @override
  List<Object> get props => [type];
}

class UpdateProductPriceEvent extends UpdateProductEvent {
  final String price;

  const UpdateProductPriceEvent(this.price);

  @override
  List<Object> get props => [price];
}

class UpdateProductRatingEvent extends UpdateProductEvent {
  final String rating;

  const UpdateProductRatingEvent(this.rating);

  @override
  List<Object> get props => [rating];
}

class UpdateProductWidthEvent extends UpdateProductEvent {
  final String width;

  const UpdateProductWidthEvent(this.width);

  @override
  List<Object> get props => [width];
}

class UpdateProductHeightEvent extends UpdateProductEvent {
  final String height;

  const UpdateProductHeightEvent(this.height);

  @override
  List<Object> get props => [height];
}

class UpdateProductSubmittedEvent extends UpdateProductEvent {}
