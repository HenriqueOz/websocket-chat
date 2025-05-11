import 'package:flutter/material.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            context.strings["home"]?["title"] ?? '',
            textAlign: TextAlign.center,
            style: context.theme.textTheme.headlineMedium?.copyWith(
              color: context.colors.onPrimary,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.center,
          child: Text(
            context.strings["home"]?["subtitle"] ?? '',
            textAlign: TextAlign.center,
            style: context.theme.textTheme.titleSmall?.copyWith(
              color: context.colors.onPrimary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
