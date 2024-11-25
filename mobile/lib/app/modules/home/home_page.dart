import 'package:flutter/material.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';
import 'package:websocket_flutter/app/core/widgets/app_drawer.dart';
import 'package:websocket_flutter/app/modules/home/widgets/custom_app_bar.dart';
import 'package:websocket_flutter/app/modules/home/widgets/home_bottom.dart';
import 'package:websocket_flutter/app/modules/home/widgets/home_server_form.dart';
import 'package:websocket_flutter/app/modules/home/widgets/home_title.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: context.colors.primary,
        appBar: const CustomAppBar(),
        drawer: const AppDrawer(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const HomeTitle(),
                            Divider(
                              color: context.colors.onPrimary,
                              indent: 30,
                              height: 80,
                              endIndent: 30,
                            ),
                            const HomeServerForm(),
                            const Spacer(),
                            const SizedBox(
                              height: 50,
                            ),
                            const Align(
                              alignment: Alignment.bottomCenter,
                              child: HomeBottom(),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
