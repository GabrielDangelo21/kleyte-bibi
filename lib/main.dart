import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kleyte_bibi/components/total_sum.dart';
import 'package:kleyte_bibi/components/transaction_list_bibi.dart';
import 'components/transaction_form.dart';
import 'components/transaction_list_kleyte.dart';
import 'models/transaction.dart';

main() => runApp(Expenses());

class Expenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
            .copyWith(secondary: Colors.amber),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  _addTransaction(String title, double value, int valueRadio, DateTime date) {
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
          for (int i = 0; i < transactionKleyte.length; i++) {
            print(transactionKleyte[i].id);
          }
        } else {
          transactionBibi.add(newTransaction);
          for (int i = 0; i < transactionBibi.length; i++) {
            print(transactionBibi[i].id);
          }
        }
      },
    );
    Navigator.of(context).pop();
  }

  _removeTransactionKleyte(String id) {
    setState(() {
      transactionKleyte.removeWhere((tr) => tr.id == id);
    });
  }

  _removeTransactionBibi(String id) {
    setState(() {
      transactionBibi.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
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
                    _removeTransactionKleyte,
                  ),
                  TransactionListBibi(
                    transactionBibi,
                    _removeTransactionBibi,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
