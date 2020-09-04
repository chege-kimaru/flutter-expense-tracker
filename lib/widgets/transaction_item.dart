import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

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
  List<Color> colors = [Colors.red, Colors.amber, Colors.green];

  @override
  void initState() {
    // TODO: implement initState
    _bgColor = colors[Random().nextInt(colors.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
                child:
                    Text('\$${widget.transaction.amount.toStringAsFixed(2)}')),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? FlatButton.icon(
                onPressed: () =>
                    widget.deleteTransaction(widget.transaction.id),
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                textColor: Theme.of(context).errorColor,
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () =>
                    widget.deleteTransaction(widget.transaction.id)),
      ),
    );
  }
}
