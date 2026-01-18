import 'package:flutter_riverpod/flutter_riverpod.dart';

final customerProvider = StateNotifierProvider<CustomerNotifier, List<Map<String, dynamic>>>((ref) {
  return CustomerNotifier();
});

class CustomerNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  CustomerNotifier() : super([
    {
      'id': '1',
      'name': 'PT ABC Indonesia',
      'email': 'contact@abc.com',
      'phone': '081234567890',
      'segment': 'VIP',
      'totalPurchase': 125000000,
      'joinDate': DateTime.now().subtract(const Duration(days: 180)),
      'lastTransaction': DateTime.now().subtract(const Duration(days: 5)),
    },
    {
      'id': '2',
      'name': 'CV Maju Jaya',
      'email': 'info@majujaya.com',
      'phone': '087654321098',
      'segment': 'Regular',
      'totalPurchase': 35000000,
      'joinDate': DateTime.now().subtract(const Duration(days: 90)),
      'lastTransaction': DateTime.now().subtract(const Duration(days: 15)),
    },
    {
      'id': '3',
      'name': 'Toko Elektronik Maju',
      'email': 'toko@elektronik.com',
      'phone': '085555555555',
      'segment': 'New',
      'totalPurchase': 5000000,
      'joinDate': DateTime.now().subtract(const Duration(days: 10)),
      'lastTransaction': DateTime.now().subtract(const Duration(days: 3)),
    },
  ]);

  void addCustomer(Map<String, dynamic> customer) {
    final newCustomer = {
      ...customer,
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'joinDate': DateTime.now(),
      'totalPurchase': 0,
      'lastTransaction': null,
    };
    state = [...state, newCustomer];
  }

  void updateCustomer(String id, Map<String, dynamic> customer) {
    state = [
      for (final cust in state)
        if (cust['id'] == id) {...cust, ...customer} else cust,
    ];
  }

  void deleteCustomer(String id) {
    state = state.where((cust) => cust['id'] != id).toList();
  }

  List<Map<String, dynamic>> getBySegment(String segment) {
    return state.where((cust) => cust['segment'] == segment).toList();
  }

  int getTotalCustomers() => state.length;

  int getVIPCount() => getBySegment('VIP').length;

  double getTotalRevenue() {
    return state.fold<double>(0, (sum, cust) => sum + (cust['totalPurchase'] as num).toDouble());
  }
}
