import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserProfileImage extends StatelessWidget {
  final double radius;
  final String profileImageUrl;
  final File? profileImage;
  const UserProfileImage({
    Key? key,
    required this.radius,
    required this.profileImageUrl,
    this.profileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).shadowColor,
      backgroundImage: profileImage != null
          ? FileImage(profileImage!)
          : profileImageUrl.isNotEmpty
              ? CachedNetworkImageProvider(profileImageUrl) as ImageProvider
              : null,
      child: _noprofile(),
    );
  }

  Icon _noprofile() {
    if (profileImage == null && profileImageUrl.isEmpty) {
      return Icon(
        Icons.account_circle,
        color: Colors.white,
        size: radius * 2,
      );
    }
    return const Icon(null);
  }
}
