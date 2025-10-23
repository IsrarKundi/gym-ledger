import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymledger/app/models/utils/colors.dart';
import '../attendance_view.dart';
import '../members/members_list_view.dart';
import '../payments_view.dart';
import '../../controllers/dashboard_controller.dart';
import '../../controllers/members_list_controller.dart';
import '../../controllers/attendance_controller.dart';
import '../../controllers/payments_controller.dart';
import 'widgets/stats_section.dart';
import 'widgets/revenue_section.dart';
import 'widgets/attendance_chart_section.dart';
import 'widgets/quick_actions_section.dart';
import 'widgets/recent_members_section.dart';

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

  // Consistent spacing constants
  static const double _pagePadding = 16.0;
  static const double _sectionSpacing = 12.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHome(),
          MembersListView(),
          AttendanceView(),
          PaymentsView(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey[400],
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Members',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            activeIcon: Icon(Icons.check_circle),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment_outlined),
            activeIcon: Icon(Icons.payment),
            label: 'Payments',
          ),
        ],
      ),
    );
  }

  Widget _buildHome() {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _pagePadding, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              // _buildWelcomeSection(),
              // SizedBox(height: 10,),
              // SizedBox(height: _sectionSpacing),
              
              // Stats Section
              StatsSection(controller: controller),
              SizedBox(height: _sectionSpacing),
              
              // Revenue Section
              // RevenueSection(controller: controller),
              // SizedBox(height: _sectionSpacing),
              
              // Attendance Chart Section
              AttendanceChartSection(controller: controller),
              SizedBox(height: _sectionSpacing),
              
              // Quick Actions Section
              // QuickActionsSection(
              //   onNavigateToTab: (index) => setState(() => _selectedIndex = index),
              // ),
              // SizedBox(height: _sectionSpacing),
              
              // Recent Members Section
              RecentMembersSection(membersController: membersController),
              const SizedBox(height: 32), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 80,
      title: Row(
        children: [
          Icon(
            Icons.menu,
            color: Colors.grey[700],
            size: 28,
          ),
          const Spacer(),
          Container(
            height: 90,
            child: Image.asset(
              'assets/logo_horizontal.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Text(
                  'GYMLEDGER',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                );
              },
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.grey[600],
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back!',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        // const SizedBox(height: 4),
        // Text(
        //   'Here\'s what\'s happening at your gym today',
        //   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        //     color: Colors.grey[600],
        //   ),
        // ),
      ],
    );
  }
}
