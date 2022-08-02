import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'dart:convert';

part 'themes_state.dart';

class ThemesCubit extends Cubit<ThemesState> with HydratedMixin {
  ThemesCubit() : super(const ThemesState(themeIndex: 0));

  void getStoredTheme() async {}
  void changeTheme(int index) {
    emit(ThemesState(themeIndex: index));
  }

  @override
  ThemesState? fromJson(Map<String, dynamic> json) {
    return ThemesState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemesState state) {
    return state.toMap();
  }
}
