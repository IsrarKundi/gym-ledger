// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../controllers/dashboard_controller.dart';

// class RevenueSection extends StatelessWidget {
//   final DashboardController controller;

//   const RevenueSection({
//     super.key,
//     required this.controller,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Financial Overview',
//           style: Theme.of(context).textTheme.titleLarge?.copyWith(
//             fontWeight: FontWeight.bold,
//             color: Colors.grey[800],
//           ),
//         ),
//         const SizedBox(height: 16),
//         Row(
//           children: [
//             Expanded(
//               child: _buildRevenueCard(
//                 context,
//                 title: 'Revenue This Month',
//                 value: controller.totalRevenueThisMonth,
//                 color: Colors.green,
//                 icon: Icons.trending_up,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: _buildRevenueCard(
//                 context,
//                 title: 'Pending Dues',
//                 value: controller.totalPendingDues,
//                 color: Colors.orange,
//                 icon: Icons.pending_actions,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildRevenueCard(
//     BuildContext context, {
//     required String title,
//     required RxInt value,
//     required Color color,
//     required IconData icon,
//   }) {
//     return Obx(() => Container(
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(
//               color: color.withOpacity(0.2),
//               width: 1,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: color.withOpacity(0.05),
//                 spreadRadius: 1,
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: color.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Icon(
//                       icon,
//                       color: color,
//                       size: 24,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 '₹${_formatNumber(value.value)}',
//                 style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: color,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 title,
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                   color: Colors.grey[600],
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }

//   String _formatNumber(int number) {
//     if (number >= 1000) {
//       return '${(number / 1000).toStringAsFixed(1)}k';
//     }
//     return number.toString();
//   }
// }