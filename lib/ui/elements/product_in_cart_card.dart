import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sql_test_task/logic/models/product.dart';

class ProductInCartCard extends StatelessWidget {
  const ProductInCartCard(
      {super.key,
      required this.product,
      required this.onTapReduse,
      required this.onTapIncrease});

  final Product product;
  final VoidCallback onTapIncrease;
  final VoidCallback onTapReduse;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(bottom: 8),
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(product.name),
                  Text('Цена: ${product.price * product.quantity}')
                ],
              )),
              GestureDetector(
                onTap: onTapReduse,
                child: const Icon(CupertinoIcons.minus_circle),
              ),
              Text(product.quantity.toString()),
              GestureDetector(
                onTap: onTapIncrease,
                child: const Icon(CupertinoIcons.add_circled),
              ),
            ])));
  }
}
