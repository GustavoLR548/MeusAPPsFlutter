import 'package:flutter/material.dart';
import 'package:myshop/providers/products_provider.dart';
import 'package:myshop/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProduct.routeName, arguments: this.id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  await Provider.of<ProductsProvider>(context, listen: false)
                      .deleteProduct(this.id);
                } catch (exception) {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: Text('Ops'),
                          content: Text('Não foi possível deletar produto'),
                        );
                      });
                }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
