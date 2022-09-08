import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions,this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty ? Column(
      children: [
        Text('No transactions added yet!',
        style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 10.0,),
        Container(
          height: 200.0,
          child: Image.asset('assets/images/waiting.png',fit: BoxFit.cover,),),
      ],
    ) 
    : ListView.builder(
      itemCount: transactions.length,
      itemBuilder: ((context, index) {
        return Card(
          elevation: 5.0,
          margin: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 5.0,
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30.0,
              child: Padding(
                padding: EdgeInsets.all(6.0),
                child: FittedBox(
                  child: Text('\$${transactions[index].amount}'),
                  ),
              ),
            ),
            title: Text('${transactions[index].title}',
            style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),
            trailing: IconButton(onPressed: () => deleteTransaction(transactions[index].id), 
            icon: Icon(Icons.delete),
            color: Theme.of(context).errorColor,
            ),
          ),
        );
      }),
          );
  }
}