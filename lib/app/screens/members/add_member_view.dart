import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymledger/app/widgets/custom_app_bar.dart';
import '../../controllers/add_member_controller.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/app_button.dart';

class AddMemberView extends StatelessWidget {
  final AddMemberController controller = Get.put(AddMemberController());

  AddMemberView({super.key});

  @override
  Widget build(BuildContext context) {
    final arg = Get.arguments;
    
    // Safely extract values with fallbacks
    String name = '';
    String phone = '';
    String address = '';
    
    if (arg != null) {
      try {
        name = (arg as dynamic).name?.toString() ?? '';
        phone = (arg as dynamic).phone?.toString() ?? '';
        address = (arg as dynamic).address?.toString() ?? '';
        
        // Prefill plan and joining date if available
        final planValue = (arg as dynamic).plan?.toString();
        if (planValue != null && planValue.isNotEmpty) {
          controller.plan.value = planValue;
        }
        
        final joiningDateValue = (arg as dynamic).joiningDate;
        if (joiningDateValue != null && joiningDateValue is DateTime) {
          controller.joiningDate.value = joiningDateValue;
        }
      } catch (e) {
        print('Error parsing member data: $e');
      }
    }
    
    final nameController = TextEditingController(text: name);
    final phoneController = TextEditingController(text: phone);
    final addressController = TextEditingController(text: address);

    return Scaffold(
      appBar: CustomAppBar(title: arg != null ? 'Edit Member' : 'Add Member'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AppTextField(label: 'Name', controller: nameController),
            const SizedBox(height: 12),
            AppTextField(label: 'Phone', controller: phoneController, keyboardType: TextInputType.phone),
            const SizedBox(height: 12),
            AppTextField(label: 'Address', controller: addressController),
            const SizedBox(height: 12),
            Obx(() => DropdownButtonFormField<String>(
                  value: controller.plan.value,
                  items: ['Monthly', 'Quarterly', 'Yearly', 'Personal Training'].map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                  onChanged: (v) => controller.plan.value = v ?? 'Monthly',
                  decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)), labelText: 'Plan'),
                )),
            const SizedBox(height: 12),
            Obx(() => Row(
                  children: [
                    Text('Joining: ${controller.joiningDate.value.toLocal().toString().split(' ')[0]}'),
                    const SizedBox(width: 12),
                    ElevatedButton(onPressed: () async {
                      final dt = await showDatePicker(context: context, initialDate: controller.joiningDate.value, firstDate: DateTime(2000), lastDate: DateTime(2100));
                      if (dt != null) controller.joiningDate.value = dt;
                    }, child: const Text('Pick'))
                  ],
                )),
            const Spacer(),
            AppButton(label: 'Save Member', onPressed: () {
              controller.name.value = nameController.text;
              controller.phone.value = phoneController.text;
              controller.address.value = addressController.text;
              controller.save();
              Get.back();
            })
          ],
        ),
      ),
    );
  }
}
