import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:socially/core/widgets/error_dialog.dart';
import 'package:socially/features/authentication/presentation/utils/const.dart';
import 'package:socially/features/create/presentation/cubit/create_post_cubit.dart';
import 'package:socially/features/profile/presentation/helpers/image_helper.dart';

class CreateScreen extends StatelessWidget {
  static const String routeName = '/create';
  CreateScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreatePostCubit, CreatePostState>(
      listener: (context, state) {
        if (state.status == CreatePostStatus.succes) {
          _formKey.currentState!.reset();
          context.read<CreatePostCubit>().reset();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 1),
              content: Text('Post shared', style: GoogleFonts.raleway()),
            ),
          );
        } else if (state.status == CreatePostStatus.error) {
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
              centerTitle: true,
              title: Text(
                'New Post',
                style: GoogleFonts.raleway(
                  color: Theme.of(context).focusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                state.status == CreatePostStatus.submmiting
                    ? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: SizedBox(
                            width: 13,
                            height: 13,
                            child: CircularProgressIndicator(
                              color: Color.fromRGBO(41, 170, 225, 1),
                            ),
                          ),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          _submitForm(
                            context,
                            state.postImage,
                            state.status == CreatePostStatus.submmiting,
                          );
                          print('submit');
                        },
                        child: Text(
                          'Share',
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
                  GestureDetector(
                    onTap: () => _selectPostImage(context),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: double.infinity,
                      color: Theme.of(context).indicatorColor,
                      child: state.postImage != null
                          ? Image.file(
                              state.postImage!,
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Icons.image,
                              color: Theme.of(context).errorColor,
                              size: 120,
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          // controller: _username,
                          keyboardType: TextInputType.name,
                          // onFieldSubmitted: (_) => node.unfocus(),
                          decoration: textFormFieldDecoration.copyWith(
                            hintText: 'Caption',
                            fillColor: Theme.of(context).hintColor,
                          ),
                          style: GoogleFonts.lato(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).focusColor,
                          ),
                          onChanged: (value) => context
                              .read<CreatePostCubit>()
                              .captionChanged(value),
                          validator: (String? v) => v!.trim().isEmpty
                              ? 'Caption cannot be empty'
                              : null,
                        ),
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

  void _selectPostImage(BuildContext context) async {
    final pickedFile = await ImageHelper.pickedImageFromGallery(
      context: context,
      cropStyle: CropStyle.rectangle,
      title: 'New Post',
    );

    if (pickedFile != null) {
      context.read<CreatePostCubit>().postImageChanged(pickedFile);
    }
  }

  void _submitForm(BuildContext context, File? postImage, bool isSubmitting) {
    if (_formKey.currentState!.validate() &&
        postImage != null &&
        !isSubmitting) {
      context.read<CreatePostCubit>().submit();
    }
  }
}
