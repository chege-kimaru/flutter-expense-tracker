import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// make it stateful eventhough it does not set state so that the input
// fields do not clear once state changes eg if you click next text field
class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    String enteredTitle = _titleController.text;
    double enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    // widget is in the state class
    widget.addTransaction(enteredTitle, enteredAmount, _selectedDate);

    //close the top most screen in this case the bottom sheet
    // context isin the State class
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _selectedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _submitData(),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(_selectedDate == null
                            ? 'No Date Choosen'
                            : 'Selected Date: ${DateFormat.yMMMEd().format(_selectedDate)}'),
                      ),
                      FlatButton(
                        onPressed: _presentDatePicker,
                        textColor: Theme.of(context).primaryColor,
                        child: Text('Select Date',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
                RaisedButton(
                    onPressed: _submitData,
                    child: Text('Add Transaction'),
                    textColor: Theme.of(context).textTheme.button.color,
                    color: Theme.of(context).primaryColor),
              ],
            )));
  }
}
