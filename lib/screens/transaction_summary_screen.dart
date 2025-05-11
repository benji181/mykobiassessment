import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/transaction.dart';
import '../providers/transaction_provider.dart';
import '../widgets/transaction_card.dart';
import '../widgets/expense_chart.dart';
import '../constants/app_constants.dart';
import 'transaction_detail_screen.dart';

class TransactionSummaryScreen extends ConsumerStatefulWidget {
  const TransactionSummaryScreen({Key? key}) : super(key: key);

  @override
  _TransactionSummaryScreenState createState() => _TransactionSummaryScreenState();
}

class _TransactionSummaryScreenState extends ConsumerState<TransactionSummaryScreen> {
  String _selectedMonth = 'May';

  @override
  Widget build(BuildContext context) {
    final transactionsAsync = ref.watch(transactionProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () {},
        ),
        title: const Text('History',style: TextStyle(color: Colors.black87,)),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black54),
            onPressed: () {},
          ),
        ],
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0 : 4,
        backgroundColor: AppConstants.backgroundColor,
      ),
      body:
      transactionsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (transactions) {
          final totalAmount = transactions.fold(0.0, (sum, t) => sum + t.amount.abs());
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: const AssetImage('assets/N.png'),
                            onBackgroundImageError: (exception, stackTrace) {
                              print('Image loading error: $exception'); // Debug log
                            },
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Netflix', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,
                              )),
                              Text('Production Company', style: TextStyle(fontSize: 14, color: Colors.black54)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Card(
                        color: AppConstants.cardColor,
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total payment', style: TextStyle(fontSize: 16)),
                              DropdownButton<String>(
                                value: _selectedMonth,
                                items: <String>['May', 'April', 'June']
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedMonth = newValue!;
                                  });
                                },
                              ),
                              Text(
                                '\$${totalAmount.toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 21),
                      ExpenseChart(transactions: transactions),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Transaction', style: TextStyle(fontSize: 18, color: AppConstants.primaryColor)),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    return TransactionCard(
                      transaction: transaction,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransactionDetailScreen(transaction: transaction),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}