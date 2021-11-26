import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:socially/core/widgets/error_dialog.dart';
import 'package:socially/features/authentication/presentation/utils/const.dart';
import 'package:socially/features/profile/data/models/user_model.dart';
import 'package:socially/features/profile/data/repositories/storage/storage_repository.dart';
import 'package:socially/features/profile/data/repositories/user/user_repository.dart';
import 'package:socially/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:socially/features/profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:socially/features/profile/presentation/helpers/image_helper.dart';
import 'package:socially/features/profile/presentation/widgets/profile_image.dart';

class EditProfileScreenArgs {
  final BuildContext context;

  const EditProfileScreenArgs({
    required this.context,
  });
}

class EditProfileScreen extends StatelessWidget {
  static const String routeName = '/edit';
  EditProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  static Route route({required EditProfileScreenArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<EditProfileCubit>(
        create: (_) => EditProfileCubit(
          userRepository: context.read<UserRepository>(),
          storageRepository: context.read<StorageRepository>(),
          profileBloc: args.context.read<ProfileBloc>(),
        ),
        child: EditProfileScreen(
          user: args.context.read<ProfileBloc>().state.user,
        ),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state.status == EditProfileStatus.succes) {
          Navigator.of(context).pop();
        } else if (state.status == EditProfileStatus.error) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              content: state.failure.message,
            ),
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Edit Profile',
                style: GoogleFonts.raleway(
                  color: Theme.of(context).focusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                state.status == EditProfileStatus.submmiting
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: SizedBox(
                            width: 13,
                            height: 13,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Theme.of(context).focusColor,
                            ),
                          ),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          _submitForm(
                            context,
                            state.status == EditProfileStatus.submmiting,
                          );
                          print('submit');
                        },
                        child: Text(
                          'Done',
                          style: GoogleFonts.raleway(
                            color: Theme.of(context).focusColor,
                          ),
                        ),
                      ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => _selectProfileImage(context),
                    child: UserProfileImage(
                      radius: 65,
                      profileImageUrl: user.profileImageUrl,
                      profileImage: state.profileImage,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            initialValue: user.name,
                            // controller: _username,
                            keyboardType: TextInputType.name,
                            // onFieldSubmitted: (_) => node.unfocus(),
                            decoration: textFormFieldDecoration.copyWith(
                              hintText: 'Name',
                              fillColor: Theme.of(context).hintColor,
                            ),
                            style: GoogleFonts.lato(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).focusColor,
                            ),
                            onChanged: (value) => context
                                .read<EditProfileCubit>()
                                .nameChanged(value),
                            validator: (String? v) => v!.trim().isEmpty
                                ? 'Name cannot be empty'
                                : null,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            initialValue: user.username,
                            // controller: _username,
                            keyboardType: TextInputType.name,
                            // onFieldSubmitted: (_) => node.unfocus(),
                            decoration: textFormFieldDecoration.copyWith(
                              hintText: 'Username',
                              fillColor: Theme.of(context).hintColor,
                            ),
                            style: GoogleFonts.lato(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).focusColor,
                            ),
                            onChanged: (value) => context
                                .read<EditProfileCubit>()
                                .usernameChanged(value),
                            validator: (String? v) => v!.trim().isEmpty
                                ? 'Username cannot be empty'
                                : null,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            initialValue: user.bio,
                            // controller: _username,
                            keyboardType: TextInputType.text,
                            // onFieldSubmitted: (_) => node.unfocus(),
                            decoration: textFormFieldDecoration.copyWith(
                              hintText: 'Bio',
                              fillColor: Theme.of(context).hintColor,
                            ),
                            style: GoogleFonts.lato(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).focusColor,
                            ),
                            onChanged: (value) => context
                                .read<EditProfileCubit>()
                                .bioChanged(value),
                            validator: (String? v) => v!.trim().isEmpty
                                ? 'Bio cannot be empty'
                                : null,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _selectProfileImage(BuildContext context) async {
    final pickedFile = await ImageHelper.pickedImageFromGallery(
      context: context,
      cropStyle: CropStyle.circle,
      title: 'Profile Image',
    );

    if (pickedFile != null) {
      context.read<EditProfileCubit>().profileImageChanged(pickedFile);
    }
  }

  void _submitForm(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState!.validate() && !isSubmitting) {
      context.read<EditProfileCubit>().submit();
      print('submit');
    }
  }
}
