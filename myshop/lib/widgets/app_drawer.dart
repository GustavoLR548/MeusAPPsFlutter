import 'package:flutter/material.dart';
import 'package:myshop/providers/auth_provider.dart';
import 'package:myshop/screens/orders_screen.dart';
import 'package:myshop/screens/products_overview_screen.dart';
import 'package:myshop/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  List<Widget> buildDividedListTile(
      BuildContext context, IconData icon, String text, Function f) {
    return [
      Divider(),
      ListTile(leading: Icon(icon), title: Text(text), onTap: f)
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
        ...buildDividedListTile(
          context,
          Icons.shop,
          'Shop',
          () {
            Navigator.of(context)
                .pushReplacementNamed(ProductsOverview.routeName);
          },
        ),
        ...buildDividedListTile(
          context,
          Icons.payment,
          'Orders',
          () {
            Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
          },
        ),
        ...buildDividedListTile(context, Icons.edit, 'Manage my products', () {
          Navigator.of(context).pushReplacementNamed(UserProducts.routeName);
        }),
        Divider(),
        ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushReplacementNamed(ProductsOverview.routeName);
              Provider.of<AuthProvider>(context, listen: false).logout();
            })
      ],
    ));
  }
}
