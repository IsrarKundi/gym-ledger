import 'package:get/get.dart';
import '../models/member.dart';

class MembersListController extends GetxController {
  final members = <Member>[
    Member(id: '1', name: 'John Doe', phone: '555-1234', plan: 'Monthly', address: '123 Main St', joiningDate: DateTime(2024, 1, 15), membershipExpiryDate: DateTime(2024, 12, 15), paymentStatus: 'Paid', membershipStatus: 'Active'),
    Member(id: '2', name: 'Jane Smith', phone: '555-5678', plan: 'Yearly', address: '456 Oak Ave', joiningDate: DateTime(2023, 6, 20), membershipExpiryDate: DateTime(2024, 6, 20), paymentStatus: 'Due', membershipStatus: 'Expired'),
    Member(id: '3', name: 'Alice Brown', phone: '555-9012', plan: 'Monthly', address: '789 Pine Rd', joiningDate: DateTime(2024, 3, 10), membershipExpiryDate: DateTime(2024, 11, 10), paymentStatus: 'Paid', membershipStatus: 'Active'),
    Member(id: '4', name: 'Bob Johnson', phone: '555-3456', plan: 'Yearly', address: '321 Maple St', joiningDate: DateTime(2023, 11, 5), membershipExpiryDate: DateTime(2024, 11, 5), paymentStatus: 'Paid', membershipStatus: 'Active'),
    Member(id: '5', name: 'Charlie Davis', phone: '555-7890', plan: 'Monthly', address: '654 Cedar Ln', joiningDate: DateTime(2024, 2, 25), membershipExpiryDate: DateTime(2024, 10, 25), paymentStatus: 'Due', membershipStatus: 'Expired'),
    Member(id: '6', name: 'Diana Evans', phone: '555-2345', plan: 'Yearly', address: '987 Birch Blvd', joiningDate: DateTime(2023, 8, 30), membershipExpiryDate: DateTime(2025, 8, 30), paymentStatus: 'Paid', membershipStatus: 'Active'),
  ].obs;

  final searchQuery = ''.obs;
  final statusFilter = 'All'.obs; // All, Active, Expired
  final planFilter = 'All'.obs; // All, Monthly, Yearly

  List<Member> get filtered {
    var result = members.where((m) => m.name.toLowerCase().contains(searchQuery.value.toLowerCase()));
    
    // Filter by status
    if (statusFilter.value != 'All') {
      result = result.where((m) => m.membershipStatus == statusFilter.value);
    }
    
    // Filter by plan
    if (planFilter.value != 'All') {
      result = result.where((m) => m.plan == planFilter.value);
    }
    
    return result.toList();
  }

  int get activeCount => members.where((m) => m.membershipStatus == 'Active').length;
  int get expiredCount => members.where((m) => m.membershipStatus == 'Expired').length;
}
