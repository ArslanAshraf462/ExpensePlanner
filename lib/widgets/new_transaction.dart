import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
    final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime? _selectedDate;

  void _submitData(){
    if(_amountController == null)
    {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if(enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate==null)
    {
      return;
    }
    widget.addTx(
      _titleController.text,
      double.parse(_amountController.text),
      _selectedDate,
      );
    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2019), 
      lastDate: DateTime.now(),
      ).then((pickedDate) {
        if(pickedDate == null)
        {
          return;
        }
        setState(() {
          _selectedDate=pickedDate;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Card(
              elevation: 5.0,
              child: Container(
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  top: 10.0,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: _titleController,
                      onSubmitted: (_) => _submitData(),
                      // onChanged: (value) {
                      //   titleInput = value;
                      // },
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Amount',
                      ),
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      onSubmitted: (_) => _submitData(),
                      // onChanged: (value) {
                      //   amountInput = value;
                      // },
                    ),
                    Container(
                      height: 50.0,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(_selectedDate==null 
                            ? 'No Date Choosen' 
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}'),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                            ),
                            onPressed: _presentDatePicker, 
                            child: Text('Choose Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            ),),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _submitData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        ), 
                    child: Text('Add Transaction'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}