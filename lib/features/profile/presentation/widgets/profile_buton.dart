import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socially/features/profile/presentation/pages/edit_profile_screen.dart';

class ProfileButton extends StatelessWidget {
  final bool? isCurrentUser;
  final bool? isFollowing;
  const ProfileButton({
    Key? key,
    this.isCurrentUser,
    this.isFollowing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCurrentUser!
        ? Container(
            width: MediaQuery.of(context).size.width,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.only(
                  // left: 30,
                  // right: 30,
                  top: 12,
                  bottom: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Theme.of(context).primaryColor,
                side: BorderSide(
                  width: 1,
                  color: Colors.grey.shade300,
                ),
              ),
              onPressed: () => Navigator.of(context).pushNamed(
                EditProfileScreen.routeName,
                arguments: EditProfileScreenArgs(context: context),
              ),
              child: Text(
                'Edit Profile',
                style: GoogleFonts.lato(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).focusColor,
                ),
              ),
            ),
          )
        : Container(
            width: MediaQuery.of(context).size.width,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.only(
                  // left: 30,
                  // right: 30,
                  top: 12,
                  bottom: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: isFollowing!
                    ? Theme.of(context).primaryColor
                    : const Color.fromRGBO(41, 170, 225, 1),
                side: BorderSide(
                  width: 1,
                  color: Colors.grey.shade300,
                ),
              ),
              onPressed: () {},
              child: Text(
                isFollowing! ? 'Unfollow' : 'Follow',
                style: GoogleFonts.lato(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          );
  }
}
