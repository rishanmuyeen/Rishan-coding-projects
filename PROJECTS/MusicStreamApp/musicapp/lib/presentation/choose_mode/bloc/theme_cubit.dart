import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void updateTheme(ThemeMode themeMode) => emit(themeMode);

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    // Convert saved JSON data into ThemeMode
    final themeIndex = json['themeMode'] as int?;
    if (themeIndex == null) return ThemeMode.system;
    return ThemeMode.values[themeIndex];
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    // Convert current ThemeMode state into JSON data
    return {'themeMode': state.index};
  }
}
