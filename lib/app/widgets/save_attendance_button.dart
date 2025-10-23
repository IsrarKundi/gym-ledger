import 'package:flutter/material.dart';
import 'package:gymledger/app/models/utils/colors.dart';

/// Minimalistic, professional save button used on the Attendance screen.
class SaveAttendanceButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;

  const SaveAttendanceButton({
    super.key,
    this.label = 'Save Attendance',
    required this.onPressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    // final primary = Theme.of(context).primaryColor;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          shadowColor: primaryColor.withOpacity(0.2),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: loading
              ? SizedBox(
                  key: const ValueKey('loading'),
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  label,
                  key: const ValueKey('label'),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
        ),
      ),
    );
  }
}
