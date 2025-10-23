import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymledger/app/models/utils/colors.dart';
import 'package:gymledger/app/widgets/custom_app_bar.dart';
import 'package:gymledger/app/widgets/member_card.dart';
import 'package:gymledger/app/widgets/custom_search_field.dart';
import '../../controllers/members_list_controller.dart';
import 'add_member_view.dart';
import 'member_profile_view.dart';

class MembersListView extends StatelessWidget {
  final MembersListController controller = Get.put(MembersListController());

  MembersListView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: CustomAppBar(title: 'Members'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () => Get.to(() => AddMemberView()),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ---------- Summary Section ----------
            Obx(
              () => Container(
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryCard(
                      label: 'Active',
                      count: controller.activeCount.toString(),
                      color: Colors.green,
                      icon: Icons.check_circle_outline,
                    ),
                    _verticalDivider(),
                    _buildSummaryCard(
                      label: 'Expired',
                      count: controller.expiredCount.toString(),
                      color: Colors.redAccent,
                      icon: Icons.cancel_outlined,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            /// ---------- Search + Filters ----------
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Search Field
                CustomSearchField(
                  hintText: 'Search members...',
                  onChanged: (v) => controller.searchQuery.value = v,
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                ),
                const SizedBox(height: 12),
            
                /// Filters Row (Modern Buttons)
                Row(
                  children: [
                    Expanded(
                      child: Obx(() => _modernDropdown(
                            context,
                            controller.statusFilter,
                            ['All', 'Active', 'Expired'],
                          )),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Obx(() => _modernDropdown(
                            context,
                            controller.planFilter,
                            ['All', 'Monthly', 'Yearly'],
                          )),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),

            /// ---------- Members List ----------
            Obx(() {
              final list = controller.filtered;
              if (list.isEmpty) {
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
                  for (var m in list)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: MemberCard(
                        name: m.name,
                        plan: m.plan,
                        imageUrl: 'assets/icon.png',
                        membershipExpiryDate: m.membershipExpiryDate,
                        paymentStatus: m.paymentStatus,
                        membershipStatus: m.membershipStatus,
                        onTap: () {
                          log('Opening profile for ${m.name}');
                          Get.to(() => const MemberProfileView(), arguments: m);
                        },
                        onEdit: () => Get.to(() => AddMemberView(), arguments: m),
                        onDelete: () {
                          controller.members.removeWhere((e) => e.id == m.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Deleted ${m.name}')),
                          );
                        },
                      ),
                    ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  /// ---------- Components ----------

  Widget _buildSummaryCard({
    required String label,
    required String count,
    required Color color,
    required IconData icon,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 26),
        const SizedBox(height: 6),
        Text(
          count,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _verticalDivider() => Container(
        width: 1,
        height: 40,
        color: Colors.grey.shade300,
      );

  Widget _modernDropdown(
      BuildContext context, RxString value, List<String> items) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value.value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: items
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ))
              .toList(),
          onChanged: (val) {
            if (val != null) value.value = val;
          },
        ),
      ),
    );
  }
}
