import 'package:flutter/material.dart';
import 'package:myshop/providers/order_provider.dart';
import 'package:myshop/widgets/app_drawer.dart';
import 'package:myshop/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders_screen';

  Widget build(BuildContext context) {
    final orders = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Orders')),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.orders.length,
        itemBuilder: (ctx, index) => OrderItem(orders.orders[index]),
      ),
    );
  }
}
