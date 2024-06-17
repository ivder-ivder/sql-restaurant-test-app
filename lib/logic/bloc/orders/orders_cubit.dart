import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql_test_task/logic/models/order.dart';
import 'package:sql_test_task/services/db_service.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial()) {
    loadOrders();
  }

  Future<void> loadOrders() async {
    emit(OrdersLoading());

    final List<Order>? orders = await DatabaseService.getAllOrders();

    emit(OrdersLoaded(orders: orders ?? []));
  }
}
