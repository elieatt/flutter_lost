// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ContactButtons extends StatelessWidget {
  final Function contactViaWhatsapp;
  final Function contactViaEmail;
  final Function contactViaPhoneCall;
  final String phoneNumber, email;

  // ignore: prefer_const_constructors_in_immutables
  ContactButtons(
      {Key? key,
      required this.email,
      required this.phoneNumber,
      required this.contactViaWhatsapp,
      required this.contactViaEmail,
      required this.contactViaPhoneCall});

  Widget _buildContactTextButtonChild(String title, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        Icon(
          icon,
          color: Colors.white,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 20),
          child: ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green)),
                onPressed: () async {
                  await contactViaWhatsapp(phoneNumber);
                },
                child: _buildContactTextButtonChild(
                    "Contact via whatsapp", Icons.whatsapp),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red)),
                onPressed: () async {
                  await contactViaEmail(email);
                },
                child: _buildContactTextButtonChild(
                    "Contact via email", Icons.email),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue)),
                  onPressed: () async {
                    contactViaPhoneCall(phoneNumber);
                  },
                  child:
                      _buildContactTextButtonChild("Call Sender", Icons.phone))
            ],
          ),
        )
      ],
    );
  }
}
