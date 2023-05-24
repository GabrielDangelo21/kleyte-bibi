import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kleyte_bibi/colors.dart';
import 'components/total_sum.dart';
// import 'components/transaction_list.dart';
import 'components/transaction_list_bibi.dart';
import 'components/transaction_form.dart';
import 'components/transaction_list_kleyte.dart';
import 'models/transaction.dart';

main() => runApp(Expenses());

class Expenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primary)
            .copyWith(secondary: primary),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List<Transaction> transactionList = [];
  List<Transaction> transactionKleyte = [
    // Transaction(
    //   id: Random().nextDouble().toString(),
    //   title: 'Gasolina',
    //   value: 50,
    //   valueRadio: 1,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: Random().nextDouble().toString(),
    //   title: 'Gasolina',
    //   value: 50,
    //   valueRadio: 1,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: Random().nextDouble().toString(),
    //   title: 'Gasolina',
    //   value: 50,
    //   valueRadio: 1,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: Random().nextDouble().toString(),
    //   title: 'Gasolina',
    //   value: 50,
    //   valueRadio: 1,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: Random().nextDouble().toString(),
    //   title: 'Gasolina',
    //   value: 50,
    //   valueRadio: 1,
    //   date: DateTime.now(),
    // ),
  ];
  List<Transaction> transactionBibi = [
    // Transaction(
    //   id: Random().nextDouble().toString(),
    //   title: 'Gasolina',
    //   value: 50,
    //   valueRadio: 2,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: Random().nextDouble().toString(),
    //   title: 'Gasolina',
    //   value: 50,
    //   valueRadio: 2,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: Random().nextDouble().toString(),
    //   title: 'Gasolina',
    //   value: 50,
    //   valueRadio: 2,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: Random().nextDouble().toString(),
    //   title: 'Gasolina',
    //   value: 50,
    //   valueRadio: 2,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: Random().nextDouble().toString(),
    //   title: 'Gasolina',
    //   value: 50,
    //   valueRadio: 2,
    //   date: DateTime.now(),
    // ),
  ];

  addTransaction(String title, double value, int valueRadio, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      valueRadio: valueRadio,
      date: date,
    );

    setState(
      () {
        if (valueRadio == 1) {
          transactionKleyte.add(newTransaction);
          // transactionList.add(newTransaction);
        } else {
          transactionBibi.add(newTransaction);
          // transactionList.add(newTransaction);
        }
      },
    );
    Navigator.of(context).pop();
  }

  removeTransactionKleyte(String id) {
    setState(() {
      transactionKleyte.removeWhere((tr) => tr.id == id);
    });
  }

  removeTransactionBibi(String id) {
    setState(() {
      transactionBibi.removeWhere((tr) => tr.id == id);
    });
  }

  openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Center(
        child: Text('Kleyte & Bibi'),
      ),
    );
    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: availableHeight * 0.07,
              child: TotalSum(transactionKleyte, transactionBibi),
            ),
            // TransactionList(transactionList),
            Container(
              height: availableHeight * 0.07,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Kleyte'),
                  Text('Bibi'),
                ],
              ),
            ),
            Container(
              height: availableHeight * 0.86,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TransactionListKleyte(
                    transactionKleyte,
                    removeTransactionKleyte,
                  ),
                  TransactionListBibi(
                    transactionBibi,
                    removeTransactionBibi,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openTransactionFormModal(context),
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
