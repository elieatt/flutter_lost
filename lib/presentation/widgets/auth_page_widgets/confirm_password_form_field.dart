import 'package:flutter/material.dart';

class ConfirmPasswordFormField extends StatelessWidget {
  final Function getPassword;

  const ConfirmPasswordFormField({Key? key, required this.getPassword})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
          labelText: 'Confirm Password',
          labelStyle: TextStyle(
              fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
          prefixIcon: Icon(
            Icons.mode_edit,
            color: Theme.of(context).colorScheme.primary,
          ),
          helperText: 'Password must be More Than 8',
          helperStyle: const TextStyle(fontSize: 15),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 2, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        obscureText: true,
        validator: (String? value) {
          // ignore: unrelated_type_equality_checks
          if (value != getPassword()) return 'Passwords dont match';
        });
  }
}
