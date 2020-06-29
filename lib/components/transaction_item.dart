import 'package:flutter_masked_text/flutter_masked_text.dart';

import '../models/tansaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final void Function(String) onDelete;

  const TransactionItem({Key key, this.transaction, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MoneyMaskedTextController mask = MoneyMaskedTextController(
        initialValue: transaction.amount,
        decimalSeparator: ',',
        thousandSeparator: '.');

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).accentColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
                mask.text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? FlatButton.icon(
                onPressed: () => onDelete(transaction.id),
                icon: Icon(Icons.delete_outline),
                label: Text('Excluir'),
                textColor: Colors.redAccent[200],
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Colors.redAccent[200],
                onPressed: () => onDelete(transaction.id),
              ),
      ),
    );
  }
}
