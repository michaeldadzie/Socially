import 'package:socially/features/profile/data/models/user_model.dart';

abstract class BaseUserRepository {
  Future<User> getUserWithId({required String userId});
  Future<void> updateUser({required User user});
  Future<List<User>> searchUsers({required String query});
  void followUser({required String userId, required String followUserId});
  void unfollowUser({required String userId, required String unfollowUserId});
  Future<bool> isFollowing(
      {required String userId, required String otherUserId});
}
