import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:transaction_reminder/widgets/chart.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.greenAccent,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold
            ),
            button: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
              )
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(title: TextStyle(fontFamily: 'OpenSans',fontSize: 20,fontWeight: FontWeight.bold))
        )
      ),
      home: HomePage(),
      title: "Transaction App",
    );
  }
}


class HomePage extends StatefulWidget {
  // String titleInput;
  // String priceInput;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { 
   final List<Transaction> _userTransactions=[
    //  Transaction(id: "123",price: 67.25,title: "Paytm",date: DateTime.now()),
    // Transaction(id: "456",price: 87.25,title: "Phonepe",date: DateTime.now()),
  ];
  List<Transaction> get _recentTransaction{
    return _userTransactions.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewtransaction(String txTitle, double txPrice, DateTime chosenDate)
  {
    final newTx=Transaction(
      id: DateTime.now().toString(),
       price: txPrice, 
       title: txTitle, 
       date: chosenDate
       );
       setState(() {
         _userTransactions.add(newTx);
       });
  }
  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx)=> tx.id==id);
    });
  }

  void startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return GestureDetector(
        onTap: (){},
         child: NewTransaction(_addNewtransaction),
         behavior: HitTestBehavior.opaque,
      );
     
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction Reminder App"),
        backgroundColor: Colors.greenAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: ()=>startAddNewTransaction(context))
        ],
      ),
      body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Center(
            //   child: Container(
            //     width:double.infinity ,
            //     margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
            //     padding: EdgeInsets.all(10.0),
            //     decoration: BoxDecoration(
            //       color: Colors.grey,
            //       borderRadius: BorderRadius.circular(5.0),
            //       border: Border.all(width: 3.0,color: Colors.black),
            //     ),
            //     child: Text("Chart!",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 20.0),textAlign: TextAlign.center,),
            //   ),
            // ),
            Chart(_recentTransaction),
            TransactionList(_userTransactions,_deleteTransaction), 
          ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(onPressed: ()=>startAddNewTransaction(context),
      child: Icon(Icons.add),
      ),
    );
  }
}