part of 'create_order_cubit.dart';

abstract class CreateOrderState extends Equatable {
  const CreateOrderState();

  @override
  List<Object> get props => [];
}

class CreateOrderInitial extends CreateOrderState {}

class CreateOrderLoading extends CreateOrderState {}

class CreateOrderLoaded extends CreateOrderState {
  const CreateOrderLoaded(
      {required this.availableProducts, required this.productsInCart});

  final List<Product> availableProducts;
  final List<Product> productsInCart;

  @override
  List<Object> get props => [availableProducts, productsInCart];
}
