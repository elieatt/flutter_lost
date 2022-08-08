import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lostsapp/logic/cubit/themes_cubit.dart';
import 'package:lostsapp/presentation/widgets/settings_page_widgets/theme_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

int _colorIndex = 0;
void _setColorIndex(int index) {
  _colorIndex = index;
}

Future<int> _showChooseThemeDialog<int>(BuildContext context) async {
  return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
              title: const Text(
                "Choose a theme",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [0, 1, 2, 3, 4]
                      .map((e) =>
                          ThemeButton(setColorIndex: _setColorIndex, index: e))
                      .toList())),
        );
      });
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 20, right: 50, left: 50),
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("My Account"),
                onTap: () =>
                    Navigator.of(context).pushNamed("/accountSettings"),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.color_lens),
                title: const Text("Themes"),
                onTap: () async {
                  await _showChooseThemeDialog(context);
                  context.read<ThemesCubit>().changeTheme(_colorIndex);
                },
              )
            ],
          )),
    );
  }
}
