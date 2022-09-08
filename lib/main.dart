import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        //errorColor: Colors.red,
        textTheme: ThemeData.light().textTheme.copyWith(
          titleMedium: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
         // button: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            titleMedium: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              ),
              ),
              ),
      ),
      title: 'Personal Expenses',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

   final List<Transaction> _userTransactions = [
    //  Transaction(
    //   id: 't1',
    //   title: 'New Shoes', 
    //   amount: 69.99, 
    //   date: DateTime.now(),
    //   ),
    // Transaction(
    //   id: 't2', 
    //   title: 'Weekly grocery', 
    //   amount: 16.53, 
    //   date: DateTime.now(),
    //   ),
   ];
   bool _showChart = false;

   List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
   }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate,){
    final newTx = Transaction(
      id: DateTime.now().toString(), 
      title: txTitle, 
      amount: txAmount, 
      date: chosenDate,
      );

      setState(() {
        _userTransactions.add(newTx);
      });
  }
  // String? titleInput;
  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return GestureDetector(
        child: NewTransaction(_addNewTransaction),
        onTap: () {},
        behavior: HitTestBehavior.opaque,
        );
  });}

  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id ;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
        title: Text('Personal Expenses',style: TextStyle(fontFamily: 'Open Sans'),),
        actions: [
          IconButton(
            onPressed: ()=>_startAddNewTransaction(context), 
          icon: Icon(Icons.add),),
        ],
      );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart'),
                Switch(
                  value: _showChart, 
                onChanged: (value) {
                  setState(() {
                    _showChart = value;
                  });
                },
                ),
              ],
            ),
           _showChart ? Container(
              height: (MediaQuery.of(context).size.height - 
              appBar.preferredSize.height - 
              MediaQuery.of(context).padding.top)*
              0.7,
              child: Chart(_recentTransactions),
              ):
           Container(
            height: (MediaQuery.of(context).size.height - 
              appBar.preferredSize.height- 
              MediaQuery.of(context).padding.top)*
              0.7,
            child: TransactionList(_userTransactions,_deleteTransaction),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>_startAddNewTransaction(context),
        child: Icon(Icons.add),
        ),
    );
  }
}