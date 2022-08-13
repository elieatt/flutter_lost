// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lostsapp/constants/enums.dart';
import 'package:lostsapp/presentation/widgets/user_account_settings_widgets/edit_form.dart';

import '../../../logic/cubit/edit_user_info_cubit.dart';

class UserCredentialCardView extends StatelessWidget {
  final String title;
  final String credientalValue;
  final IconData icon;
  final bool editable;
  final EditAccountType? editType;

  const UserCredentialCardView({
    Key? key,
    required this.title,
    required this.credientalValue,
    required this.icon,
    required this.editable,
    this.editType,
  }) : super(key: key);

  Future<void> _showEditFormDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext _) {
          return AlertDialog(
              title: const Text("Edit"),
              alignment: Alignment.center,
              content: Container(

/*                   padding: const EdgeInsets.only(
                      right: 20, left: 20, top: 40, bottom: 20), */
                  height: editType == EditAccountType.password ? 350 : 165,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: BlocProvider.value(
                      value: context.read<EditUserInfoCubit>(),
                      child: EditForm(editType: editType!))));
        });
  }

  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: 200,
      height: 160,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: Theme.of(context).colorScheme.background.withOpacity(0.7),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.7),
                        maxRadius: 23,
                        child: Icon(
                          icon,
                          size: 30,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      !editable ? Container() : const SizedBox(height: 10),
                      !editable
                          ? Container()
                          : CircleAvatar(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.7),
                              maxRadius: 23,
                              child: IconButton(
                                  onPressed: () async {
                                    _showEditFormDialog(context);
                                  },
                                  icon: Icon(Icons.edit,
                                      size: 30,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground)),
                            )
                    ]),
              ),
              SizedBox(
                height: 120,
                width: pageWidth / 1.6,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  color: Theme.of(context).colorScheme.primary,
                  child: Center(
                    child: Text(
                      credientalValue,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
