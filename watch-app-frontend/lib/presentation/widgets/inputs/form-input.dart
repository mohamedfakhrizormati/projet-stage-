import 'package:flutter/material.dart';

class FormInput extends StatefulWidget {
  const FormInput({
    Key? key,
    required this.text,
    required this.controller,
    required this.validator,
    required this.prefixIcon, // Corrected parameter name
    this.hint,
  }) : super(key: key);

  final String text;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final Widget prefixIcon; // Changed type to Widget to allow icons
  final String? hint;

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60, // Adjusted height for better UI
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        decoration: InputDecoration(
          labelText: widget.text,
          hintText: widget.hint, // Added hint text
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                8), // Slightly larger radius for better UI
          ),
          prefixIcon: widget.prefixIcon, // Corrected usage
        ),
      ),
    );
  }
}
