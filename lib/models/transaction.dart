import 'package:intl/intl.dart';

class Transaction {
  final int id;
  final String merchant;
  final double amount;
  final String category;
  final DateTime date;
  final String status;
  final String paymentMethod;
  final String icon;

  Transaction({
    required this.id,
    required this.merchant,
    required this.amount,
    required this.category,
    required this.date,
    required this.status,
    required this.paymentMethod,
    required this.icon,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      merchant: json['merchant'],
      amount: json['amount'].toDouble(),
      category: json['category'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      paymentMethod: json['payment_method'],
      icon: json['icon'],
    );
  }

  String get formattedDate {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Today ${DateFormat('hh:mm a').format(date)}';
    } else if (date.year == now.year && date.month == now.month && date.day == now.day - 1) {
      return 'Yesterday ${DateFormat('hh:mm a').format(date)}';
    } else if (date.isAfter(now)) {
      return 'Tomorrow ${DateFormat('hh:mm a').format(date)}';
    }
    return DateFormat('yyyy-MM-dd hh:mm a').format(date);
  }
}