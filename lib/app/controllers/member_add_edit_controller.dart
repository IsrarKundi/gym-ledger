import 'package:get/get.dart';

class MemberEditController extends GetxController {
  final name = ''.obs;
  final phone = ''.obs;
  final plan = 'Monthly'.obs;
  final joiningDate = DateTime.now().obs;
}
