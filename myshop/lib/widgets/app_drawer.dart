import 'package:flutter/material.dart';
import 'package:myshop/screens/orders_screen.dart';
import 'package:myshop/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  List<Widget> buildDividedListTile(
      BuildContext context, IconData icon, String text, String routeName) {
    return [
      Divider(),
      ListTile(
        leading: Icon(icon),
        title: Text(text),
        onTap: () {
          Navigator.of(context).pushReplacementNamed(routeName);
        },
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        AppBar(
          title: Text('Select a menu'),
          automaticallyImplyLeading: false,
        ),
        ...buildDividedListTile(context, Icons.shop, 'Shop', '/'),
        ...buildDividedListTile(
            context, Icons.payment, 'Orders', OrdersScreen.routeName),
        ...buildDividedListTile(
            context, Icons.edit, 'Manage my products', UserProducts.routeName),
      ],
    ));
  }
}
