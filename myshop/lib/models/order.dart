import 'package:myshop/models/cart.dart';

class Order {
  final String id;
  final double amount;
  final List<Cart> products;
  final DateTime dateTime;

  Order({this.id, this.amount, this.products, this.dateTime});
}
