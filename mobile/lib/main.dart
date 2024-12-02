import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:websocket_flutter/app/app_widget.dart';
import 'package:websocket_flutter/app/core/bloc/app_theme_cubit/app_theme_cubit.dart';
import 'package:websocket_flutter/app/core/strings/strings.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => Strings.lazySingleton()),
        BlocProvider(create: (_) {
          return AppThemeCubit();
        }),
      ],
      child: const AppWidget(),
    ),
  );
}
