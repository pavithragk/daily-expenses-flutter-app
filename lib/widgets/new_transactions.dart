import 'dart:io';

import 'package:assignment2/widgets/adaptive_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final addTitle = _titleController.text;
    final addAmount = double.parse(_amountController.text);
    if (_amountController.text.isEmpty) {
      return;
    }

    if (addTitle.isEmpty || addAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(addTitle, addAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'title'),
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _submitData(),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(_selectedDate == null
                            ? 'no date choosen'
                            : 'Picked Date: '
                                '${DateFormat.yMd().format(_selectedDate)}'),
                      ),
                      AdaptiveButton('choose date', _presentDatePicker)
                    ],
                  ),
                ),
                RaisedButton(
                    onPressed: _submitData,
                    child: Text(
                      'Add transaction',
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button.color)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
