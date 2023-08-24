import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transaction.dart';

class TransactionList extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final List<Transaction> Transactions;
  final Function removeTransaction;
  const TransactionList(this.Transactions, this.removeTransaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Transactions.isEmpty
          ? Column(
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                const Text("No Transaction Involved"),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 500,
                  child: Image.asset(
                    'assets/image/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 35,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text(
                          '\$${Transactions[index].money}',
                        )),
                      ),
                    ),
                    title: Text(
                      Transactions[index].item,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(Transactions[index].time),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () =>
                          removeTransaction(Transactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: Transactions.length,
            ),
    );
  }

  static map(Card Function(dynamic tx) param0) {}
}
