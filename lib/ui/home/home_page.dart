import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql_test_task/logic/bloc/orders/orders_cubit.dart';
import 'package:sql_test_task/ui/home/tabs/create_order_tab.dart';
import 'package:sql_test_task/ui/home/tabs/orders_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              _selectedIndex = index;
              setState(() {});

              if (_selectedIndex == 1) {
                context.read<OrdersCubit>().loadOrders();
              }
            },
            iconSize: 20,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.add_circled),
                label: 'Новый заказ',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.list_number),
                label: 'Список заказов',
              ),
            ]),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: IndexedStack(
            index: _selectedIndex,
            children: const [CreateOrderTab(), OrdersTab()],
          ),
        ));
  }
}
