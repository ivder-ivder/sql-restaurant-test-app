import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql_test_task/logic/models/order.dart';
import 'package:sql_test_task/logic/models/product.dart';
import 'package:sql_test_task/services/db_service.dart';

part 'create_order_state.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  CreateOrderCubit() : super(CreateOrderInitial()) {
    loadAvailableProducts();
  }

  Future<void> loadAvailableProducts() async {
    emit(CreateOrderLoading());

    final List<Product>? availableProducts =
        await DatabaseService.getAllProducts();

    emit(CreateOrderLoaded(
        availableProducts: availableProducts ?? [], productsInCart: const []));
  }

  Future<void> addProductToCard(Product product) async {
    final curState = state as CreateOrderLoaded;
    final curCart = [...curState.productsInCart];

    emit(CreateOrderLoading());

    if (!curCart.contains(product)) {
      curCart.add(product.copyWith(quantity: 1));
    } else {
      curCart[curCart.indexOf(product)] = product.copyWith(
          quantity: curCart[curCart.indexOf(product)].quantity + 1);
    }

    emit(CreateOrderLoaded(
        availableProducts: curState.availableProducts,
        productsInCart: curCart));
  }

  Future<void> reduceProductInCart(Product product) async {
    final curState = state as CreateOrderLoaded;
    final curCart = [...curState.productsInCart];

    emit(CreateOrderLoading());

    if (curCart.contains(product)) {
      final index = curCart.indexOf(product);
      final quantity = curCart[index].quantity - 1;
      if (quantity <= 0) {
        curCart.removeAt(index);
      } else {
        curCart[index] = product.copyWith(quantity: quantity);
      }
    }
    emit(CreateOrderLoaded(
        availableProducts: curState.availableProducts,
        productsInCart: curCart));
  }

  Future<void> saveOrder() async {
    final curState = state as CreateOrderLoaded;
    final curCart = [...curState.productsInCart];

    if (curCart.isEmpty) {
      return;
    }

    emit(CreateOrderLoading());
    await DatabaseService.addOrder(
        Order(id: DateTime.now().microsecondsSinceEpoch, products: curCart));
    emit(CreateOrderLoaded(
        availableProducts: curState.availableProducts,
        productsInCart: const []));
  }
}
