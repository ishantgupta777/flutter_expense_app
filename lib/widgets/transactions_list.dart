import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:basic_utils/basic_utils.dart';

import '../models/Transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function handleDeleteTx;
  TransactionList(this.transactions, this.handleDeleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500,
      child: transactions.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'NO Transactios Added Yet',
                  style: Theme.of(context).textTheme.title,
                ),
                Container(
                  height: 250,
                  child: Image.asset(
                    'assets/image/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (cxt, index) {
                return Container(
                  child: Card(
                    elevation: 6,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Container(
                            width: 70,
                            height: 70,
                            padding: EdgeInsets.all(10),
                            child: FittedBox(
                              child: Text(
                                '\$${transactions[index].amount.toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          StringUtils.capitalize(transactions[index].title),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          DateFormat.yMMMd().format(transactions[index].date),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                            size: 30,
                          ),
                          onPressed: () =>
                              handleDeleteTx(transactions[index].id),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
