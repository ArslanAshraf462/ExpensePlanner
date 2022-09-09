import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions,this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty ? 
    LayoutBuilder(
      builder: (context,Constraints) {
        return Column(
          children: [
            Text('No transactions added yet!',
            style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 10.0,),
            Container(
              height: Constraints.maxHeight*0.5,
              child: Image.asset('assets/images/waiting.png',fit: BoxFit.cover,),
              ),
          ],
        );
      }
    ) 
    : ListView.builder(
      itemCount: transactions.length,
      itemBuilder: ((context, index) {
        return TransactionItem(transaction: transactions[index], deleteTransaction: deleteTransaction);
      }),
          );
  }
}