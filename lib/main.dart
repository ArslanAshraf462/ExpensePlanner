import 'dart:io';

import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';

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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {

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

   @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
   @override
   void didChangeAppLifecycleState(AppLifecycleState state){
    print(state);
   }

   @override
   dispose(){
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
   }

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
  List<Widget> _buildLandscapeContent(
    MediaQueryData mediaQuery, 
    PreferredSizeWidget appBar,
    Widget txListWidget){
    return  [Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart',
                  style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Switch.adaptive(
                    activeColor: Theme.of(context).accentColor,
                    value: _showChart, 
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
                  ),
                ],
              ),_showChart ? Container(
                height: (mediaQuery.size.height - 
                appBar.preferredSize.height - 
                mediaQuery.padding.top)*
                0.7,
                child: Chart(_recentTransactions),
                ):
                       txListWidget,];
  }
  List<Widget> _buildPortraitContent(MediaQueryData mediaQuery,
   PreferredSizeWidget appBar,
   Widget txListWidget){
    return [Container(
                height: (mediaQuery.size.height - 
                appBar.preferredSize.height - 
                mediaQuery.padding.top)*
                0.3,
                child: Chart(_recentTransactions),
                ),txListWidget];
  }
  
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS 
    ? CupertinoNavigationBar(
      middle: Text('Personal Expenses',
        style: TextStyle(fontFamily: 'Open Sans'),),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              child: Icon(CupertinoIcons.add),
              onTap: ()=>_startAddNewTransaction(context),
            ),
          ],
        ),
    ) 
    : AppBar(
        title: Text('Personal Expenses',
        style: TextStyle(fontFamily: 'Open Sans'),),
        actions: [
          IconButton(
            onPressed: ()=>_startAddNewTransaction(context), 
          icon: Icon(Icons.add),),
        ],
      ) as PreferredSizeWidget;
      final txListWidget = Container(
            height: (mediaQuery.size.height - 
              appBar.preferredSize.height- 
              mediaQuery.padding.top)*
              0.7,
            child: TransactionList(_userTransactions,_deleteTransaction),
            );
            final pageBody = SafeArea(
              child: SingleChildScrollView(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                       if(isLandscape) ..._buildLandscapeContent(
                        mediaQuery,
                appBar,
                txListWidget),
              if(!isLandscape) ..._buildPortraitContent(
                mediaQuery,
                appBar,
                txListWidget),
                      ],
                    ),
                  ),
            );
    return Platform.isIOS 
    ? CupertinoPageScaffold(child: pageBody,)
    : Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS ? Container() 
      :FloatingActionButton(
        onPressed: ()=>_startAddNewTransaction(context),
        child: Icon(Icons.add),
        ),
    );
  }
}