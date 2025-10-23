import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymledger/app/controllers/auth_controller.dart';
import 'package:gymledger/app/widgets/auth_header.dart';
import 'package:gymledger/app/widgets/auth_text_field.dart';
import 'package:gymledger/app/widgets/auth_button.dart';

class RegisterView extends StatelessWidget {
  final AuthController controller = Get.find<AuthController>();

  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF111827), size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
              key: controller.registerFormKey,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    
                    // Header
                    const AuthHeader(
                      title: 'Create account',
                      subtitle: 'Start managing your gym with ease',
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Name Field
                    AuthTextField(
                      controller: controller.nameController,
                      label: 'FULL NAME',
                      hintText: 'John Doe',
                      icon: Icons.person_outline,
                      validator: controller.validateName,
                    ),
                    
                    const SizedBox(height: 20),
                    
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
                      hintText: 'Create a password',
                      icon: Icons.lock_outline,
                      isPassword: true,
                      validator: controller.validatePassword,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Confirm Password Field
                    AuthTextField(
                      controller: controller.confirmPasswordController,
                      label: 'CONFIRM PASSWORD',
                      hintText: 'Re-enter your password',
                      icon: Icons.lock_outline,
                      isPassword: true,
                      validator: controller.validateConfirmPassword,
                    ),
                    
                    const SizedBox(height: 28),
                    
                    // Register Button
                    Obx(() => AuthButton(
                      label: 'Create account',
                      onPressed: controller.register,
                      isLoading: controller.isLoading.value,
                    )),
                    
                    const SizedBox(height: 28),
                    
                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6B7280),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Get.back(),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF3B82F6),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 40),
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
