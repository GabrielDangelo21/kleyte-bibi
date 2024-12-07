import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/total_sum.dart';
import 'components/transaction_list_bibi.dart';
import 'components/transaction_form.dart';
import 'components/transaction_list_kleyte.dart';
import 'models/transaction.dart';

void main() {
  runApp(const Expenses());
}

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.blueAccent),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> transactionKleyte = [];
  List<Transaction> transactionBibi = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _saveTransactions() async {
    final prefs = await SharedPreferences.getInstance();

    // Serializar as listas em JSON
    final kleyteData = transactionKleyte
        .map((tr) => {
              'id': tr.id,
              'title': tr.title,
              'value': tr.value,
              'valueRadio': tr.valueRadio,
              'date': tr.date.toIso8601String(),
            })
        .toList();

    final bibiData = transactionBibi
        .map((tr) => {
              'id': tr.id,
              'title': tr.title,
              'value': tr.value,
              'valueRadio': tr.valueRadio,
              'date': tr.date.toIso8601String(),
            })
        .toList();

    // Salvar como strings JSON no SharedPreferences
    await prefs.setString('transactionKleyte', jsonEncode(kleyteData));
    await prefs.setString('transactionBibi', jsonEncode(bibiData));
  }

  Future<void> _loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();

    // Carregar e desserializar os dados
    final kleyteData = prefs.getString('transactionKleyte');
    final bibiData = prefs.getString('transactionBibi');

    if (kleyteData != null) {
      final decodedKleyte = jsonDecode(kleyteData) as List;
      transactionKleyte = decodedKleyte
          .map((tr) => Transaction(
                id: tr['id'],
                title: tr['title'],
                value: tr['value'],
                valueRadio: tr['valueRadio'],
                date: DateTime.parse(tr['date']),
              ))
          .toList();
    }

    if (bibiData != null) {
      final decodedBibi = jsonDecode(bibiData) as List;
      transactionBibi = decodedBibi
          .map((tr) => Transaction(
                id: tr['id'],
                title: tr['title'],
                value: tr['value'],
                valueRadio: tr['valueRadio'],
                date: DateTime.parse(tr['date']),
              ))
          .toList();
    }

    setState(() {});
  }

  void addTransaction(
      String title, double value, int valueRadio, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      valueRadio: valueRadio,
      date: date,
    );

    setState(() {
      if (valueRadio == 1) {
        transactionKleyte.add(newTransaction);
      } else {
        transactionBibi.add(newTransaction);
      }
    });

    _saveTransactions();
    Navigator.of(context).pop();
  }

  void removeTransactionKleyte(String id) {
    setState(() {
      transactionKleyte.removeWhere((tr) => tr.id == id);
    });

    _saveTransactions();
  }

  void removeTransactionBibi(String id) {
    setState(() {
      transactionBibi.removeWhere((tr) => tr.id == id);
    });

    _saveTransactions();
  }

  void openTransactionFormModal(BuildContext context) {
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
      title: const Center(
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
            SizedBox(
              height: availableHeight * 0.07,
              child: TotalSum(transactionKleyte, transactionBibi),
            ),
            SizedBox(
              height: availableHeight * 0.07,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Kleyte'),
                  Text('Bibi'),
                ],
              ),
            ),
            SizedBox(
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
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
