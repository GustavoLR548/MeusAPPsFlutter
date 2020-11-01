import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });

  String getID() {
    return id;
  }

  String getTitle() {
    return title;
  }

  String getAmount() {
    return 'R\$${amount.toStringAsFixed(2)}';
  }

  double getValue() {
    return amount;
  }

  String getDate() {
    return DateFormat("yyyy/MM/dd -HH:mm").format(date);
  }

  DateTime getDateTime() {
    return date;
  }
}
