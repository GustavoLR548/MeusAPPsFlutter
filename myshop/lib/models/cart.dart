import 'package:flutter/material.dart';

class Cart {
  final String id;
  final String title;
  final int quantity;
  final double price;

  Cart(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}
