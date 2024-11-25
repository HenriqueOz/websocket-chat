import 'package:flutter/material.dart';
import 'package:websocket_flutter/app/core/extensions/context_ext.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final List<Widget>? actions;
  final double? elevation;

  const CustomAppBar({
    super.key,
    required this.backgroundColor,
    required this.foregroundColor,
    this.actions,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      shadowColor: context.colors.shadow,
      elevation: elevation,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: foregroundColor,
      ),
      iconTheme: IconThemeData(
        color: foregroundColor,
      ),
      actions: actions,
      actionsIconTheme: IconThemeData(
        color: foregroundColor,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
