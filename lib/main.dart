import 'package:expense_tracker_app/new_transaction.dart';
import 'package:flutter/material.dart';
import './transaction.dart';
import './transactionList.dart';
import './chart.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: '1',
    //   item: 'shirt',
    //   money: 99.12,
    //   time: DateTime.now(),
    // ),
    // Transaction(
    //   id: '2',
    //   item: 'pants',
    //   money: 34,
    //   time: DateTime.now(),
    // ),
    // Transaction(
    //   id: '3',
    //   item: 'jeans',
    //   money: 94.2,
    //   time: DateTime.now(),
    // ),
    // Transaction(
    //   id: '3',
    //   item: 'Groceries',
    //   money: 154.2,
    //   time: DateTime.now(),
    // )
  ];
  List<Transaction> get _recentTransactions {
    // get is dynamically calculated property
    return _userTransaction.where((tx) {
      return tx.time.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList(); //where allows to run function o everyitem on list and if returned true then it is kept in list  otherwise it will not kept
  }

  // static const _cardColor = Colors.amber; // define the color as a constant

  bool _showInputField = false;

  void _addTransaction(String item, double amount, DateTime chosenDate) {
    final tx = Transaction(
        id: DateTime.now().toString(),
        item: item,
        money: amount,
        time: chosenDate);
    setState(() {
      _userTransaction.add(tx);
      _showInputField = false;
    });
  }

  void _startAddNewTransaction() {
    setState(() {
      _showInputField = true;
    });
  }

  void _deleteTransaction(String id) {
    setState(
      () {
        _userTransaction.removeWhere((tx) {
          return tx.id == id;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: ' OpenSans',
          textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.normal)),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.amber)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Title",
            style: TextStyle(fontFamily: 'OpenSans'),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: _startAddNewTransaction,
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              Chart(_recentTransactions),
              if (_showInputField)
                NewTransaction(
                    context: context, addTransaction: _addTransaction),
              TransactionList(_userTransaction, _deleteTransaction),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _startAddNewTransaction,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
