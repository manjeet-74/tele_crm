import 'package:flutter/material.dart';
import 'package:tele_crm/components/notification_bell.dart';
import 'package:tele_crm/screens/profile_page.dart'; // ensure this exists

class HeaderBar extends StatelessWidget {
  const HeaderBar({super.key});

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
          _RoundedAvatar(), // now tappable
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
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias, // ensure the ripple is clipped
      borderRadius: BorderRadius.circular(HeaderBar._avatarRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(HeaderBar._avatarRadius),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ProfilePageScreen()),
          );
          // If using named routes:
          // Navigator.of(context).pushNamed('/profile');
        },
        child: Ink(
          width: HeaderBar._avatarSize,
          height: HeaderBar._avatarSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(HeaderBar._avatarRadius),
            image: const DecorationImage(
              image: NetworkImage(HeaderBar._imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class _Bell extends StatelessWidget {
  const _Bell();

  @override
  Widget build(BuildContext context) {
    return const NotificationBell(
      onPressed: null,
      showBadge: true,
      backgroundColor: HeaderBar._bellBg,
      foregroundColor: HeaderBar._bellFg,
      size: 22,
    );
  }
}
