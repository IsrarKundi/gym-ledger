import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymledger/app/models/utils/colors.dart';
import 'package:gymledger/app/widgets/custom_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import '../controllers/attendance_controller.dart';
import 'package:gymledger/app/widgets/save_attendance_button.dart';
import 'package:gymledger/app/widgets/custom_search_field.dart';

class AttendanceView extends StatelessWidget {
  final AttendanceController controller = Get.put(AttendanceController());

  AttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: CustomAppBar(
        title: 'Attendance',
        actions: [
          // Export button
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _showExportDialog(context),
            tooltip: 'Export Attendance',
          ),
        ],
      ),
      body: Stack(
        children: [
          // Main scrollable content styled like MembersListView
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date card
                // Obx(
                //   () => Container(
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(14),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey.withOpacity(0.08),
                //           blurRadius: 8,
                //           offset: const Offset(0, 3),
                //         ),
                //       ],
                //     ),
                //     padding: const EdgeInsets.all(16),
                //     child: Row(
                //       children: [
                //         const Icon(Icons.calendar_today, color: Colors.blue),
                //         const SizedBox(width: 12),
                //         Expanded(
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               const Text(
                //                 'Selected Date',
                //                 style: TextStyle(
                //                   fontSize: 12,
                //                   color: Colors.grey,
                //                   fontWeight: FontWeight.w500,
                //                 ),
                //               ),
                //               Text(
                //                 DateFormat('EEEE, MMMM d, yyyy').format(controller.selectedDate.value),
                //                 style: const TextStyle(
                //                   fontSize: 16,
                //                   fontWeight: FontWeight.w600,
                //                   color: Colors.blue,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         ElevatedButton.icon(
                //           onPressed: () => _selectDate(context),
                //           icon: const Icon(Icons.edit_calendar, size: 18),
                //           label: const Text('Change'),
                //           style: ElevatedButton.styleFrom(
                //             backgroundColor: primaryColor,
                //             foregroundColor: Colors.white,
                //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                const SizedBox(height: 10),

                // Search + Filters container
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Field
                    CustomSearchField(
                      hintText: 'Search members by name...',
                      onChanged: (value) => controller.searchQuery.value = value,
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),

                const SizedBox(height: 0),

                // Summary card
                Obx(() {
                  final filteredMembers = controller.filteredMembers;
                  final presentCount = filteredMembers.where((m) => m['present'] == true).length;
                  final absentCount = filteredMembers.length - presentCount;

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSummaryItem(
                          context,
                          icon: Icons.check_circle,
                          label: 'Present',
                          count: presentCount,
                          color: Colors.green,
                        ),
                        _verticalDivider(),
                        _buildSummaryItem(
                          context,
                          icon: Icons.cancel,
                          label: 'Absent',
                          count: absentCount,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 10),

                // Members list
                Obx(() {
                  final filteredMembers = controller.filteredMembers;
                  if (filteredMembers.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text(
                          'No members found',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: [
                      for (var m in filteredMembers)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Avatar
                                  CircleAvatar(
                                    radius: 26,
                                    backgroundColor: Colors.grey.shade100,
                                    child: Text(
                                      (m['name'] as String).isNotEmpty ? (m['name'] as String)[0].toUpperCase() : '?',
                                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                                    ),
                                  ),
                                  const SizedBox(width: 14),

                                  // Member info
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          m['name'] ?? '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[900],
                                              ),
                                        ),
                                        // const SizedBox(height: 4),
                                        // Text(
                                        //   (m['present'] as bool) ? 'Present' : 'Absent',
                                        //   maxLines: 1,
                                        //   overflow: TextOverflow.ellipsis,
                                        //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        //         color: Colors.grey[600],
                                        //         fontWeight: FontWeight.w500,
                                        //       ),
                                        // ),
                                        const SizedBox(height: 8),
                                        // Status chip
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: (m['present'] as bool) ? Colors.green.withOpacity(0.1) : Colors.redAccent.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: (m['present'] as bool) ? Colors.green.withOpacity(0.4) : Colors.redAccent.withOpacity(0.4), width: 0.8),
                                          ),
                                          child: Text(
                                            (m['present'] as bool) ? 'Present' : 'Absent',
                                            style: TextStyle(
                                              color: (m['present'] as bool) ? Colors.green : Colors.redAccent,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 11,
                                              letterSpacing: 0.2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Toggle
                                  Switch(
                                    value: (m['present'] as bool),
                                    onChanged: (_) => controller.toggle(m['id']),
                                    activeColor: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                }),
              ],
            ),
          ),

          // Fixed Save Button
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: SafeArea(
              child: SaveAttendanceButton(
                onPressed: () {
                  controller.saveAttendance();
                  final stats = controller.getAttendanceStats();

                  Get.snackbar(
                    'Attendance Saved',
                    'Present: ${stats['present']} | Absent: ${stats['absent']}',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    duration: const Duration(seconds: 2),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blue,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && picked != controller.selectedDate.value) {
      controller.selectDate(picked);
    }
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Export Attendance'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Export attendance data for ${DateFormat('MMMM d, yyyy').format(controller.selectedDate.value)}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _exportCSV(context),
                    icon: const Icon(Icons.table_chart),
                    label: const Text('CSV'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _exportPDF(context),
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text('PDF'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _exportCSV(BuildContext context) {
    final csvData = controller.generateCSVData();
    
    // Copy to clipboard
    Clipboard.setData(ClipboardData(text: csvData));
    
    Navigator.of(context).pop();
    
    Get.snackbar(
      'CSV Export',
      'Attendance data copied to clipboard',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  void _exportPDF(BuildContext context) {
    Navigator.of(context).pop();
    
    // For now, show a message that PDF export would be implemented
    Get.snackbar(
      'PDF Export',
      'PDF export feature coming soon!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
  
  Widget _verticalDivider() => Container(
        width: 1,
        height: 40,
        color: Colors.grey.shade300,
      );
  
  Widget _buildSummaryItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int count,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 2),
        Text(
          count.toString(),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
        // const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
