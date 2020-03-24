import 'package:flutter/foundation.dart';

class Transaction{
  final String id;
  final String title;
  final double price;
  DateTime date;
  Transaction({
    @required this.id,
    @required this.price,
    @required this.title,
    @required this.date
  });
}