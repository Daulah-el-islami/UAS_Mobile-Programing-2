import 'package:flutter/material.dart';

class AppBarHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? isCenterTitle;
  final double? elevation;
  final IconThemeData? iconTheme;
  final TextStyle? titleStyle;
  final Color? backgroundColor;

  const AppBarHeader({
    super.key,
    required this.title,
    this.isCenterTitle,
    this.elevation,
    this.iconTheme,
    this.titleStyle,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? defTextStyle = titleStyle;
    IconThemeData? defIconTheme = iconTheme;

    return AppBar(
      centerTitle: isCenterTitle,
      elevation: elevation,
      iconTheme: defIconTheme,
      title: Text(title, style: defTextStyle),
      backgroundColor: backgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
