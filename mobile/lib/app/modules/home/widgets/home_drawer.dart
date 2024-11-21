import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_flutter/app/core/bloc/app_theme_cubit/app_theme_cubit.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';
import 'package:websocket_flutter/app/core/strings/strings.dart';
import 'package:websocket_flutter/app/core/widgets/app_theme_selector.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
      backgroundColor: context.colors.surface,
      child: Column(
        children: [
          const SizedBox(
            height: kToolbarHeight,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                Strings.homeDrawerTitle,
                style: context.theme.textTheme.headlineLarge?.copyWith(
                  color: context.colors.onSurface,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                AppThemeSelector(
                  builder: (context, themeMode) {
                    return Switch(
                      value: themeMode == ThemeMode.dark,
                      onChanged: (value) {
                        if (themeMode == ThemeMode.dark) {
                          context.read<AppThemeCubit>().changeToLightTheme();
                        } else {
                          context.read<AppThemeCubit>().changeToDarkTheme();
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
