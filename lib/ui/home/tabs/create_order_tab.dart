import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql_test_task/logic/bloc/create_order/create_order_cubit.dart';
import 'package:sql_test_task/ui/elements/available_product_card.dart';
import 'package:sql_test_task/ui/elements/product_in_cart_card.dart';

class CreateOrderTab extends StatelessWidget {
  const CreateOrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CreateOrderCubit, CreateOrderState>(
          builder: (context, state) {
        final cubit = context.read<CreateOrderCubit>();
        if (state is CreateOrderLoaded) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(children: [
                          const Text('Заказ'),
                          const Spacer(),
                          GestureDetector(
                              onTap: () {
                                cubit.saveOrder();
                              },
                              child: const Icon(Icons.save_as_outlined))
                        ])),
                    Expanded(
                      child: ListView(
                        children: state.productsInCart
                            .map((p) => ProductInCartCard(
                                product: p,
                                onTapReduse: () {
                                  cubit.reduceProductInCart(p);
                                },
                                onTapIncrease: () {
                                  cubit.addProductToCard(p);
                                }))
                            .toList(),
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text('Склад')),
                    Expanded(
                        child: ListView(
                      children: state.availableProducts
                          .map((p) => AvailableProductCard(
                                product: p,
                                onTap: () {
                                  cubit.addProductToCard(p);
                                },
                              ))
                          .toList(),
                    )),
                  ]));
        }

        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
