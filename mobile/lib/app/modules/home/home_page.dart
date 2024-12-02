import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';
import 'package:websocket_flutter/app/core/theme/extensions/button_themes.dart';
import 'package:websocket_flutter/app/core/utils/messenger.dart';
import 'package:websocket_flutter/app/core/widgets/app_drawer.dart';
import 'package:websocket_flutter/app/core/widgets/custom_app_bar.dart';
import 'package:websocket_flutter/app/modules/home/widgets/home_bottom.dart';
import 'package:websocket_flutter/app/modules/home/widgets/home_server_form.dart';
import 'package:websocket_flutter/app/modules/home/widgets/home_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _onPopInvokedWithResult(bool didPop, Object? result) {
    if (didPop) return;

    Messenger.of(context).showCustomDialog(
      title: context.strings["home"]?["exitModalTitle"] ?? '',
      description: context.strings["home"]?["exitModalDescription"] ?? '',
      actions: [
        ElevatedButton(
          style: context.theme.extension<ButtonThemes>()?.errorButton,
          onPressed: () {
            SystemNavigator.pop();
          },
          child: Text(context.strings["label"]?["exit"] ?? ''),
        ),
        ElevatedButton(
          style: context.theme.extension<ButtonThemes>()?.primaryButton,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(context.strings["label"]?["cancel"] ?? ''),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: _onPopInvokedWithResult,
        child: Scaffold(
          backgroundColor: context.colors.primary,
          appBar: CustomAppBar(
            backgroundColor: context.colors.primary,
            foregroundColor: context.colors.onPrimary,
            elevation: 0,
          ),
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
      ),
    );
  }
}
