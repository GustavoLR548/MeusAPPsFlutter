import 'package:flutter/material.dart';
import 'package:myshop/providers/order_provider.dart';
import 'package:myshop/widgets/app_drawer.dart';
import 'package:myshop/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders_screen';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<OrderProvider>(context, listen: false)
          .fetchFromServer();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    final orders = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Orders')),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: orders.orders.length,
              itemBuilder: (ctx, index) => OrderItem(orders.orders[index]),
            ),
    );
  }
}
