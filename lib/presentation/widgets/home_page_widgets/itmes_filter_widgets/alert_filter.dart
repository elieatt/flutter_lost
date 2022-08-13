// ignore_for_file: public_member_api_docs, sort_constructors_first
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constants/list_of_classification.dart';
import '../../../../logic/cubit/auth_cubit.dart';
import '../../../../logic/cubit/items_cubit.dart';
import 'filter_category.dart';
import 'filter_governorate.dart';

class AlertFilter extends StatefulWidget {
  final int htcIndex;
  const AlertFilter({
    Key? key,
    required this.htcIndex,
  }) : super(key: key);

  @override
  State<AlertFilter> createState() => _AlertFilterState();
}

///******************************************Settres ************************************************ */
///
///
///
///
class _AlertFilterState extends State<AlertFilter> {
  String? _category;
  String? _governorate;
  void _categorySetter(String category) {
    setState(() {
      _category = category;
    });
  }

  void _governorateSetter(String gover) {
    setState(() {
      _governorate = gover;
    });
  }

  ///*******************************Widgets builders*************************************************** */
  ///
  ///
  ///
  ///
  Widget _buildCategorySection(BuildContext context) {
    return _category != null
        ? GestureDetector(
            onTap: () => showCategoryFilterDialog(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _category!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(
                  width: 6,
                ),
                FaIcon(toIcon(_category!),
                    color: Theme.of(context).colorScheme.secondary),
              ],
            ),
          )
        : TextButton.icon(
            onPressed: () {
              showCategoryFilterDialog(context);
            },
            icon: const Icon(
              Icons.class_,
            ),
            //color: Colors.blue,

            label: const Text("Category      Filter"));
  }

  Widget _buildGovernorateSection(BuildContext context) {
    return _governorate != null
        ? GestureDetector(
            onTap: () => _showGovernorateDialog(context),
            child: Center(
              child: Text(
                _governorate!,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
            ),
          )
        : TextButton.icon(
            onPressed: () {
              _showGovernorateDialog(context);
            },
            icon: const Icon(
              Icons.location_on,
            ),
            label: const Text("Governorate Filter"));
  }

  Widget _buildDialogButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            }),
        ElevatedButton(
          onPressed: (_category == null || _governorate == null)
              ? null
              : () async {
                  await context.read<ItemsCubit>().filterItems(
                      context.read<AuthCubit>().getUser().token,
                      widget.htcIndex == 0 ? false : true,
                      _category!,
                      _governorate!,
                      false);
                  context.read<ItemsCubit>().setFiltredStatusTrue();
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Items have been filtered")));
                },
          child: const Text(
            "Apply",
          ),
        )
      ],
    );
  }

  ///*********************************Main build method**************************************** *//
  ///
  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text('Apply a filter'),
      ),
      content: SizedBox(
        width: double.maxFinite, //<- this line is important
        child: ListView(
          shrinkWrap: true, //<- this line is important
          children: <Widget>[
            _buildCategorySection(context),
            const SizedBox(
              height: 10,
            ),
            _buildGovernorateSection(context),
            const SizedBox(
              height: 20,
            ),
            _buildDialogButtons(context)
          ],
        ),
      ),
    );
  }

  ///*****************************Show dialogs methods********************************************** */
  ///
  ///
  ///
  ///
  void _showGovernorateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text("Choose a Location"),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: FilterGovernorate(
              governorateSetter: _governorateSetter,
            ),
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void showCategoryFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text("Choose a Category"),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: FilterCategory(
              categorySetter: _categorySetter,
            ),
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK")),
            ),
          ],
        );
      },
    );
  }
}
