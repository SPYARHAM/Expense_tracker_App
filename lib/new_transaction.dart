import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function(String, double, DateTime) addTransaction;
  final BuildContext context;

  NewTransaction({
    Key? key,
    required this.context,
    required this.addTransaction,
  }) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _itemInput = TextEditingController();

  final _amountInput = TextEditingController();
  DateTime? _selectDate;

  void _eventHandler() {
    final enteredInput = _itemInput.text;
    final enteredAmount = double.tryParse(_amountInput.text) ?? 0.0;
    if (enteredInput.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addTransaction(enteredInput, enteredAmount, _selectDate!);
    _itemInput.clear();
    _amountInput.clear();
    setState(() {
      _selectDate = null;
    });
  }

  void _datePicker() {
    showDatePicker(
      context: widget.context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: "Item"),
              controller: _itemInput,
              onSubmitted: (_) => _eventHandler(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Amount"),
              controller: _amountInput,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _eventHandler(),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  // ignore: unnecessary_null_comparison
                  Expanded(
                    child: Text(_selectDate == null
                        ? "No Date Choosen"
                        : "Picked Date: ${DateFormat.yMd().format(_selectDate!)}"),
                  ),
                  TextButton(
                    onPressed: _datePicker,
                    child: const Text(
                      "Choose Date",
                      style: TextStyle(
                          color: Colors.purple, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _eventHandler,
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.amber)),
              child: const Text(
                "Add Transaction",
                style: TextStyle(color: Colors.purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
