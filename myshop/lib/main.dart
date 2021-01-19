import 'package:flutter/material.dart';
import 'package:myshop/screens/edit_product_screen.dart';
import 'package:myshop/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

import './providers/cart_provider.dart';
import './providers/order_provider.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/product_details_screen.dart';
import './screens/products_overview_screen.dart';
import './providers/products_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrderProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.deepOrange,
          canvasColor: Colors.purple[50],
          fontFamily: 'Lato',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline1: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
        ),
        initialRoute: '/',
        routes: {
          ProductsOverview.routeName: (ctx) => ProductsOverview(),
          ProductDetails.routeName: (ctx) => ProductDetails(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProducts.routeName: (ctx) => UserProducts(),
          EditProduct.routeName: (ctx) => EditProduct(),
        },
      ),
    );
  }
}
