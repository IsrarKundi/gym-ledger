import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymledger/app/controllers/auth_controller.dart';
import 'package:gymledger/app/widgets/auth_header.dart';
import 'package:gymledger/app/widgets/auth_text_field.dart';
import 'package:gymledger/app/widgets/auth_button.dart';

class ForgotPasswordView extends StatelessWidget {
  final AuthController controller = Get.find<AuthController>();

  ForgotPasswordView({super.key});

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
              key: controller.forgotPasswordFormKey,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    
                    // Header
                    const AuthHeader(
                      title: 'Reset password',
                      subtitle: 'Enter your email and we\'ll send you a link to reset your password',
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
                    
                    const SizedBox(height: 28),
                    
                    // Send Reset Link Button
                    Obx(() => AuthButton(
                      label: 'Send reset link',
                      onPressed: controller.forgotPassword,
                      isLoading: controller.isLoading.value,
                    )),
                    
                    const SizedBox(height: 24),
                    
                    // Back to Login Link
                    Center(
                      child: TextButton(
                        onPressed: () => Get.back(),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              size: 14,
                              color: Color(0xFF3B82F6),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Back to sign in',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF3B82F6),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 80),
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
