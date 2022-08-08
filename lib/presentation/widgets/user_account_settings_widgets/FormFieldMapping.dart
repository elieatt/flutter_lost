import 'package:flutter/material.dart';
import 'package:lostsapp/constants/enums.dart';
import 'package:lostsapp/presentation/widgets/auth_page_widgets/confirm_password_form_field.dart';
import 'package:lostsapp/presentation/widgets/auth_page_widgets/password_form_field.dart';
import 'package:lostsapp/presentation/widgets/auth_page_widgets/phonenumber_formf_ield.dart';
import 'package:lostsapp/presentation/widgets/auth_page_widgets/user_name_form_field.dart';

class FormFieldsMapping {
  static Widget? mapFieldTypeToFormField(EditAccountType type, Function setter,
      String? initValue, Function? newPasswordSetter, Function? getPasword) {
    switch (type) {
      case EditAccountType.userName:
        return UserNameFormField(
          setUserName: setter,
          ininValue: initValue,
        );

      case EditAccountType.phoneNumber:
        return PhoneNumberFormField(
          setPhoneNumber: setter,
          initValue: initValue,
        );

      case EditAccountType.password:
        return Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PasswordFormField(setPassword: setter, label: "Old password"),
            const SizedBox(
              height: 15.0,
            ),
            PasswordFormField(
              setPassword: newPasswordSetter!,
              label: "New password",
            ),
            const SizedBox(
              height: 15.0,
            ),
            ConfirmPasswordFormField(
              getPassword: getPasword!,
            )
          ],
        );
    }
  }
}
