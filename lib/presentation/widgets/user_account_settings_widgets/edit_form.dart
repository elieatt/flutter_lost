import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostsapp/constants/FormFieldMapping.dart';
import 'package:lostsapp/constants/enums.dart';

import '../../../data/models/user.dart';
import '../../../logic/cubit/auth_cubit.dart';

class EditForm extends StatefulWidget {
  final EditAccountType editType;

  const EditForm({Key? key, required this.editType}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return EditFormState();
  }
}

class EditFormState extends State<EditForm> {
  late GlobalKey<FormState> _formKey;
  late User _user;

  late String _userName, _phoneNumber;
  String? _password = null, _newPassword = null;
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _user = context.read<AuthCubit>().getUser();
    _userName = _user.userName;

    _phoneNumber = _user.phoneNumber;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _setter(String value) {
    switch (widget.editType) {
      case EditAccountType.userName:
        _userName = value;
        break;
      case EditAccountType.phoneNumber:
        _phoneNumber = value;
        break;
      case EditAccountType.password:
        _password = value;
        break;
    }
  }

  String? _initValue() {
    switch (widget.editType) {
      case EditAccountType.userName:
        return _userName;
        break;
      case EditAccountType.phoneNumber:
        return _phoneNumber;
        break;
      case EditAccountType.password:
        return null;
        break;
    }
  }

  void _newPasswordSetter(String value) {
    if (widget.editType == EditAccountType.password) {
      _newPassword = value;
    }
  }

  String _getPassword() {
    return _password!;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: FormFieldsMapping.mapFieldTypeToFormField(widget.editType,
            _setter, _initValue(), _newPasswordSetter, _getPassword)!);
  }
}
