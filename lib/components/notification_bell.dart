import 'package:flutter/material.dart';

class NotificationBell extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool showBadge;
  final Color? badgeColor;
  final double size;          // icon size
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final OutlinedBorder? shape;

  const NotificationBell({
    super.key,
    this.onPressed,
    this.showBadge = true,
    this.badgeColor,
    this.size = 24,
    this.padding = const EdgeInsets.all(10),
    this.backgroundColor,
    this.foregroundColor,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? Colors.grey.shade300;
    final fg = foregroundColor ?? Colors.black87;

    return IconButton.filled(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        padding: padding,
        shape: (shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )),
      ),
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(Icons.notifications_none_rounded, size: size),
          if (showBadge)
            Positioned(
              right: -1,
              top: -1,
              child: Container(
                width: size * 0.42,   // scales with icon size (default ~10)
                height: size * 0.42,
                decoration: BoxDecoration(
                  color: badgeColor ?? Colors.pinkAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
