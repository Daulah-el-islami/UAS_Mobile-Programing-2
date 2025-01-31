import 'package:bank_sat/shared/theme.dart';
import 'package:flutter/material.dart';

class PaginationItem extends StatelessWidget {
  final bool isActive;
  final Color? activeColor, inactiveColor;

  const PaginationItem({
    super.key,
    required this.isActive,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    Color? activeColorAlt = activeColor ?? blueColor;
    Color? inactiveColorAlt = inactiveColor ?? lightBgColor;

    return Container(
      width: 12,
      height: 12,
      margin: const EdgeInsets.only(
        right: 10,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? activeColorAlt : inactiveColorAlt,
      ),
    );
  }
}
