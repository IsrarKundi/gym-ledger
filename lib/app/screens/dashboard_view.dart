import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymledger/app/controllers/attendance_controller.dart';
import 'package:gymledger/app/controllers/dashboard_controller.dart';
import 'package:gymledger/app/controllers/members_list_controller.dart';
import 'package:gymledger/app/controllers/payments_controller.dart';
import 'package:gymledger/app/screens/attendance_view.dart';
import 'package:gymledger/app/screens/members/add_member_view.dart';
import 'package:gymledger/app/screens/members/members_list_view.dart';
import 'package:gymledger/app/screens/payments_view.dart';
import 'package:gymledger/app/widgets/member_card.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final DashboardController controller = Get.put(DashboardController());
  final MembersListController membersController = Get.put(MembersListController());
  final AttendanceController attendanceController = Get.put(AttendanceController());
  final PaymentsController paymentsController = Get.put(PaymentsController());

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Gym Manager')),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHome(),
          MembersListView(),
          AttendanceView(),
          PaymentsView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Members'),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: 'Attendance'),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Payments'),
        ],
      ),
    );
  }

  Widget _buildHome() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title:  Row(
          children: [
            Icon(Icons.menu, color: Colors.black87), 
            Spacer(),
            Image.asset('assets/logo_horizontal.png', height: 80),
            SizedBox(width: 18),
            Spacer(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 42.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stats Cards
              Row(
                children: [
                  Expanded(child: _statCard('Total Members', controller.totalMembers)),
                  const SizedBox(width: 12),
                  Expanded(child: _statCard('Due Payments', controller.duePayments)),
                  const SizedBox(width: 12),
                  Expanded(child: _statCard('Attendance Today', controller.attendanceToday)),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Revenue Section
              const Text('Financial Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _revenueCard('Revenue This Month', controller.totalRevenueThisMonth, Colors.green)),
                  const SizedBox(width: 12),
                  Expanded(child: _revenueCard('Pending Dues', controller.totalPendingDues, Colors.orange)),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Attendance Chart
              const Text('Attendance Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              _attendanceChart(),
              
              const SizedBox(height: 24),
              
              // Quick Actions
              const Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              _quickActions(),
              
              const SizedBox(height: 24),
              
              // Recent Members
              const Text('Recent Members', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              MemberCard(name: 'John Doe', plan: 'Monthly', imageUrl: 'assets/sam11.png', onTap: () {
                
              }),
              MemberCard(name: 'Jane Smith', plan: 'Yearly', imageUrl: 'assets/sam22.png', onTap: () {
               
              }),
            ],
          ),
        ),
      ),
    );
  }


  Widget _statCard(String label, RxInt value) {
    return Obx(() => Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.grey.shade100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
              const SizedBox(height: 8),
              Text(value.value.toString(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ));
  }

  Widget _revenueCard(String label, RxInt value, Color color) {
    return Obx(() => Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color.withOpacity(0.1),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 12, color: color.withOpacity(0.8))),
              const SizedBox(height: 8),
              Text(
                '₹${value.value.toString()}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
        ));
  }

  Widget _attendanceChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue.withOpacity(0.05),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Last 7 Days', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: controller.attendanceData.map((data) {
                final maxValue = controller.attendanceData.map((d) => d['count'] as int).reduce((a, b) => a > b ? a : b);
                final height = (data['count'] as int) / maxValue * 80;
                
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('${data['count']}', style: const TextStyle(fontSize: 10, color: Colors.black54)),
                    const SizedBox(height: 4),
                    Container(
                      width: 24,
                      height: height,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(data['day'], style: const TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickActions() {
    return Row(
      children: [
        Expanded(
          child: _quickActionButton(
            'Add Member',
            Icons.person_add,
            Colors.blue,
            () => Get.to(() => AddMemberView()),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _quickActionButton(
            'Record Payment',
            Icons.payment,
            Colors.green,
            () => setState(() => _selectedIndex = 3), // Navigate to Payments tab
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _quickActionButton(
            'Mark Attendance',
            Icons.check_circle,
            Colors.orange,
            () => setState(() => _selectedIndex = 2), // Navigate to Attendance tab
          ),
        ),
      ],
    );
  }

  Widget _quickActionButton(String label, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color.withOpacity(0.1),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
