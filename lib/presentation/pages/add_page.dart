// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lostsapp/constants/list_of_classification.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/logic/cubit/post_item_cubit.dart';
import 'package:lostsapp/presentation/widgets/add_page_widgets/image.dart';
import 'package:lostsapp/presentation/widgets/awesome_dia.dart';

/* import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:lostsapp/constants/env.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart'; */

part '../widgets/add_page_widgets/form_fields.dart';

Map<String, dynamic> _formData = {};

TextEditingController _timeTextController = TextEditingController();
TextEditingController _typeTextController = TextEditingController();
DateTime _nowDT = DateTime.now();

class AddPage extends StatefulWidget {
  final Function onTapped;
  const AddPage({
    Key? key,
    required this.onTapped,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddPageState();
  }
}

class AddPageState extends State<AddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _typeTextController.clear();
    _timeTextController.clear();

    super.dispose();
  }

  void _selectImage(XFile imageF) {
    _formData["imageFile"] = imageF;
  }

  Future<void> _submitForm(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    await BlocProvider.of<PostItemCubit>(context)
        .postItem(_formData, BlocProvider.of<AuthCubit>(context).user!.token);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double tagetPadding = width > 600 ? width / 2 / 2 : width / 5 / 2;
    return BlocListener<PostItemCubit, PostItemState>(
        listener: (context, state) {
          if (state is PostItemFailed) {
            buildAwrsomeDia(context, "Post Failed", state.message, "OK").show();
          } else if (state is PostItemSuccessed) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                "POSTED SUCCESSFULLY",
              ),
              duration: Duration(seconds: 1),
            ));
            widget.onTapped(0);
          }
        },
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: tagetPadding, vertical: 30.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTitleTextFormField(context),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildDescriptionTextFormField(context),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildDateTimeTextFormField(context),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildtypeOfItemTextFormField(context),
                  const SizedBox(height: 16),
                  _buildCategoryDropDownMenu(context),
                  const SizedBox(height: 16),
                  _buildLocationDropDownMenu(),
                  const SizedBox(height: 16),
                  ImageField(
                    selectImage: _selectImage,
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<PostItemCubit, PostItemState>(
                    builder: (context, state) {
                      if (state is PostItemProgress) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () async {
                          _submitForm(context);
                        },
                        child: const Text('Save'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
