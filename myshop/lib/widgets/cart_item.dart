import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(
      {@required this.id,
      @required this.productId,
      @required this.price,
      @required this.quantity,
      @required this.title});

  void removeProduct(BuildContext ctx) {
    var cartProvider = Provider.of<CartsProvider>(ctx, listen: false);
    cartProvider.removeItem(productId);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: ValueKey(id),
        background: Container(
          color: Theme.of(context).errorColor,
          child: Icon(Icons.delete, color: Colors.white, size: 40),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => removeProduct(context),
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(child: Text('\$${this.price}')))),
              title: Text(this.title),
              subtitle: Text('Total: \$${this.price * this.quantity}'),
              trailing: Text('${this.quantity}'),
            ),
          ),
        ));
  }
}
