import 'package:flutter/material.dart';

import '../../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Container(
                child: Column(
              children: <Widget>[
                Text(
                  'Nenhuma transição adicionada!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            ));
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                              child: Text(transactions[index].getAmount())),
                        ),
                      ),
                      title: Text(transactions[index].getTitle(),
                          style: Theme.of(context).textTheme.headline6),
                      subtitle: Text(transactions[index].getDate()),
                      trailing: MediaQuery.of(context).size.width > 400
                          ? FlatButton.icon(
                              label: Text('Deletar'),
                              icon: Icon(Icons.delete),
                              textColor: Theme.of(context).errorColor,
                              onPressed: () => deleteTransaction(
                                  transactions[index].getID()),
                            )
                          : IconButton(
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                              onPressed: () => deleteTransaction(
                                  transactions[index].getID()),
                            )));
            });
  }
}
