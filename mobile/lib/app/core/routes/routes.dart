import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:websocket_flutter/app/modules/chat/chat_page.dart';
import 'package:websocket_flutter/app/modules/home/bloc/home_form_bloc.dart';
import 'package:websocket_flutter/app/modules/home/home_page.dart';
import 'package:websocket_flutter/app/modules/not_found/not_found_page.dart';

part 'route_names.dart';

final class Routes {
  Routes._();

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case (RouteNames.homePage):
        return MaterialPageRoute(
          builder: (context) => MultiProvider(
            providers: [
              BlocProvider(create: (context) => HomeFormBloc()),
            ],
            builder: (context, child) => const HomePage(),
          ),
        );
      case (RouteNames.chatPage):
        return MaterialPageRoute(builder: (context) => const ChatPage());
      default:
        return MaterialPageRoute(builder: (context) => const NotFoundPage());
    }
  }
}
