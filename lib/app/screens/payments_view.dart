import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymledger/app/models/utils/colors.dart';
import 'package:gymledger/app/widgets/custom_app_bar.dart';
import '../controllers/payments_controller.dart';

class PaymentsView extends StatelessWidget {
  final PaymentsController controller = Get.put(PaymentsController());

  PaymentsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: CustomAppBar(title: 'Payments'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () => _showAddPaymentDialog(context),
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: 'Add Payment',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Financial Summary Section
            Obx(() => Container(
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
                  _buildFinancialSummaryItem(
                    context,
                    icon: Icons.trending_up,
                    label: 'Total Income',
                    amount: controller.formatCurrency(controller.totalIncome),
                    color: Colors.green,
                  ),
                  _verticalDivider(),
                  _buildFinancialSummaryItem(
                    context,
                    icon: Icons.pending_actions,
                    label: 'Total Due',
                    amount: controller.formatCurrency(controller.totalDue),
                    color: Colors.orange,
                  ),
                ],
              ),
            )),
            
            const SizedBox(height: 10),
            
            // Filter Row
            Row(
              children: [
                Expanded(
                  child: Obx(() => _modernDropdown(
                    context,
                    controller.statusFilter,
                    ['All', 'Paid', 'Unpaid'],
                  )),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Obx(() => _modernDropdown(
                    context,
                    controller.monthFilter,
                    ['All', 'Current Month', 'Overdue'],
                  )),
                ),
              ],
            ),
            
            const SizedBox(height: 10),
            
            // Status Summary Row
            Obx(() {
              final paidCount = controller.paidCount;
              final unpaidCount = controller.unpaidCount;
              
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryItem(
                      context,
                      icon: Icons.check_circle,
                      label: 'Paid',
                      count: paidCount,
                      color: Colors.green,
                    ),
                    _verticalDivider(),
                    _buildSummaryItem(
                      context,
                      icon: Icons.pending,
                      label: 'Unpaid',
                      count: unpaidCount,
                      color: Colors.orange,
                    ),
                  ],
                ),
              );
            }),
            
            const SizedBox(height: 10),
            
            // Payment Records List
            SizedBox(
              height: 400,
              child: Obx(() {
                final filteredRecords = controller.filteredRecords;
                if (filteredRecords.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text(
                        'No payment records found',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  );
                }
                
                return ListView.builder(
                  itemCount: filteredRecords.length,
                  itemBuilder: (context, index) {
                    final record = filteredRecords[index];
                    final isPaid = record['paid'] as bool;
                    final amount = record['amount'] as double;
                    final lastPaymentDate = record['lastPaymentDate'] as DateTime;
                    final dueDate = record['dueDate'] as DateTime;
                    final planType = record['planType'] as String;
                    
                    final isOverdue = !isPaid && dueDate.isBefore(DateTime.now());
                    
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
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Status Icon
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: isPaid 
                                        ? Colors.green.withOpacity(0.1) 
                                        : isOverdue 
                                            ? Colors.red.withOpacity(0.1)
                                            : Colors.orange.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    isPaid 
                                        ? Icons.check_circle 
                                        : isOverdue 
                                            ? Icons.warning 
                                            : Icons.pending,
                                    color: isPaid 
                                        ? Colors.green 
                                        : isOverdue 
                                            ? Colors.red 
                                            : Colors.orange,
                                    size: 32,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                
                                // Member Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        record['name'],
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: isPaid 
                                                  ? Colors.green.withOpacity(0.2) 
                                                  : isOverdue 
                                                      ? Colors.red.withOpacity(0.2)
                                                      : Colors.orange.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              isPaid 
                                                  ? 'Paid' 
                                                  : isOverdue 
                                                      ? 'Overdue' 
                                                      : 'Unpaid',
                                              style: TextStyle(
                                                color: isPaid 
                                                    ? Colors.green[800] 
                                                    : isOverdue 
                                                        ? Colors.red[800]
                                                        : Colors.orange[800],
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            planType,
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                
                                // Amount
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      controller.formatCurrency(amount),
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: isPaid ? Colors.green : Colors.red,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      isPaid 
                                          ? 'Paid: ${controller.formatDate(lastPaymentDate)}'
                                          : 'Due: ${controller.formatDate(dueDate)}',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            
                            // Action Buttons Row
                            if (!isPaid) ...[
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      controller.markAsPaid(record['id']);
                                      Get.snackbar(
                                        'Payment Updated',
                                        '${record['name']} marked as paid',
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.green,
                                        colorText: Colors.white,
                                        duration: const Duration(seconds: 2),
                                      );
                                    },
                                    icon: const Icon(Icons.check, size: 18),
                                    label: const Text('Mark as Paid'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _verticalDivider() => Container(
        width: 1,
        height: 40,
        color: Colors.grey.shade300,
      );

  Widget _modernDropdown(BuildContext context, RxString value, List<String> items) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color:  Colors.white,
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

  Widget _buildFinancialSummaryItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String amount,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          amount,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
        const SizedBox(height: 4),
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

  void _showAddPaymentDialog(BuildContext context) {
    final nameController = TextEditingController();
    final amountController = TextEditingController();
    String selectedPlan = 'Monthly';
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add Manual Payment'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Member Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: amountController,
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                        prefixText: '\$',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedPlan,
                      decoration: const InputDecoration(
                        labelText: 'Plan Type',
                        border: OutlineInputBorder(),
                      ),
                      items: ['Monthly', 'Yearly'].map((plan) {
                        return DropdownMenuItem(
                          value: plan,
                          child: Text(plan),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedPlan = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty && amountController.text.isNotEmpty) {
                      final amount = double.tryParse(amountController.text);
                      if (amount != null && amount > 0) {
                        final dueDate = selectedPlan == 'Monthly' 
                            ? DateTime.now().add(const Duration(days: 30))
                            : DateTime.now().add(const Duration(days: 365));
                        
                        controller.addPayment(
                          memberId: DateTime.now().millisecondsSinceEpoch.toString(),
                          memberName: nameController.text,
                          amount: amount,
                          planType: selectedPlan,
                          dueDate: dueDate,
                        );
                        
                        Navigator.of(context).pop();
                        
                        Get.snackbar(
                          'Payment Added',
                          'Payment for ${nameController.text} has been recorded',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 2),
                        );
                      } else {
                        Get.snackbar(
                          'Invalid Amount',
                          'Please enter a valid amount',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    } else {
                      Get.snackbar(
                        'Missing Information',
                        'Please fill in all fields',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Add Payment'),
                ),
              ],
            );
          },
        );
      },
    );
  }
  
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
        const SizedBox(height: 8),
        Text(
          count.toString(),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
        const SizedBox(height: 4),
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
