import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 300.0,
      child: transactions.isEmpty ? Column(
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
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0,),
                        decoration: BoxDecoration(border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '\$${transactions[index].amount.toStringAsFixed(2)}',
                        style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                        ),
                        ),
                          ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(transactions[index].title,
                          style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            DateFormat.yMMMd().format(transactions[index].date),
                          style: TextStyle(
                            color: Colors.grey
                        ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
        }),
            ),
    );
  }
}