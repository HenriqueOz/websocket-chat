import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_flutter/app/core/bloc/app_theme_cubit/app_theme_cubit.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';
import 'package:websocket_flutter/app/core/widgets/theme_selector.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
      backgroundColor: context.colors.surface,
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  context.strings["home"]?["drawerTitle"] ?? '',
                  style: context.theme.textTheme.headlineLarge?.copyWith(
                    color: context.colors.primary,
                  ),
                ),
              ),
            ),
          ),
          _drawerDivisor(),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                _drawerItem(
                  title: context.strings["home"]?["drawerDarkMode"] ?? '',
                  onTap: () {},
                  leading: ThemeSelector(
                    builder: (context, themeMode) {
                      return Switch(
                        activeColor: context.colors.secondary,
                        thumbColor: WidgetStatePropertyAll(context.colors.onSurface),
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
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: TextButton(
              onPressed: () {
                Scaffold.of(context).closeDrawer();
                Navigator.maybePop(context);
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  context.colors.error.withOpacity(.5),
                ),
                shape: const WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.zero),
                  ),
                ),
              ),
              child: Text(
                context.strings["label"]?["back"] ?? '',
                style: context.theme.textTheme.bodyLarge?.copyWith(
                  color: context.colors.onError,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerDivisor() {
    return Builder(builder: (context) {
      return Divider(
        color: context.colors.onSurface.withOpacity(.5),
      );
    });
  }

  Widget _drawerItem({required String title, Widget? leading, void Function()? onTap}) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRect(
          clipBehavior: Clip.antiAlias,
          child: ListTile(
            title: Text(title),
            leading: leading,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            onTap: onTap,
          ),
        ),
      );
    });
  }
}
