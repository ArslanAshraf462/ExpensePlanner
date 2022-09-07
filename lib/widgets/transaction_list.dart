import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return  Column(
            children: transactions.map((tx) {
              return Card(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0,),
                      decoration: BoxDecoration(border: Border.all(
                        color: Colors.purple,
                        width: 2,
                      ),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '\$${tx.amount}',
                      style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.purple,
                      ),
                      ),
                        ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tx.title,
                        style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 18,
                      ),
                        ),
                        Text(
                          DateFormat.yMMMd().format(tx.date),
                        style: TextStyle(
                          color: Colors.grey
                      ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          );
  }
}