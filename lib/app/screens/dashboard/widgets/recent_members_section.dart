import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/member_card.dart';
import '../../../controllers/members_list_controller.dart';
import '../../members/member_profile_view.dart';

class RecentMembersSection extends StatelessWidget {
  final MembersListController membersController;

  const RecentMembersSection({
    super.key,
    required this.membersController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Members',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to members tab
              },
              child: Text(
                'View All',
                style: TextStyle(
                  color: Colors.blue[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        // const SizedBox(height: 16),
        Column(
          children: [
            Obx(() {
              final recentMembers = membersController.members.take(3).toList();
              if (recentMembers.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 48,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No members yet',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Add your first member to get started',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }
        
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // padding: const EdgeInsets.all(16),
                itemCount: recentMembers.length,
                separatorBuilder: (context, index) => const SizedBox(height: 0),
                itemBuilder: (context, index) {
                  final member = recentMembers[index];
                  return MemberCard(
                    name: member.name,
                    plan: member.plan,
                    imageUrl: 'assets/sam${(index % 4) + 1}${(index % 4) + 1}.png',
                    membershipExpiryDate: member.membershipExpiryDate,
                    paymentStatus: member.paymentStatus,
                    membershipStatus: member.membershipStatus,
                    onTap: () {
                      Get.to(() => const MemberProfileView(), arguments: member);
                    },
                  );
                },
              );
            }),
          ],
        ),
      ],
    );
  }
}