import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql_test_task/logic/bloc/create_order/create_order_cubit.dart';
import 'package:sql_test_task/logic/bloc/orders/orders_cubit.dart';

class BlocAndProviderConfig extends StatelessWidget {
  const BlocAndProviderConfig({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CreateOrderCubit>(
          create: (_) => CreateOrderCubit(),
        ),
        BlocProvider<OrdersCubit>(
          create: (_) => OrdersCubit(),
        )
      ],
      child: child,
    );
  }
}
