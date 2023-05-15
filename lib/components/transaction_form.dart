import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, int) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  int valueRadio = 1;
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit(title, value, valueRadio);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: valueRadio,
                      onChanged: (value) {
                        setState(() {
                          valueRadio = value!;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Kleyte'),
                    Radio(
                      value: 2,
                      groupValue: valueRadio,
                      onChanged: (value) {
                        setState(() {
                          valueRadio = value!;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Bibi'),
                  ],
                ),
              ],
            ),
            TextField(
              controller: titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              controller: valueController,
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
              ),
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Valor (€)',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text('Adicionar'),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: _submitForm,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
