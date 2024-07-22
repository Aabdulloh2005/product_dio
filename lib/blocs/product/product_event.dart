part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

final class GetProductEvent extends ProductEvent {}

final class UpdateProductEvent extends ProductEvent {
  final Product product;

  UpdateProductEvent({required this.product});
}

final class DeleteProductEvent extends ProductEvent {
  final String id;

  DeleteProductEvent({required this.id});
}

final class AddProductEvent extends ProductEvent {
  final Product product;

  AddProductEvent({required this.product});
}
