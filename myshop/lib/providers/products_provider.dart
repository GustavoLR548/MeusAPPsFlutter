import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myshop/models/http_exception.dart';
import '../models/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];

  //var _showFavoritesOnly = false;

  Future<void> fetchDataFromServer() async {
    print('fetchDataFromServer');
    const url =
        'https://projeto-teste-59c69-default-rtdb.firebaseio.com/products.json';

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) return;

      final List<Product> loadedProducts = [];
      extractedData.forEach((id, prodData) {
        loadedProducts.add(Product(
          id: id,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite: prodData['isFavorite'],
          imageUrl: prodData['imageUrl'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favorites {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> addProduct(Product p) async {
    const url =
        'https://projeto-teste-59c69-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': p.title,
            'description': p.description,
            'imageUrl': p.imageUrl,
            'price': p.price,
            'isFavorite': p.isFavorite,
          }));
      final id = json.decode(response.body)['name'];
      final newProduct = Product(
          title: p.title,
          description: p.description,
          imageUrl: p.imageUrl,
          price: p.price,
          id: id);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> toggleIsFavorite(String id) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final p = _items[prodIndex];
      p.toggleFavoriteStatus();

      final url =
          'https://projeto-teste-59c69-default-rtdb.firebaseio.com/products/$id.json';
      try {
        final response = await http.patch(url,
            body: json.encode({
              'isFavorite': p.isFavorite,
            }));
        if (response.statusCode >= 400) {
          throw HttpException('Erro ao favoritar');
        }
      } catch (exception) {
        p.toggleFavoriteStatus();
      }
      notifyListeners();
    }
  }

  Future<void> updateProduct(Product p, String id) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://projeto-teste-59c69-default-rtdb.firebaseio.com/products/$id.json';
      await http.patch(url,
          body: json.encode({
            'title': p.title,
            'description': p.description,
            'imageUrl': p.imageUrl,
            'price': p.price,
            'isFavorite': p.isFavorite,
          }));

      _items[prodIndex] = p;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://projeto-teste-59c69-default-rtdb.firebaseio.com/products/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];

    existingProduct = null;
    _items.removeAt(existingProductIndex);

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      throw HttpException('Could not delete product');
    }

    notifyListeners();
  }

  fetchFromServer() {}
}
