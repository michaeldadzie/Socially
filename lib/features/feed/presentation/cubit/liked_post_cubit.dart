import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socially/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:socially/features/create/data/models/post_model.dart';
import 'package:socially/features/create/data/repositories/post_repository.dart';

part 'liked_post_state.dart';

class LikedPostCubit extends Cubit<LikedPostState> {
  final PostRepository _postRepository;
  final AuthBloc _authBloc;

  LikedPostCubit({
    required PostRepository postRepository,
    required AuthBloc authBloc,
  })  : _postRepository = postRepository,
        _authBloc = authBloc,
        super(LikedPostState.initial());

  void updateLikedPosts({required Set<String> postIds}) {
    state.copyWith(
        likedPostIds: Set<String>.from(state.likedPostIds)..addAll(postIds));
  }

  void likePost({required Post post}) {
    _postRepository.createLike(post: post, userId: _authBloc.state.user!.uid);

    emit(
      state.copyWith(
        likedPostIds: Set<String>.from(state.likedPostIds)..add(post.id!),
        recentlyLikedPostIds: Set<String>.from(state.recentlyLikedPostIds)
          ..add(post.id!),
      ),
    );
  }

  void unlikePost({required Post post}) {
    _postRepository.deleteLike(
        postId: post.id!, userId: _authBloc.state.user!.uid);

    emit(
      state.copyWith(
        likedPostIds: Set<String>.from(state.likedPostIds)..remove(post.id!),
        recentlyLikedPostIds: Set<String>.from(state.recentlyLikedPostIds)
          ..remove(post.id!),
      ),
    );
  }

  void clearAllLikedPosts() {
    emit(LikedPostState.initial());
  }
}
