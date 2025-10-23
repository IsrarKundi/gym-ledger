import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AttendanceController extends GetxController {
  final members = <Map<String, dynamic>>[
    {'id': '1', 'name': 'John Doe', 'present': true},
    {'id': '2', 'name': 'Jane Smith', 'present': false},
    {'id': '3', 'name': 'Alice Brown', 'present': true},
    {'id': '4', 'name': 'Bob Johnson', 'present': false},
    {'id': '5', 'name': 'Charlie Davis', 'present': true},
    {'id': '6', 'name': 'Diana Evans', 'present': false},
  ].obs;

  // Date-based attendance tracking
  final selectedDate = DateTime.now().obs;
  final searchQuery = ''.obs;
  
  // Map to store attendance data by date: date -> memberId -> bool
  final attendanceHistory = <String, Map<String, bool>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize today's attendance with current member status
    _initializeTodayAttendance();
  }

  void _initializeTodayAttendance() {
    final dateKey = _formatDateKey(selectedDate.value);
    if (!attendanceHistory.containsKey(dateKey)) {
      attendanceHistory[dateKey] = {};
      for (var member in members) {
        attendanceHistory[dateKey]![member['id']] = member['present'] as bool;
      }
    }
  }

  String _formatDateKey(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  List<Map<String, dynamic>> get filteredMembers {
    return members.where((member) {
      final name = member['name'].toString().toLowerCase();
      return name.contains(searchQuery.value.toLowerCase());
    }).toList();
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
    _loadAttendanceForDate(date);
  }

  void _loadAttendanceForDate(DateTime date) {
    final dateKey = _formatDateKey(date);
    if (attendanceHistory.containsKey(dateKey)) {
      // Load existing attendance for this date
      for (var member in members) {
        final memberId = member['id'];
        member['present'] = attendanceHistory[dateKey]![memberId] ?? false;
      }
    } else {
      // Initialize new date with all absent
      attendanceHistory[dateKey] = {};
      for (var member in members) {
        member['present'] = false;
        attendanceHistory[dateKey]![member['id']] = false;
      }
    }
    members.refresh();
  }

  void toggle(String id) {
    final idx = members.indexWhere((m) => m['id'] == id);
    if (idx != -1) {
      final newStatus = !(members[idx]['present'] as bool);
      members[idx]['present'] = newStatus;
      
      // Save to attendance history
      final dateKey = _formatDateKey(selectedDate.value);
      if (!attendanceHistory.containsKey(dateKey)) {
        attendanceHistory[dateKey] = {};
      }
      attendanceHistory[dateKey]![id] = newStatus;
      
      members.refresh();
      attendanceHistory.refresh();
    }
  }

  void saveAttendance() {
    final dateKey = _formatDateKey(selectedDate.value);
    attendanceHistory[dateKey] = {};
    
    for (var member in members) {
      attendanceHistory[dateKey]![member['id']] = member['present'] as bool;
    }
    attendanceHistory.refresh();
  }

  Map<String, dynamic> getAttendanceStats() {
    final presentCount = members.where((m) => m['present'] == true).length;
    final absentCount = members.length - presentCount;
    
    return {
      'present': presentCount,
      'absent': absentCount,
      'total': members.length,
      'date': selectedDate.value,
    };
  }

  String generateCSVData() {
    final dateKey = _formatDateKey(selectedDate.value);
    final csvLines = <String>[];
    
    // Header
    csvLines.add('Member Name,Member ID,Status,Date');
    
    // Data rows
    for (var member in members) {
      final status = member['present'] == true ? 'Present' : 'Absent';
      csvLines.add('${member['name']},${member['id']},$status,$dateKey');
    }
    
    return csvLines.join('\n');
  }
}
