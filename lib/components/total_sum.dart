import 'package:flutter/material.dart';
import 'package:kleyte_bibi/models/transaction.dart';

class TotalSum extends StatelessWidget {
  final List<Transaction> transactionsKleyte;
  final List<Transaction> transactionsBibi;

  TotalSum(this.transactionsKleyte, this.transactionsBibi);

  double get totalKleyte {
    double sumTotalKleyte = 0;
    for (var i = 0; i < transactionsKleyte.length; i++) {
      sumTotalKleyte += transactionsKleyte[i].value;
    }
    return sumTotalKleyte;
  }

  double get totalBibi {
    double sumTotalBibi = 0;
    for (var i = 0; i < transactionsBibi.length; i++) {
      sumTotalBibi += transactionsBibi[i].value;
    }
    return sumTotalBibi;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Text(
          'Total €${(totalKleyte - totalBibi).toStringAsFixed(2)}',
        ),
      ),
    );
  }
}
