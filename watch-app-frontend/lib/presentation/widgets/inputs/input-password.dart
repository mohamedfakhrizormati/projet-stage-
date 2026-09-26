import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    super.key,
    required this.text,
    required this.controller,
    required this.validator,
  });
  final String text;
  final TextEditingController controller;
  final String? Function(String?) validator;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

bool obs = true;

class _PasswordInputState extends State<PasswordInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: TextFormField(
        obscureText: obs,
        controller: widget.controller,
        validator: widget.validator,
        decoration: InputDecoration(
          labelText: widget.text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          prefixIcon: const Icon(Icons.password_outlined),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obs = !obs;
              });
            },
            icon: Icon(obs ? Icons.visibility : Icons.visibility_off),
          ),
        ),
      ),
    );
  }
}
