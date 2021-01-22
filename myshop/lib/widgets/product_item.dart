import 'package:flutter/material.dart';
import '../models/product.dart';
import '../providers/products_provider.dart';
import '../providers/cart_provider.dart';
import '../screens/product_details_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  //final String id;
  //final String title;
  // final String imageUrl;

  //ProductItem({@required this.id, @required this.title, @required this.imageUrl});

  void _goToProductDetails(BuildContext context, String id) {
    Navigator.of(context).pushNamed(ProductDetails.routeName, arguments: id);
  }

  Widget buildIcon(BuildContext ctx, IconData icon, Function f) {
    return IconButton(
        icon: Icon(icon), onPressed: f, color: Theme.of(ctx).accentColor);
  }

  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final carts = Provider.of<CartsProvider>(context, listen: false);

    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
              onTap: () => _goToProductDetails(context, product.id),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              )),
          footer: GridTileBar(
            leading: buildIcon(context,
                product.favorite ? Icons.favorite : Icons.favorite_border, () {
              Provider.of<ProductsProvider>(context, listen: false)
                  .toggleIsFavorite(product.id);
            }),
            backgroundColor: Colors.black87,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: buildIcon(context, Icons.shopping_cart, () {
              carts.addItem(product.id, product.price, product.title);
              showDialog(
                  context: context,
                  builder: (ctx) => SimpleDialog(
                        title: Text('Product added!'),
                        children: <Widget>[
                          SimpleDialogOption(
                            child: Text(
                                'The product ${product.title} has been added to your cart'),
                          )
                        ],
                      ));
            }),
          ),
        ));
  }
}
