// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class UserNameFormField extends StatelessWidget {
  final Function setUserName;
  final String? ininValue;
  final bool? readOnly;
  const UserNameFormField(
      {Key? key, required this.setUserName, this.ininValue, this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        readOnly: readOnly ?? false,
        initialValue: ininValue,
        decoration: InputDecoration(
          labelText: 'Enter your Name',
          labelStyle: TextStyle(
              fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
          prefixIcon: Icon(
            Icons.person,
            color: Theme.of(context).colorScheme.primary,
          ),
          helperText: 'Name must be +6 characters',
          helperStyle: const TextStyle(fontSize: 15),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 2, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        validator: (String? value) {
          if (value == null || value.length < 6 || value.length > 15) {
            return 'Please Enter a valid Name';
          }
        },
        onSaved: (String? value) {
          setUserName(value!);
        });
  }
}
