import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socially/features/authentication/data/models/failure_model.dart';
import 'package:socially/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:socially/features/create/data/models/post_model.dart';
import 'package:socially/features/create/data/repositories/post_repository.dart';
import 'package:socially/features/profile/data/models/user_model.dart';
import 'package:socially/features/profile/data/repositories/user/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;
  final PostRepository _postRepository;
  final AuthBloc _authBloc;

  StreamSubscription<List<Future<Post>>>? _postsSubscription;

  ProfileBloc({
    required UserRepository userRepository,
    required AuthBloc authBloc,
    required PostRepository postRepository,
  })  : _userRepository = userRepository,
        _authBloc = authBloc,
        _postRepository = postRepository,
        super(ProfileState.initial());

  @override
  Future<void> close() {
    _postsSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileLoadUser) {
      yield* _mapProfileLoadUserToState(event);
    } else if (event is ProfileToggleGridView) {
      yield* _mapProfileToggleGridViewToState(event);
    } else if (event is ProfileUpdatePosts) {
      yield* _mapProfileUpdatePosts(event);
    } else if (event is ProfileFollowUser) {
      yield* _mapProfileFollowUserToSate();
    } else if (event is ProfileUnfollowUser) {
      yield* _mapProfileUnfollowUserToSate();
    }
  }

  Stream<ProfileState> _mapProfileLoadUserToState(
    ProfileLoadUser event,
  ) async* {
    yield state.copyWith(status: ProfileStatus.loading);
    try {
      final user = await _userRepository.getUserWithId(userId: event.userId);
      final isCurrentUser = _authBloc.state.user?.uid == event.userId;

      final isFollowing = await _userRepository.isFollowing(
        userId: _authBloc.state.user!.uid,
        otherUserId: event.userId,
      );

      _postsSubscription?.cancel();
      _postsSubscription = _postRepository
          .getUserPosts(userId: event.userId)
          .listen((posts) async {
        final allPosts = await Future.wait(posts);
        add(ProfileUpdatePosts(posts: allPosts));
      });

      yield state.copyWith(
        user: user,
        isCurrentUser: isCurrentUser,
        isFollowing: isFollowing,
        status: ProfileStatus.loaded,
      );
    } catch (err) {
      yield state.copyWith(
        status: ProfileStatus.error,
        failure: const Failure(message: 'We were unable to load this profile'),
      );
    }
  }

  Stream<ProfileState> _mapProfileToggleGridViewToState(
    ProfileToggleGridView event,
  ) async* {
    yield state.copyWith(isGridView: event.isGridView);
  }

  Stream<ProfileState> _mapProfileUpdatePosts(ProfileUpdatePosts event) async* {
    yield state.copyWith(posts: event.posts);
  }

  Stream<ProfileState> _mapProfileFollowUserToSate() async* {
    try {
      _userRepository.followUser(
        userId: _authBloc.state.user!.uid,
        followUserId: state.user.id,
      );
      final updatedUser =
          state.user.copyWith(followers: state.user.followers + 1);
      yield state.copyWith(user: updatedUser, isFollowing: true);
    } catch (err) {
      yield state.copyWith(
        status: ProfileStatus.error,
        failure: const Failure(
          message: 'Something went wrong! Please try again',
        ),
      );
    }
  }

  Stream<ProfileState> _mapProfileUnfollowUserToSate() async* {
    try {
      _userRepository.unfollowUser(
        userId: _authBloc.state.user!.uid,
        unfollowUserId: state.user.id,
      );
      final updatedUser =
          state.user.copyWith(followers: state.user.followers - 1);
      yield state.copyWith(user: updatedUser, isFollowing: false);
    } catch (err) {
      yield state.copyWith(
        status: ProfileStatus.error,
        failure: const Failure(
          message: 'Something went wrong! Please try again',
        ),
      );
    }
  }
}
