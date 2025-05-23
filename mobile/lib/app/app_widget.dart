import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_flutter/app/core/bloc/app_theme_cubit/app_theme_cubit.dart';
import 'package:websocket_flutter/app/core/strings/strings.dart';
import 'package:websocket_flutter/app/core/theme/app_theme.dart';
import 'package:websocket_flutter/app/core/routes/routes.dart';
import 'package:websocket_flutter/app/core/widgets/theme_selector.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        context.read<Strings>().loadFromFile(fileName: 'en_US');
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<AppThemeCubit>().loadTheme(
          brightness: MediaQuery.of(context).platformBrightness,
        );

    return ThemeSelector(
      builder: (context, themeMode) {
        return MaterialApp(
          themeMode: themeMode,
          theme: AppTheme(LightColors.colors).themeData,
          darkTheme: AppTheme(DarkColors.colors).themeData,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          onGenerateRoute: Routes.generateRoutes,
        );
      },
    );
  }
}
