import 'package:socially/features/create/data/models/comment_model.dart';
import 'package:socially/features/create/data/models/post_model.dart';

abstract class BasePostRepository {
  Future<void> createPost({required Post post});
  Future<void> createComment({required Comment comment});
  Stream<List<Future<Post>>> getUserPosts({required String userId});
  Stream<List<Future<Comment>>> getPostComments({required String postId});
}
