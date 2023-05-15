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
    //   title: 'Gasolina',
    //   value: 75,
    //   valueRadio: 1,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   title: 'Gasolina',
    //   value: 50,
    //   valueRadio: 1,
    //   date: DateTime.now(),
    // ),
  ];
  List<Transaction> transactionBibi = [
    // Transaction(
    //   title: 'Unha',
    //   value: 35,
    //   valueRadio: 2,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   title: 'Unha',
    //   value: 35,
    //   valueRadio: 2,
    //   date: DateTime.now(),
    // ),
  ];

  _addTransaction(String title, double value, int valueRadio) {
    final newTransaction = Transaction(
      title: title,
      value: value,
      valueRadio: valueRadio,
      date: DateTime.now(),
    );

    setState(
      () {
        if (valueRadio == 1) {
          transactionKleyte.add(newTransaction);
        } else {
          transactionBibi.add(newTransaction);
        }
      },
    );
    Navigator.of(context).pop();
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
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Kleyte & Bibi'),
        ),
        actions: [
          IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TotalSum(transactionKleyte, transactionBibi),
            Row(
              children: [
                TransactionListKleyte(transactionKleyte),
                TransactionListBibi(transactionBibi),
              ],
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
