import 'package:flutter/material.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';
import 'package:websocket_flutter/app/modules/home/widgets/home_app_bar.dart';
import 'package:websocket_flutter/app/modules/home/widgets/home_drawer.dart';
import 'package:websocket_flutter/app/modules/home/widgets/home_server_form.dart';
import 'package:websocket_flutter/app/modules/home/widgets/home_title.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primary,
      appBar: const HomeAppBar(),
      drawer: const HomeDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HomeTitle(),
            Divider(
              color: context.colors.onPrimary,
              indent: 30,
              height: 110,
              endIndent: 30,
            ),
            const HomeServerForm(),
          ],
        ),
      ),
    );
  }
}
