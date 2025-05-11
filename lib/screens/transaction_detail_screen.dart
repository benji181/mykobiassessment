import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/transaction.dart';
import '../providers/transaction_provider.dart';
import '../constants/app_constants.dart';

class TransactionDetailScreen extends ConsumerWidget {
  final Transaction transaction;

  const TransactionDetailScreen({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRefunded = transaction.status == 'Refunded';

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Transaction Details', style: TextStyle(color: Colors.black87)),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0 : 4,
        backgroundColor: AppConstants.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: AppConstants.cardColor,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: const AssetImage('assets/N.png'),
                      onBackgroundImageError: (exception, stackTrace) {
                        print('Image loading error: $exception');
                      },
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction.merchant,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(transaction.formattedDate, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '\$${transaction.amount.abs().toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 24, color: transaction.amount < 0 ? Colors.orange : Colors.green, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Payment Method: ${transaction.paymentMethod}', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text(
                  'Status: ${transaction.status}',
                  style: TextStyle(fontSize: 16, color: isRefunded ? Colors.grey : AppConstants.primaryColor),
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: isRefunded
                        ? null
                        : () {
                      ref.read(transactionProvider.notifier).updateTransactionStatus(transaction.id, 'Refunded');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Transaction Refunded')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isRefunded ? Colors.grey : Colors.red,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey,
                      disabledForegroundColor: Colors.black54,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: Text(
                      isRefunded ? 'Refunded' : 'Refund',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}