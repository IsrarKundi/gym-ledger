import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PaymentsController extends GetxController {
  final records = <Map<String, dynamic>>[
    {
      'id': '1', 
      'name': 'John Doe', 
      'paid': true, 
      'amount': 100.0, 
      'planType': 'Monthly',
      'lastPaymentDate': DateTime(2025, 10, 15),
      'dueDate': DateTime(2025, 11, 15),
    },
    {
      'id': '2', 
      'name': 'Jane Smith', 
      'paid': false, 
      'amount': 1200.0, 
      'planType': 'Yearly',
      'lastPaymentDate': DateTime(2024, 10, 1),
      'dueDate': DateTime(2025, 10, 1),
    },
    {
      'id': '3', 
      'name': 'Alice Brown', 
      'paid': true, 
      'amount': 100.0, 
      'planType': 'Monthly',
      'lastPaymentDate': DateTime(2025, 10, 20),
      'dueDate': DateTime(2025, 11, 20),
    },
    {
      'id': '4', 
      'name': 'Bob Johnson', 
      'paid': false, 
      'amount': 100.0, 
      'planType': 'Monthly',
      'lastPaymentDate': DateTime(2025, 9, 5),
      'dueDate': DateTime(2025, 10, 5),
    },
    {
      'id': '5', 
      'name': 'Charlie Davis', 
      'paid': true, 
      'amount': 1200.0, 
      'planType': 'Yearly',
      'lastPaymentDate': DateTime(2025, 10, 10),
      'dueDate': DateTime(2026, 10, 10),
    },
  ].obs;

  // Filter properties
  final statusFilter = 'All'.obs; // All, Paid, Unpaid
  final monthFilter = 'All'.obs; // All, Current Month, etc.

  List<Map<String, dynamic>> get filteredRecords {
    var result = records.where((record) => true);
    
    // Filter by payment status
    if (statusFilter.value != 'All') {
      final isPaidFilter = statusFilter.value == 'Paid';
      result = result.where((r) => r['paid'] == isPaidFilter);
    }
    
    // Filter by month (for due dates)
    if (monthFilter.value != 'All') {
      final now = DateTime.now();
      if (monthFilter.value == 'Current Month') {
        result = result.where((r) {
          final dueDate = r['dueDate'] as DateTime;
          return dueDate.year == now.year && dueDate.month == now.month;
        });
      } else if (monthFilter.value == 'Overdue') {
        result = result.where((r) {
          final dueDate = r['dueDate'] as DateTime;
          return dueDate.isBefore(now) && r['paid'] == false;
        });
      }
    }
    
    return result.toList();
  }

  // Financial calculations
  double get totalIncome {
    return records
        .where((r) => r['paid'] == true)
        .fold(0.0, (sum, r) => sum + (r['amount'] as double));
  }

  double get totalDue {
    return records
        .where((r) => r['paid'] == false)
        .fold(0.0, (sum, r) => sum + (r['amount'] as double));
  }

  int get paidCount => filteredRecords.where((r) => r['paid'] == true).length;
  int get unpaidCount => filteredRecords.where((r) => r['paid'] == false).length;

  void markAsPaid(String id) {
    final idx = records.indexWhere((r) => r['id'] == id);
    if (idx != -1) {
      records[idx]['paid'] = true;
      records[idx]['lastPaymentDate'] = DateTime.now();
      records.refresh();
    }
  }

  void addPayment({
    required String memberId,
    required String memberName,
    required double amount,
    required String planType,
    required DateTime dueDate,
  }) {
    final newPayment = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'name': memberName,
      'paid': true,
      'amount': amount,
      'planType': planType,
      'lastPaymentDate': DateTime.now(),
      'dueDate': dueDate,
    };
    
    records.add(newPayment);
    records.refresh();
  }

  String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
    return formatter.format(amount);
  }

  String formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }
}
