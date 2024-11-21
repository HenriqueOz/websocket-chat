import 'package:flutter/material.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';
import 'package:websocket_flutter/app/core/strings/strings.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            Strings.homeTitle,
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
            Strings.homeSubtitle,
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
