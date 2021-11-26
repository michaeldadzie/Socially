import 'package:flutter/material.dart';
import 'package:socially/features/profile/presentation/widgets/profile_buton.dart';
import 'package:socially/features/profile/presentation/widgets/stats.dart';

class ProfileStats extends StatelessWidget {
  final bool isCurrentUser;
  final bool isFollowing;
  final int posts;
  final int followers;
  final int following;
  const ProfileStats({
    Key? key,
    required this.isCurrentUser,
    required this.isFollowing,
    required this.posts,
    required this.followers,
    required this.following,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stats(count: posts, label: 'posts'),
                Stats(count: followers, label: 'followers'),
                Stats(count: following, label: 'following'),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ProfileButton(
                isCurrentUser: isCurrentUser,
                isFollowing: isFollowing,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
