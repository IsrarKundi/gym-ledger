import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/member_add_edit_controller.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/app_button.dart';

class MemberAddEditView extends StatelessWidget {
  final MemberEditController controller = Get.put(MemberEditController());

  MemberAddEditView({super.key});

  @override
  Widget build(BuildContext context) {
    final arg = Get.arguments;
    if (arg != null) {
      controller.name.value = (arg as dynamic).name ?? '';
      controller.phone.value = (arg as dynamic).phone ?? '';
      controller.plan.value = (arg as dynamic).plan ?? 'Monthly';
    }

    return Scaffold(
      appBar: AppBar(title: Text(arg != null ? 'Edit Member' : 'Add Member')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AppTextField(label: 'Name', controller: TextEditingController(text: controller.name.value)),
            const SizedBox(height: 12),
            AppTextField(label: 'Phone', controller: TextEditingController(text: controller.phone.value), keyboardType: TextInputType.phone),
            const SizedBox(height: 12),
            Obx(() => DropdownButtonFormField<String>(
                  value: controller.plan.value,
                  items: ['Monthly', 'Quarterly', 'Yearly'].map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
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
            AppButton(label: arg != null ? 'Save Changes' : 'Add Member', onPressed: () {
              // No real save, just pop
              Get.back();
            })
          ],
        ),
      ),
    );
  }
}
