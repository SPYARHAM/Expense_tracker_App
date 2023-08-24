import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String item;
  final double money;
  final DateTime time;

  Transaction(
      {required this.id,
      required this.item,
      required this.money,
      required this.time});

  static map(Text Function(dynamic tx) param0) {}
}
