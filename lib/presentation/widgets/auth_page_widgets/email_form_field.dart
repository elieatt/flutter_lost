// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class EmailFormField extends StatelessWidget {
  final String? initValue;
  final Function setEmail;
  const EmailFormField({
    Key? key,
    this.initValue,
    required this.setEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initValue,
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(
          Icons.account_box,
          color: Theme.of(context).colorScheme.primary,
        ),
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 20,
        ),
        helperText: 'Enter your email.',
        helperStyle: const TextStyle(fontSize: 15),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 2, color: Theme.of(context).colorScheme.primary),
        ),
      ),
      keyboardType: TextInputType.text,
      validator: (String? value) {
        if (value == null ||
            value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Enter a valid email.';
        }
      },
      onSaved: (String? value) {
        setEmail(value);
      },
    );
  }
}
