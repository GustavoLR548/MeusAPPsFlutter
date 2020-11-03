import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'widgets/transaction/new_transaction.dart';
import 'widgets/transaction/transaction_list.dart';
import 'widgets/chart/chart.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gastos Pessoais',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  button: TextStyle(color: Colors.white),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx
          .getDateTime()
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime dt) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: dt,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool ehIOS = Platform.isIOS;

    final deviceSettings = MediaQuery.of(context);

    final deviceOrientation = deviceSettings.orientation;

    final PreferredSizeWidget appBar = ehIOS
        ? AppBar(
            title: Text(
              'Gastos Pessoais',
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          )
        : CupertinoNavigationBar(
            middle: Text('Gastos Pessoais'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                    child: Icon(CupertinoIcons.add),
                    onTap: () => _startAddNewTransaction(context)),
              ],
            ),
          );

    final listOfTransactions = Container(
        height: (deviceSettings.size.height -
                deviceSettings.padding.top -
                appBar.preferredSize.height) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));

    final listOfTransactionsBar = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (deviceOrientation == Orientation.landscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(_showChart ? 'Graficos' : 'Transações',
                    style: Theme.of(context).textTheme.headline6),
                Switch.adaptive(
                  activeColor: Theme.of(context).accentColor,
                  value: _showChart,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
                ),
              ],
            ),
          if (deviceOrientation == Orientation.landscape)
            _showChart
                ? Container(
                    height: (deviceSettings.size.height -
                            deviceSettings.padding.top -
                            appBar.preferredSize.height) *
                        0.7,
                    child: Chart(_recentTransactions))
                : listOfTransactions
          else
            Container(
                height: (deviceSettings.size.height -
                        deviceSettings.padding.top -
                        appBar.preferredSize.height) *
                    0.3,
                child: Chart(_recentTransactions)),
        ],
      ),
    ));

    return ehIOS
        ? Scaffold(
            appBar: appBar,
            body: listOfTransactionsBar,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: ehIOS
                ? FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  )
                : Container())
        : CupertinoPageScaffold(
            child: listOfTransactionsBar,
            navigationBar: appBar,
          );
  }
}
