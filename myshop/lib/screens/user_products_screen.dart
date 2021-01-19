import 'package:flutter/material.dart';
import 'package:myshop/providers/products_provider.dart';
import 'package:myshop/screens/edit_product_screen.dart';
import 'package:myshop/widgets/app_drawer.dart';
import 'package:myshop/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProducts extends StatelessWidget {
  static const routeName = '/user_products';

  Future<void> _refreshProducts(BuildContext ctx) async {
    await Provider.of<ProductsProvider>(ctx, listen: false)
        .fetchDataFromServer();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Products'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProduct.routeName);
                }),
          ],
        ),
        drawer: AppDrawer(),
        body: RefreshIndicator(
          onRefresh: () => _refreshProducts(context),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: productsData.items.length,
              itemBuilder: (ctx, index) => Column(children: <Widget>[
                UserProductItem(
                    productsData.items[index].id,
                    productsData.items[index].title,
                    productsData.items[index].imageUrl),
                Divider()
              ]),
            ),
          ),
        ));
  }
}
