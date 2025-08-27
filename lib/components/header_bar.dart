import 'package:flutter/material.dart';
import 'package:tele_crm/components/notification_bell.dart';

class HeaderBar extends StatelessWidget {
  const HeaderBar({super.key});

  // Internal defaults (change here if needed)
  static const _imageUrl =
      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&q=80';
  static const _avatarSize = 40.0;
  static const _avatarRadius = 10.0;
  static const _padding = EdgeInsets.fromLTRB(0, 0, 16, 8);
  static const _bellBg = Colors.grey;
  static const _bellFg = Colors.black87;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: _padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: rounded-rect avatar
          _RoundedAvatar(),

          // Right: notification bell
          _Bell(),
        ],
      ),
    );
  }
}

class _RoundedAvatar extends StatelessWidget {
  const _RoundedAvatar();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(HeaderBar._avatarRadius),
      child: Image.network(
        HeaderBar._imageUrl,
        width: HeaderBar._avatarSize,
        height: HeaderBar._avatarSize,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _Bell extends StatelessWidget {
  const _Bell();

  @override
  Widget build(BuildContext context) {
    return const NotificationBell(
      onPressed: null, // no-op by default
      showBadge: true,
      backgroundColor: HeaderBar._bellBg,
      foregroundColor: HeaderBar._bellFg,
      size: 22,
    );
  }
}
