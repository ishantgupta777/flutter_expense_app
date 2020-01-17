import 'package:flutter/material.dart';

import './models/Transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transactions_list.dart';
import './widgets/chart.dart';

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Expense App',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          errorColor: Colors.red,
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontSize: 20,
                  fontFamily: 'OpenSans',
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
          )),
      home: ExpenseApp(),
    );
  }
}

class ExpenseApp extends StatefulWidget {
  @override
  _ExpenseAppState createState() => _ExpenseAppState();
}

class _ExpenseAppState extends State<ExpenseApp> {
  final List<Transaction> transactions = [
    Transaction(id: 'item1', amount: 50.66, date: DateTime.now(), title: 'car'),
    Transaction(
        id: 'item1', amount: 550, date: DateTime.now(), title: 'macbook pro'),
  ];

  void _addTransaction(String title, double amount, DateTime date) {
    Transaction newTx = Transaction(
      amount: amount,
      title: title,
      id: DateTime.now().toString(),
      date: date,
    );
    setState(() {
      transactions.add(newTx);
    });
  }

  void _handleDeleteTx(id) {
    print("geg");
    setState(() {
      transactions.removeWhere((tx) => id == tx.id);
    });
  }

  void presentModalForNewTx(BuildContext contxt) {
    showModalBottomSheet(
        context: contxt,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Transaction> get recentTransactions {
    return (transactions.where((tx) {
      return DateTime.now().difference(tx.date).inDays <= 7;
    }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => presentModalForNewTx(context),
      ),
      appBar: AppBar(
        title: Text('My expense app'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              presentModalForNewTx(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(recentTransactions),
            TransactionList(transactions, _handleDeleteTx),
          ],
        ),
      ),
    );
  }
}
