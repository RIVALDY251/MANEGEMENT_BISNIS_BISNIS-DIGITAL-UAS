import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionProvider = StateNotifierProvider<TransactionNotifier, List<Map<String, dynamic>>>((ref) {
  return TransactionNotifier();
});

class TransactionNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  TransactionNotifier() : super([
    {
      'id': '1',
      'type': 'Pendapatan',
      'description': 'Penjualan Produk',
      'amount': 5000000,
      'category': 'Retail',
      'date': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'id': '2',
      'type': 'Pengeluaran',
      'description': 'Pembelian Stok',
      'amount': 1500000,
      'category': 'Inventory',
      'date': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'id': '3',
      'type': 'Pendapatan',
      'description': 'Jasa Konsultasi',
      'amount': 3500000,
      'category': 'Service',
      'date': DateTime.now(),
    },
  ]);

  void addTransaction(Map<String, dynamic> transaction) {
    final newTransaction = {
      ...transaction,
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'date': DateTime.now(),
    };
    state = [...state, newTransaction];
  }

  void updateTransaction(String id, Map<String, dynamic> transaction) {
    state = [
      for (final trans in state)
        if (trans['id'] == id) {...trans, ...transaction} else trans,
    ];
  }

  void deleteTransaction(String id) {
    state = state.where((trans) => trans['id'] != id).toList();
  }

  double getTotalIncome() {
    return state
        .where((trans) => trans['type'] == 'Pendapatan')
        .fold<double>(0, (sum, trans) => sum + (trans['amount'] as num).toDouble());
  }

  double getTotalExpense() {
    return state
        .where((trans) => trans['type'] == 'Pengeluaran')
        .fold<double>(0, (sum, trans) => sum + (trans['amount'] as num).toDouble());
  }

  double getNetProfit() {
    return getTotalIncome() - getTotalExpense();
  }
}
