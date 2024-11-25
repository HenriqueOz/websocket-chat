import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_flutter/app/core/bloc/app_theme_cubit/app_theme_cubit.dart';

class ThemeSelector extends BlocSelector<AppThemeCubit, AppThemeState, ThemeMode?> {
  // ignore: use_super_parameters
  ThemeSelector({
    super.key,
    required Widget Function(BuildContext context, ThemeMode? themeMode) builder,
  }) : super(
          builder: builder,
          selector: (state) {
            if (state is AppThemeData) {
              return state.themeMode;
            }
            return null;
          },
        );
}
