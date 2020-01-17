import 'package:flutter/foundation.dart';

class Transaction {
  String id;
  double amount;
  String title;
  DateTime date;
  Transaction(
      {@required this.amount,
      @required this.title,
      @required this.id,
      @required this.date});
}
