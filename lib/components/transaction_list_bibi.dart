import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kleyte_bibi/models/transaction.dart';

class TransactionListBibi extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionListBibi(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: transactions.length,
                itemBuilder: (ctx, index) {
                  final tr = transactions[index];
                  return LayoutBuilder(
                    builder: (ctx, constraints) {
                      return Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: constraints.maxWidth * 0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tr.title,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Text(
                                      DateFormat('d MMM y').format(tr.date),
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: constraints.maxWidth * 0.37,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  '€ ${tr.value.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              Container(
                                width: constraints.maxWidth * 0.1,
                                child: IconButton(
                                  onPressed: () => onRemove(tr.id),
                                  iconSize: 14.0,
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
