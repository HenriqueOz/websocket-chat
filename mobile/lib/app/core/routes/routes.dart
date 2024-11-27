import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:websocket_flutter/app/data/models/server_address_model.dart';
import 'package:websocket_flutter/app/data/models/user_model.dart';
import 'package:websocket_flutter/app/data/websocket/websocket_client.dart';
import 'package:websocket_flutter/app/modules/chat/bloc/chat_connection/chat_connection_bloc.dart';
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
        final Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
        final ServerAddressModel serverAddressModel = arguments['server'] as ServerAddressModel;
        final UserModel userModel = arguments['user'] as UserModel;

        return MaterialPageRoute(
          builder: (context) => MultiProvider(
            providers: [
              Provider(
                create: (context) => WebsocketClient(
                  host: serverAddressModel.ipv4,
                  port: serverAddressModel.port,
                ),
              ),
              BlocProvider(
                create: (context) => ChatConnectionBloc(
                  websocket: context.read<WebsocketClient>(),
                  userModel: userModel,
                ),
              ),
            ],
            child: ChatPage(
              user: userModel,
            ),
          ),
        );
      default:
        return MaterialPageRoute(builder: (context) => const NotFoundPage());
    }
  }
}
