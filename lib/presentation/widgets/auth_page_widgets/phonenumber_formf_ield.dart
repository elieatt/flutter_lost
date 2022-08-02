import 'package:flutter/material.dart';

class PhoneNumberFormField extends StatelessWidget {
  final Function setPhoneNumber;
  final String? initValue;

  const PhoneNumberFormField(
      {Key? key, required this.setPhoneNumber, this.initValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLength: 13,
        initialValue: initValue ?? "+963",
        //controller: _phoneNumberController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: 'Enter your phone number',
          labelStyle: TextStyle(
              fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
          prefixIcon: Icon(
            Icons.phone,
            color: Theme.of(context).colorScheme.primary,
          ),
          helperText: 'Phone number must start with +963',
          helperStyle: const TextStyle(fontSize: 15),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 2, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        validator: (String? value) {
          if (value == null ||
              value.length < 13 ||
              value.substring(0, 5) != '+9639') {
            return 'Please Enter a valid phone Number';
          }
        },
        onSaved: (String? value) {
          setPhoneNumber(value);
        });
  }
}
