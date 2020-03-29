import 'package:flutter/material.dart';

class MoneyDialog extends StatelessWidget {
  final from;
  final to;

  MoneyDialog({this.from, this.to});

  @override 
  Widget build (BuildContext context) {
    return AlertDialog(
      content: TextField(
        keyboardType: TextInputType.number,
        autofocus: true,
        onSubmitted: (val) {
          var amt = int.parse(val);
          from(-amt);
          to(amt);
          Navigator.of(context).pop();
        },
        decoration: InputDecoration(
          hintText: 'Amount to transfer'
        )
      )
    );
  }
}