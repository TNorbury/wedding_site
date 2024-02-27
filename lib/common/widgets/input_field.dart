import 'dart:async';

import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String label;
  final int? maxLines;
  final String? helperText;
  final TextEditingController controller;
  final String? errorText;

  /// called when the value of the input has changed and can be read from the
  /// associated controller
  final VoidCallback onChanged;
  const InputField({
    Key? key,
    required this.controller,
    required this.label,
    required this.onChanged,
    this.maxLines,
    this.helperText,
    this.errorText,
  }) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _setDebounce() {
    _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 500),
      widget.onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.label,
        helperText: widget.helperText,
        errorText: widget.errorText,
      ),
      maxLines: widget.maxLines,
      onChanged: (_) => _setDebounce(),
      onFieldSubmitted: (_) => _setDebounce(),
      onEditingComplete: () => _setDebounce(),
    );
  }
}
