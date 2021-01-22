import 'package:flutter/material.dart';
import 'package:myshop/providers/auth_provider.dart';
import 'package:myshop/screens/auth_screen.dart';
import 'package:myshop/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import './providers/cart_provider.dart';
import './providers/order_provider.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/product_details_screen.dart';
import './screens/products_overview_screen.dart';
import './providers/products_provider.dart';
import './screens/edit_product_screen.dart';
import './screens/user_products_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
          create: (ctx) => ProductsProvider(),
          update: (ctx, authData, previousProductsProvider) =>
              ProductsProvider.loggedIn(authData.token, authData.userId),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartsProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
          create: (ctx) => OrdersProvider(),
          update: (ctx, authData, previousOrdersProvider) =>
              OrdersProvider.loggedIn(authData.token, authData.userId),
        )
      ],
      child: Consumer<AuthProvider>(builder: (ctx, authData, _) {
        return MaterialApp(
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
          home: authData.isAuth
              ? ProductsOverview()
              : FutureBuilder(
                  future: authData.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) {
                    return authResultSnapshot.connectionState ==
                            ConnectionState.waiting
                        ? SplashScreen()
                        : AuthScreen();
                  }),
          routes: {
            ProductDetails.routeName: (ctx) => ProductDetails(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProducts.routeName: (ctx) => UserProducts(),
            EditProduct.routeName: (ctx) => EditProduct(),
          },
        );
      }),
    );
  }
}
