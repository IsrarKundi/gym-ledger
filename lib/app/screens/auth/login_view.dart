import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymledger/app/controllers/auth_controller.dart';
import 'package:gymledger/app/routes/app_routes.dart';
import 'package:gymledger/app/widgets/auth_header.dart';
import 'package:gymledger/app/widgets/auth_text_field.dart';
import 'package:gymledger/app/widgets/auth_button.dart';

class LoginView extends StatelessWidget {
  final AuthController controller = Get.put(AuthController());

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
              key: controller.loginFormKey,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 60),
                    
                    // Header
                    const AuthHeader(
                      title: 'Welcome back',
                      subtitle: 'Sign in to your account to continue',
                    ),
                    
                    const SizedBox(height: 48),
                    
                    // Email Field
                    AuthTextField(
                      controller: controller.emailController,
                      label: 'EMAIL',
                      hintText: 'you@example.com',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: controller.validateEmail,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Password Field
                    AuthTextField(
                      controller: controller.passwordController,
                      label: 'PASSWORD',
                      hintText: 'Enter your password',
                      icon: Icons.lock_outline,
                      isPassword: true,
                      validator: controller.validatePassword,
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Remember Me & Forgot Password Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => Row(
                          children: [
                            SizedBox(
                              height: 18,
                              width: 18,
                              child: Checkbox(
                                value: controller.rememberMe.value,
                                onChanged: controller.toggleRememberMe,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                side: const BorderSide(
                                  color: Color(0xFFD1D5DB),
                                  width: 1.5,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Remember me',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6B7280),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )),
                        TextButton(
                          onPressed: () => Get.toNamed('/forgot-password'),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF3B82F6),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 28),
                    
                    // Login Button
                    Obx(() => AuthButton(
                      label: 'Sign in',
                      onPressed: controller.login,
                      isLoading: controller.isLoading.value,
                    )),
                    
                    const SizedBox(height: 32),
                    
                    // Register Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6B7280),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Get.toNamed(AppRoutes.SIGNUP ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF3B82F6),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
