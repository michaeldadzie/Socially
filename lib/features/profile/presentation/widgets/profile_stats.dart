import 'package:flutter/material.dart';
import 'package:socially/features/profile/presentation/widgets/profile_buton.dart';
import 'package:socially/features/profile/presentation/widgets/stats.dart';

class ProfileStats extends StatelessWidget {
  final bool? isCurrentUser;
  final bool? isFollowing;
  final int posts;
  final int followers;
  final int following;
  const ProfileStats({
    Key? key,
    this.isCurrentUser,
    this.isFollowing,
    required this.posts,
    required this.followers,
    required this.following,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stats(count: posts, label: 'posts'),
              Stats(count: followers, label: 'followers'),
              Stats(count: following, label: 'following'),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: ProfileButton(
              isCurrentUser: isCurrentUser,
              isFollowing: isFollowing,
            ),
          ),
        ],
      ),
    );
  }
}
