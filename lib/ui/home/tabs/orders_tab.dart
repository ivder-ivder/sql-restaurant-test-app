import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql_test_task/logic/bloc/orders/orders_cubit.dart';
import 'package:sql_test_task/logic/models/order.dart';
import 'package:sql_test_task/ui/elements/order_card.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrdersCubit, OrdersState>(builder: (context, state) {
        if (state is OrdersLoaded) {
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              for (Order order in state.orders) OrderCard(order: order)
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
