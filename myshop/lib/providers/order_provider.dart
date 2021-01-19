import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myshop/models/cart.dart';
import 'package:myshop/models/order.dart';
import 'package:http/http.dart' as http;

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> fetchFromServer() async {
    const url =
        'https://projeto-teste-59c69-default-rtdb.firebaseio.com/orders.json';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) return;

    final List<Order> loadedOrders = [];
    extractedData.forEach((id, orderData) {
      loadedOrders.add(Order(
          id: id,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map((item) => Cart(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title']))
              .toList()));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<Cart> cartProducts, double total) async {
    const url =
        'https://projeto-teste-59c69-default-rtdb.firebaseio.com/orders.json';

    final timeStamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList()
        }));
    _orders.insert(
        0,
        Order(
            id: json.decode(response.body)['name'],
            amount: total,
            dateTime: timeStamp,
            products: cartProducts));
    notifyListeners();
  }
}
