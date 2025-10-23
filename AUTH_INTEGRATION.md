# Auth Screens Integration Guide

## Created Files

### Reusable Widgets (`lib/app/widgets/`)
1. **auth_text_field.dart** - Custom text field with:
   - Icon at top in colored container
   - Label above field
   - Password visibility toggle
   - Form validation support
   - Consistent styling with rounded borders

2. **auth_button.dart** - Primary action button with:
   - Full-width design
   - Loading state with spinner
   - Rounded corners (14px)
   - Customizable colors

3. **auth_header.dart** - Header component with:
   - Optional circular icon
   - Title text
   - Subtitle text
   - Centered alignment

### Controller (`lib/app/controllers/`)
4. **auth_controller.dart** - GetX controller with:
   - Text controllers for all fields
   - Form validation logic
   - Loading states
   - Remember me toggle
   - Login, register, and forgot password methods

### Auth Screens (`lib/app/screens/auth/`)
5. **login_view.dart** - Login screen with:
   - Email and password fields
   - Remember me checkbox
   - Forgot password link
   - Sign up navigation

6. **register_view.dart** - Registration screen with:
   - Full name, email, password, confirm password fields
   - Create account button
   - Back to sign in link

7. **forgot_password_view.dart** - Password reset screen with:
   - Email field
   - Send reset link button
   - Help text with info
   - Back to sign in link

## Design Features

✅ **Consistent with your app's design:**
- Background color: `Color(0xFFF5F7FA)` (matches Members/Attendance/Payments views)
- White rounded cards with subtle shadows
- Professional icon placement at top of each field
- Modern, clean layout with proper spacing

✅ **Modern UI elements:**
- Rounded borders (14px for buttons/cards, 12px for inputs)
- Icons in colored containers above each input field
- Smooth transitions and loading states
- Form validation with error messages

✅ **Reusable components:**
- All widgets are modular and can be reused
- Consistent styling across all auth screens

## Integration Steps

### 1. Add routes to your app (in `main.dart` or routes file):

\`\`\`dart
import 'package:gymledger/app/screens/auth/login_view.dart';
import 'package:gymledger/app/screens/auth/register_view.dart';
import 'package:gymledger/app/screens/auth/forgot_password_view.dart';

// Add to GetMaterialApp routes:
GetMaterialApp(
  initialRoute: '/login',  // or your initial route
  getPages: [
    GetPage(name: '/login', page: () => LoginView()),
    GetPage(name: '/register', page: () => RegisterView()),
    GetPage(name: '/forgot-password', page: () => ForgotPasswordView()),
    GetPage(name: '/dashboard', page: () => DashboardView()),
    // ... your other routes
  ],
);
\`\`\`

### 2. Update AuthController to navigate to your actual dashboard:

In `auth_controller.dart`, the login and register methods currently navigate to `/dashboard`:
\`\`\`dart
Get.offAllNamed('/dashboard');
\`\`\`

Change this to match your actual dashboard route if different.

### 3. Connect to your backend:

Replace the simulated API calls in `auth_controller.dart` with actual API calls:

\`\`\`dart
Future<void> login() async {
  if (loginFormKey.currentState!.validate()) {
    isLoading.value = true;
    
    try {
      // Replace with your actual API call
      final response = await YourApiService.login(
        email: emailController.text,
        password: passwordController.text,
      );
      
      // Store token, update state, etc.
      
      Get.offAllNamed('/dashboard');
      
      Get.snackbar(
        'Success',
        'Welcome back!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
\`\`\`

## Testing

To test the screens:

1. Run your app:
\`\`\`bash
flutter run
\`\`\`

2. Navigate to login screen (if not already set as initial route):
\`\`\`dart
Get.toNamed('/login');
\`\`\`

3. Test flows:
   - Login → Dashboard
   - Login → Register → Login
   - Login → Forgot Password → Login

## Customization

### Change colors:
Edit the primary color in your theme to automatically update all auth screens:
\`\`\`dart
ThemeData(
  primaryColor: Colors.blue,  // Change this
  // ...
)
\`\`\`

### Modify validation rules:
Update validators in `auth_controller.dart`:
\`\`\`dart
String? validatePassword(String? value) {
  // Add your custom validation logic
  if (value!.length < 8) {
    return 'Password must be at least 8 characters';
  }
  return null;
}
\`\`\`

### Add social login buttons:
Add below the OR divider in `login_view.dart`:
\`\`\`dart
// After the OR divider
ElevatedButton.icon(
  onPressed: () {/* Google sign in */},
  icon: Icon(Icons.g_mobiledata),
  label: Text('Continue with Google'),
  style: ElevatedButton.styleFrom(/* styling */),
),
\`\`\`

## Notes

- All screens use GetX for state management (consistent with your existing code)
- Form validation is built-in and works automatically
- Loading states prevent double-submission
- All text fields clear when navigating between screens
- Remember Me checkbox state is preserved in controller
