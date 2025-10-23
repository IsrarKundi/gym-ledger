import 'package:get/get.dart';
import 'package:gymledger/app/screens/auth/forgot_password_view.dart';
import 'package:gymledger/app/screens/auth/login_view.dart';
import 'package:gymledger/app/screens/auth/register_view.dart';
import '../screens/splash_screen.dart';
import '../screens/dashboard/dashboard_view.dart';
import '../screens/members/members_list_view.dart';
import '../screens/members/member_add_edit_view.dart';
import '../screens/attendance_view.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.SPLASH;

  static final pages = [
    GetPage(name: AppRoutes.SPLASH, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.DASHBOARD, page: () => DashboardView()),
    GetPage(name: AppRoutes.MEMBERS, page: () => MembersListView()),
    GetPage(name: AppRoutes.MEMBER_ADD, page: () => MemberAddEditView()),
    GetPage(name: AppRoutes.ATTENDANCE, page: () => AttendanceView()),
    GetPage(name: AppRoutes.LOGIN, page: () => LoginView()),
    GetPage(name: AppRoutes.SIGNUP, page: () => RegisterView()),
    GetPage(name: AppRoutes.FORGOT_PASSWORD, page: () => ForgotPasswordView()),
    
    // GetPage(name: AppRoutes.PAYMENTS, page: () => PaymentsView()),
  ];
}
