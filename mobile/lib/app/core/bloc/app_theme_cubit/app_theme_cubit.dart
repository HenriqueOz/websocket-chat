import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:websocket_flutter/app/core/hive/hive_boxes.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeInitial());

  final String _appThemeKey = 'app_theme';
  final String _dark = 'dark';
  final String _light = 'light';

  Future<Box<String>> openPreferencesBox() async {
    return await Hive.openBox(HiveBoxes.preferences);
  }

  void _changeThemeBasedOnBrightness({required Brightness brightness}) {
    if (brightness == Brightness.light) {
      changeToLightTheme();
    } else if (brightness == Brightness.dark) {
      changeToDarkTheme();
    }
  }

  void loadTheme({required Brightness brightness}) async {
    final Box<String> preferencesBox = await openPreferencesBox();

    final String? theme = preferencesBox.get(_appThemeKey);

    if (theme == _light) {
      changeToLightTheme();
    } else if (theme == _dark) {
      changeToDarkTheme();
    } else {
      //* caso não exista um registro válido de tema armazenado
      _changeThemeBasedOnBrightness(brightness: brightness);
    }
  }

  Future<void> changeToLightTheme() async {
    final Box<String> preferencesBox = await openPreferencesBox();
    preferencesBox.put(_appThemeKey, _light);
    emit(AppThemeData(themeMode: ThemeMode.light));
  }

  Future<void> changeToDarkTheme() async {
    final Box<String> preferencesBox = await openPreferencesBox();
    preferencesBox.put(_appThemeKey, _dark);
    emit(AppThemeData(themeMode: ThemeMode.dark));
  }
}
