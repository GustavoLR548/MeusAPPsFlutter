import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  bool isFavorite;
  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  void toggleFavoriteStatus() {
    if (this.isFavorite == null) this.isFavorite = true;

    isFavorite = !isFavorite;
    notifyListeners();
  }

  bool get favorite {
    if (this.isFavorite == null)
      return false;
    else
      return this.isFavorite;
  }
}
