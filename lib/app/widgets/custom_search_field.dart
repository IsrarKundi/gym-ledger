import 'package:flutter/material.dart';

/// A small, reusable search text field with clear button and consistent styling.
class CustomSearchField extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final String? initialValue;
  final Widget? prefixIcon;

  const CustomSearchField({
    super.key,
    this.hintText = 'Search...',
    this.onChanged,
    this.initialValue,
    this.prefixIcon,
  });

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    widget.onChanged?.call('');
    setState(() {});
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Colors.white,
        width: 1.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: (v) {
        widget.onChanged?.call(v);
        setState(() {});
      },
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon ?? const Icon(Icons.search, color: Colors.grey),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        filled: true,
        fillColor:  Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: _buildBorder(),
        enabledBorder: _buildBorder(),
        focusedBorder: _buildBorder(),
        disabledBorder: _buildBorder(),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                onPressed: _clear,
                icon: Icon(Icons.clear, color: Colors.grey[600]),
              )
            : null,
      ),
    );
  }
}
