import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addTransactionHandler;

  NewTransaction(this.addTransactionHandler);

  void sumbitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    print('hey dude you click me');
    
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    addTransactionHandler(
      enteredTitle,
      enteredAmount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => sumbitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => sumbitData(),
            ),
            TextButton(
              onPressed: sumbitData,
              child: Text('Add Transaction'),
              style: TextButton.styleFrom(
                primary: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
