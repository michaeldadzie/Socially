import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socially/features/authentication/data/models/failure_model.dart';
import 'package:socially/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:socially/features/create/data/models/post_model.dart';
import 'package:socially/features/create/data/repositories/post_repository.dart';
import 'package:socially/features/profile/data/models/user_model.dart';
import 'package:socially/features/profile/data/repositories/storage/storage_repository.dart';

part 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  final PostRepository _postRepository;
  final StorageRepository _storageRepository;
  final AuthBloc _authBloc;

  CreatePostCubit({
    required PostRepository postRepository,
    required StorageRepository storageRepository,
    required AuthBloc authBloc,
  })  : _postRepository = postRepository,
        _storageRepository = storageRepository,
        _authBloc = authBloc,
        super(CreatePostState.initial());

  void postImageChanged(File file) {
    emit(state.copyWith(postImage: file, status: CreatePostStatus.initial));
  }

  void captionChanged(String caption) {
    emit(state.copyWith(caption: caption, status: CreatePostStatus.initial));
  }

  void submit() async {
    emit(state.copyWith(status: CreatePostStatus.submmiting));
    try {
      final author = User.empty.copyWith(id: _authBloc.state.user!.uid);
      final postImageUrl =
          await _storageRepository.uploadPostImage(image: state.postImage!);

      final post = Post(
        author: author,
        imageUrl: postImageUrl,
        caption: state.caption,
        likes: 0,
        date: DateTime.now(),
      );

      emit(state.copyWith(status: CreatePostStatus.succes));
      await _postRepository.createPost(post: post);
    } catch (err) {
      emit(
        state.copyWith(
          status: CreatePostStatus.error,
          failure: const Failure(message: 'We were unable to share your post'),
        ),
      );
    }
  }

  void reset() {
    emit(CreatePostState.initial());
  }
}
