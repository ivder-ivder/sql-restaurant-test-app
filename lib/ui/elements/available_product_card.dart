import 'package:flutter/material.dart';
import 'package:sql_test_task/logic/models/product.dart';

class AvailableProductCard extends StatelessWidget {
  const AvailableProductCard(
      {super.key, required this.product, required this.onTap});

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(bottom: 8),
        color: Colors.white,
        child: GestureDetector(
            onTap: onTap,
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(product.name),
                    Text('Лимит на складе: ${product.quantity}'),
                    Text('Цена: ${product.price}')
                  ],
                ))));
  }
}
