import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:kleyte_bibi/services/database_service.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, int, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final DatabaseService _databaseService = DatabaseService.instance;

  int valueRadio = 1;
  DateTime date = DateTime.now();

  final titleController = TextEditingController();
  final valueController = TextEditingController();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;
    //final date = DateTime.parse(date);

    if (title.isEmpty || value <= 0) {
      return;
    }
    _databaseService.addTask(title, value, valueRadio);
    widget.onSubmit(title, value, valueRadio, date);
  }

  // _showDatePicker() {
  //   showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2021),
  //     lastDate: DateTime.now(),
  //   ).then((pickedDate) {
  //     if (pickedDate == null) {
  //       return;
  //     }
  //     setState(() {
  //       date = pickedDate;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Card(
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
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('Kleyte'),
                        Radio(
                          value: 2,
                          groupValue: valueRadio,
                          onChanged: (value) {
                            setState(() {
                              valueRadio = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('Bibi'),
                      ],
                    ),
                  ],
                ),
                TextField(
                  controller: titleController,
                  onSubmitted: (_) => _submitForm(),
                  decoration: const InputDecoration(
                    labelText: 'Título',
                  ),
                ),
                TextField(
                  controller: valueController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onSubmitted: (_) => _submitForm(),
                  decoration: const InputDecoration(
                    labelText: 'Valor (€)',
                  ),
                ),
                // SizedBox(
                //   height: 70,
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Text(
                //           'Data selecionada: ${DateFormat('dd/MM/y').format(date)}',
                //         ),
                //       ),
                //       TextButton(
                //         onPressed: _showDatePicker,
                //         child: const Text(
                //           'Selecionar data',
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Adicionar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
