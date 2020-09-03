import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Text('No transactions added yet',
                      style: Theme.of(context).textTheme.title),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              // return Card(
              //     child: Row(
              //   children: [
              //     Container(
              //       margin:
              //           EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              //       padding: EdgeInsets.all(10),
              //       decoration: BoxDecoration(
              //           border: Border.all(
              //         color: Theme.of(context).primaryColor,
              //         width: 2,
              //       )),
              // child: Text(
              //     '\$${transactions[index].amount.toStringAsFixed(2)}',
              //     style: TextStyle(
              //       fontSize: 20,
              //       fontWeight: FontWeight.bold,
              //       color: Theme.of(context).primaryColor,
              //     )),
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              // Text(
              //   transactions[index].title,
              //   style: Theme.of(context).textTheme.title,
              // ),
              // Text(
              //     DateFormat.yMMMd().format(transactions[index].date),
              //     style: TextStyle(color: Colors.grey))
              //       ],
              //     ),
              //   ],
              // ));
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  // CircleAvatar is equivalent of a container with
                  // height: eg 60, width: 60,
                  // decoration: BoxDecoration(shape: BoxShape.circle, color:...)
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text(
                              '\$${transactions[index].amount.toStringAsFixed(2)}')),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? FlatButton.icon(
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          textColor: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () =>
                              deleteTransaction(transactions[index].id)),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
