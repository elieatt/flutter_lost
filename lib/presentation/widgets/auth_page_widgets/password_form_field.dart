import 'package:flutter/material.dart';

class PasswordFormField extends StatelessWidget {
  final Function setPassword;
  final String? label;

  const PasswordFormField({Key? key, required this.setPassword, this.label})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label ?? 'Password',
        labelStyle: TextStyle(
            fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
        prefixIcon: Icon(
          Icons.password,
          color: Theme.of(context).colorScheme.primary,
        ),
        helperText: 'Password must be More Than 6',
        helperStyle: const TextStyle(fontSize: 15),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 2, color: Theme.of(context).colorScheme.primary),
        ),
      ),
      obscureText: true,
      validator: (String? value) {
        if (value!.isEmpty || value.length < 5) {
          return 'Password  must be +5 chars';
        }
      },
      onChanged: (String value) {
        setPassword(value);
      },
      onSaved: (String? value) {
        setPassword(value);
      },
    );
  }
}
