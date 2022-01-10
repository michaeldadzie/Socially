part of 'liked_post_cubit.dart';

class LikedPostState extends Equatable {
  final Set<String> likedPostIds;
  final Set<String> recentlyLikedPostIds;
  const LikedPostState({
    required this.likedPostIds,
    required this.recentlyLikedPostIds,
  });

  factory LikedPostState.initial() {
    return const LikedPostState(
      likedPostIds: {},
      recentlyLikedPostIds: {},
    );
  }

  @override
  List<Object> get props => [likedPostIds, recentlyLikedPostIds];

  LikedPostState copyWith({
    Set<String>? likedPostIds,
    Set<String>? recentlyLikedPostIds,
  }) {
    return LikedPostState(
      likedPostIds: likedPostIds ?? this.likedPostIds,
      recentlyLikedPostIds: recentlyLikedPostIds ?? this.recentlyLikedPostIds,
    );
  }
}
