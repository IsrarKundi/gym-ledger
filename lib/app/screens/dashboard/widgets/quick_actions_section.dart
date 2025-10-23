// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../add_member_view.dart';

// class QuickActionsSection extends StatelessWidget {
//   final Function(int) onNavigateToTab;

//   const QuickActionsSection({
//     super.key,
//     required this.onNavigateToTab,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Quick Actions',
//           style: Theme.of(context).textTheme.titleLarge?.copyWith(
//             fontWeight: FontWeight.bold,
//             color: Colors.grey[800],
//           ),
//         ),
//         const SizedBox(height: 16),
//         Row(
//           children: [
//             Expanded(
//               child: _buildActionCard(
//                 context,
//                 title: 'Add Member',
//                 subtitle: 'Register new member',
//                 icon: Icons.person_add,
//                 color: Colors.blue,
//                 onTap: () => Get.to(() => AddMemberView()),
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: _buildActionCard(
//                 context,
//                 title: 'Record Payment',
//                 subtitle: 'Process payment',
//                 icon: Icons.payment,
//                 color: Colors.green,
//                 onTap: () => onNavigateToTab(3),
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: _buildActionCard(
//                 context,
//                 title: 'Mark Attendance',
//                 subtitle: 'Check attendance',
//                 icon: Icons.check_circle,
//                 color: Colors.orange,
//                 onTap: () => onNavigateToTab(2),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildActionCard(
//     BuildContext context, {
//     required String title,
//     required String subtitle,
//     required IconData icon,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: color.withOpacity(0.2),
//             width: 1,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.08),
//               spreadRadius: 1,
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Icon(
//                 icon,
//                 color: color,
//                 size: 28,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               title,
//               style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                 fontWeight: FontWeight.w600,
//                 color: Colors.grey[800],
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 4),
//             Text(
//               subtitle,
//               style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                 color: Colors.grey[500],
//                 fontSize: 11,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }