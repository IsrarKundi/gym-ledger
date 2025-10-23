import 'package:flutter/material.dart';
import 'package:gymledger/app/models/utils/colors.dart';

class MemberCard extends StatelessWidget {
  final String name;
  final String plan;
  final String imageUrl;
  final DateTime? membershipExpiryDate;
  final String paymentStatus;
  final String membershipStatus;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const MemberCard({
    super.key,
    required this.name,
    required this.plan,
    this.imageUrl = '',
    this.membershipExpiryDate,
    this.paymentStatus = 'Paid',
    this.membershipStatus = 'Active',
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      
      
      child: InkWell(
  borderRadius: BorderRadius.circular(14),
  onTap: onTap,
  splashColor: primaryColor.withOpacity(0.08),
  highlightColor: Colors.transparent,
  child: Stack(
    children: [
      // Main content
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.grey.shade100,
              child: ClipOval(
                child: imageUrl.isNotEmpty
                    ? Image.asset(
                        imageUrl,
                        width: 52,
                        height: 52,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildFallbackAvatar(),
                      )
                    : _buildFallbackAvatar(),
              ),
            ),
            const SizedBox(width: 14),

            // Member info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[900],
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    plan,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      if (membershipExpiryDate != null)
                        Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                size: 12, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              'Expires: ${_formatDate(membershipExpiryDate!)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: membershipStatus == 'Expired'
                                        ? Colors.redAccent
                                        : Colors.grey[700],
                                    fontSize: 12,
                                  ),
                            ),
                          ],
                        ),
                      if (membershipExpiryDate != null) const SizedBox(width: 10),
                      _buildStatusChip(
                        paymentStatus,
                        paymentStatus == 'Paid'
                            ? Colors.green
                            : Colors.redAccent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Popup menu — pinned to absolute top-right
      if (onEdit != null || onDelete != null)
        Positioned(
          top: 4, // small offset for balance
          right: 4,
          child: _buildPopupMenu(context),
        ),
    ],
  ),
)

    );
  }

  Widget _buildFallbackAvatar() {
    return Container(
      color: primaryColor.withOpacity(0.15),
      width: 52,
      height: 52,
      alignment: Alignment.center,
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : '?',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  Widget _buildStatusChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.4), width: 0.8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 11,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Widget _buildPopupMenu(BuildContext context) {
    return PopupMenuButton<String>(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      icon: const Icon(Icons.more_vert, color: Colors.black87),
      itemBuilder: (BuildContext context) => [
        if (onEdit != null)
          const PopupMenuItem<String>(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit, size: 20, color: Colors.blue),
                SizedBox(width: 10),
                Text('Edit', style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
        if (onDelete != null)
          const PopupMenuItem<String>(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete, size: 20, color: Colors.red),
                SizedBox(width: 10),
                Text('Delete', style: TextStyle(fontSize: 15, color: Colors.red)),
              ],
            ),
          ),
      ],
      onSelected: (value) {
        if (value == 'edit' && onEdit != null) onEdit!();
        if (value == 'delete' && onDelete != null) onDelete!();
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}
