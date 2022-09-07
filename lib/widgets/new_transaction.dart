import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;
  NewTransaction(this.addTx);
    final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Card(
            elevation: 5.0,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                    controller: titleController,
                    // onChanged: (value) {
                    //   titleInput = value;
                    // },
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Amount',
                    ),
                    controller: amountController,
                    // onChanged: (value) {
                    //   amountInput = value;
                    // },
                  ),
                  TextButton(
                    onPressed: (){
                      addTx(titleController.text,double.parse(amountController.text));
                    },
                    style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.purple)), 
                  child: Text('Add Transaction'),
                  ),
                ],
              ),
            ),
          );
  }
}