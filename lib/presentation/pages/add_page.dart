// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lostsapp/constants/list_of_classification.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/logic/cubit/items_cubit.dart';
import 'package:lostsapp/logic/cubit/post_item_cubit.dart';
import 'package:lostsapp/presentation/widgets/add_page_widgets/image.dart';
import 'package:lostsapp/presentation/widgets/dialogs/awesome_dia.dart';

part '../widgets/add_page_widgets/form_fields.dart';

Map<String, dynamic> _formData = {};

TextEditingController _timeTextController = TextEditingController();
TextEditingController _typeTextController = TextEditingController();
DateTime _nowDT = DateTime.now();

class AddPage extends StatefulWidget {
  final Function onTapped;
  final TabController htb;
  AddPage({
    Key? key,
    required this.onTapped,
    required this.htb,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddPageState();
  }
}

class AddPageState extends State<AddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _formData.clear();
    _timeTextController.clear();
    _typeTextController.clear();
    _formKey.currentState?.reset();

    super.initState();
  }

  @override
  void dispose() {
    _formData.clear();
    _formKey.currentState?.reset();
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
    await BlocProvider.of<PostItemCubit>(context).postItem(
        _formData, BlocProvider.of<AuthCubit>(context).getUser().token);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double tagetPadding = width > 600 ? width / 2 / 2 : width / 5 / 2;
    return BlocListener<PostItemCubit, PostItemState>(
        listener: (context, state) async {
          if (state is PostItemFailed) {
            buildAwrsomeDia(context, "Post Failed", state.message, "OK").show();
          } else if (state is PostItemSuccessed) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                "POSTED SUCCESSFULLY",
              ),
              duration: Duration(seconds: 1),
            ));
            final String token = context.read<AuthCubit>().getUser().token;
            context.read<ItemsCubit>().posted();

            _formData["found"] == "0"
                ? widget.htb.index = 0
                : widget.htb.index = 1;
            /*   widget.htb.index == 1
                ? await context.read<ItemsCubit>().fetchFoundItems(token, true)
                : await context.read<ItemsCubit>().fetchLostItems(token, true); */
            widget.onTapped(0);
            _formData.clear();
            _formKey.currentState?.reset();
            _typeTextController.clear();
            _timeTextController.clear();
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
                  _buildLocationDropDownMenu(context),
                  const SizedBox(height: 16),
                  ImageField(
                    selectImage: _selectImage,
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<PostItemCubit, PostItemState>(
                    builder: (context, state) {
                      if (state is PostItemProgress) {
                        return Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(15),
                          child: const CircularProgressIndicator(),
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
