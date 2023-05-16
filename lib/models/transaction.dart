class Transaction {
  final String id;
  final String title;
  final double value;
  final int valueRadio;
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.value,
    required this.valueRadio,
    required this.date,
  });
}
