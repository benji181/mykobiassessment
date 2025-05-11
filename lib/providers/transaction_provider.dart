import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/transaction.dart';

class TransactionNotifier extends StateNotifier<AsyncValue<List<Transaction>>> {
  TransactionNotifier() : super(const AsyncValue.loading()) {
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    try {
      final jsonString = await rootBundle.loadString('assets/transactions.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      final transactions = jsonList.map((json) => Transaction.fromJson(json)).toList();
      state = AsyncValue.data(transactions);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void updateTransactionStatus(int id, String newStatus) {
    state.whenData((transactions) {
      final updatedTransactions = transactions.map((t) {
        if (t.id == id) {
          return Transaction(
            id: t.id,
            merchant: t.merchant,
            amount: t.amount,
            category: t.category,
            date: t.date,
            status: newStatus,
            paymentMethod: t.paymentMethod,
            icon: t.icon,
          );
        }
        return t;
      }).toList();
      state = AsyncValue.data(updatedTransactions);
    });
  }

  List<Transaction> filterTransactions(String tab, List<Transaction> transactions) {
    final now = DateTime.now();
    final thisMonth = DateTime(now.year, now.month);
    final lastMonth = DateTime(now.year, now.month - 1);

    switch (tab) {
      case 'This Month':
        return transactions.where((t) => t.date.year == thisMonth.year && t.date.month == thisMonth.month).toList();
      case 'Last Month':
        return transactions.where((t) => t.date.year == lastMonth.year && t.date.month == lastMonth.month).toList();
      default:
        return transactions;
    }
  }
}

final transactionProvider = StateNotifierProvider<TransactionNotifier, AsyncValue<List<Transaction>>>((ref) {
  return TransactionNotifier();
});