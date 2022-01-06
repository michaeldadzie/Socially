import 'package:socially/features/create/data/models/comment_model.dart';
import 'package:socially/features/create/data/models/post_model.dart';

abstract class BasePostRepository {
  Future<void> createPost({required Post post});
  Future<void> createComment({required Comment comment});
  void createLike({required Post post, required String userId});
  Stream<List<Future<Post>>> getUserPosts({required String userId});
  Stream<List<Future<Comment>>> getPostComments({required String postId});
  Future<List<Post>> getUserFeed(
      {required String userId, required String lastPostId});
  Future<Set<String>> getLikedPostIds({required String userId, required List<Post> posts});
  void deleteLike({required String postId, required String userId});
}
