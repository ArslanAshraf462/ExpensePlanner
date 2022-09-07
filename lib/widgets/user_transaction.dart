import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({super.key});

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {

  final List<Transaction> _userTransactions = [
     Transaction(
      id: 't1',
      title: 'New Shoes', 
      amount: 69.99, 
      date: DateTime.now(),
      ),
    Transaction(
      id: 't2', 
      title: 'Weekly grocery', 
      amount: 16.53, 
      date: DateTime.now(),
      ),
  ];

  void _addNewTransaction(String txTitle, double txAmount){
    final newTx = Transaction(
      id: DateTime.now().toString(), 
      title: txTitle, 
      amount: txAmount, 
      date: DateTime.now(),
      );

      setState(() {
        _userTransactions.add(newTx);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}