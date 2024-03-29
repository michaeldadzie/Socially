import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socially/features/create/data/models/post_model.dart';
import 'package:socially/features/profile/presentation/extensions/datetime_extension.dart';
import 'package:socially/features/profile/presentation/pages/profile_screen.dart';
import 'package:socially/features/profile/presentation/widgets/profile_image.dart';

class PostView extends StatelessWidget {
  final Post post;
  final bool isLiked;
  final VoidCallback onLike;
  final bool recentlyLiked;
  const PostView({
    Key? key,
    required this.post,
    required this.isLiked,
    required this.onLike,
    this.recentlyLiked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(
                    ProfileScreen.routeName,
                    arguments: ProfileScreenArgs(userId: post.author.id)),
                child: Row(
                  children: [
                    UserProfileImage(
                      radius: 18,
                      profileImageUrl: post.author.profileImageUrl,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      post.author.username,
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Share.share(post.imageUrl);
                  // TODO: Share and report
                  print('tap');
                },
                child: Icon(
                  Icons.more_horiz,
                  color: Theme.of(context).focusColor,
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onDoubleTap: onLike,
          child: CachedNetworkImage(
            imageUrl: post.imageUrl,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height / 2.25,
            width: double.infinity,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: onLike,
              icon: isLiked
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : Icon(
                      Icons.favorite_outline,
                      color: Theme.of(context).focusColor,
                    ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.comment_outlined,
                color: Theme.of(context).focusColor,
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '${recentlyLiked ? post.likes + 1 : post.likes} likes',
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).focusColor,
                ),
              ),
              const SizedBox(height: 4),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: post.author.username,
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                    const TextSpan(text: ' '),
                    TextSpan(
                      text: post.caption,
                      style: GoogleFonts.lato(
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                post.date!.timeAgo(),
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).focusColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
