import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return widget.transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Text('No transactions added yet',
                      style: Theme.of(context).textTheme.title),
                  // use const so this widget is not reinstantiated during build
                  // only works if the widget data is not dynamic
                  const SizedBox(
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
        :
        // ListView.builder(
        //     itemBuilder: (context, index) {
        //   return TransactionItem(
        //       transaction: widget.transactions[index],
        //       deleteTransaction: widget.deleteTransaction);
        // },
        //     itemCount: widget.transactions.length,
        //   );
        // I have changed to ListView because apparently for some reason event the key
        // won't work in ListView Builder
        ListView(
            children: widget.transactions.map(
              (tx) {
                return TransactionItem(
                    key: ValueKey(tx.id),
                    transaction: tx,
                    deleteTransaction: widget.deleteTransaction);
              },
            ).toList(),
          );
  }
}
