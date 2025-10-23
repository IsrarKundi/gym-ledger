import 'package:get/get.dart';

class AddMemberController extends GetxController {
  final name = ''.obs;
  final phone = ''.obs;
  final address = ''.obs;
  final plan = 'Monthly'.obs;
  final joiningDate = DateTime.now().obs;

  void save() {
    // Print values for now (no real persistence)
    print('Saving member: name=${name.value}, phone=${phone.value}, address=${address.value}, plan=${plan.value}, joining=${joiningDate.value}');
  }
}
