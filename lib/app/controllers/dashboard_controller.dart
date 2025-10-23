import 'package:get/get.dart';

class DashboardController extends GetxController {
  final totalMembers = 42.obs;
  final duePayments = 5.obs;
  final attendanceToday = 28.obs;
  
  // New revenue and financial data
  final totalRevenueThisMonth = 15750.obs;
  final totalPendingDues = 3200.obs;
  
  // Attendance data for the past 7 days (dummy data)
  final attendanceData = <Map<String, dynamic>>[
    {'day': 'Mon', 'count': 25},
    {'day': 'Tue', 'count': 32},
    {'day': 'Wed', 'count': 28},
    {'day': 'Thu', 'count': 35},
    {'day': 'Fri', 'count': 30},
    {'day': 'Sat', 'count': 40},
    {'day': 'Sun', 'count': 22},
  ].obs;
}
