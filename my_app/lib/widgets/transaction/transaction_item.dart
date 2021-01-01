import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.purple,
      Colors.blue
    ];

    _bgColor = availableColors[Random().nextInt(availableColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: _bgColor,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: FittedBox(child: Text(widget.transaction.getAmount())),
              ),
            ),
            title: Text(widget.transaction.getTitle(),
                style: Theme.of(context).textTheme.headline6),
            subtitle: Text(widget.transaction.getDate()),
            trailing: MediaQuery.of(context).size.width > 400
                ? FlatButton.icon(
                    label: Text('Deletar'),
                    icon: Icon(Icons.delete),
                    textColor: Theme.of(context).errorColor,
                    onPressed: () =>
                        widget.deleteTransaction(widget.transaction.getID()),
                  )
                : IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () =>
                        widget.deleteTransaction(widget.transaction.getID()),
                  )));
  }
}
