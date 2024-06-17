import 'package:flutter/material.dart';
import 'package:sql_test_task/logic/models/order.dart';
import 'package:sql_test_task/logic/models/product.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});

  final Order order;
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(bottom: 8),
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(order.id.toString()),
                Text('Цена заказа: ${order.price}'),
                for (Product product in order.products)
                  Text('Блюдо: ${product.name}; '
                      'Количество: ${product.quantity}; '
                      'Цена: ${product.price * product.quantity}')
              ],
            )));
  }
}
