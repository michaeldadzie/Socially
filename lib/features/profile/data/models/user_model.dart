import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String name;
  final String profileImageUrl;
  final int followers;
  final int following;
  final String bio;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.profileImageUrl,
    required this.followers,
    required this.following,
    required this.bio,
  });

  static const empty = User(
    id: '',
    username: '',
    email: '',
    name: '',
    profileImageUrl: '',
    followers: 0,
    following: 0,
    bio: '',
  );

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        profileImageUrl,
        followers,
        following,
        bio,
      ];

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? name,
    String? profileImageUrl,
    int? followers,
    int? following,
    String? bio,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      name: name ?? this.name,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      bio: bio ?? this.bio,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'username': username,
      'email': email,
      'name': name,
      'profileImageUrl': profileImageUrl,
      'followers': followers,
      'following': following,
      'bio': bio,
    };
  }

  // factory User.fromDocument(DocumentSnapshot doc) {
  //   if (doc.data() != null) {
  //     return User.empty;
  //   }
  //   // final data = doc.data();
  //   return User(
  //     id: doc.id,
  //     username: doc['username'] ?? '',
  //     email: doc['email'] ?? '',
  //     profileImageUrl: doc['profileImageUrl'] ?? '',
  //     followers: (doc['followers'] ?? 0).toInt(),
  //     following: (doc['following'] ?? 0).toInt(),
  //     bio: doc['bio'] ?? '',
  //   );
  // }

  factory User.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() != null) {
      Map<String, dynamic>? data = doc.data()!;
      return User(
        id: doc.id,
        username: data['username'] ?? '',
        email: data['email'] ?? '',
        name: data['name'] ?? '',
        profileImageUrl: data['profileImageUrl'] ?? '',
        followers: (data['followers'] ?? 0).toInt(),
        following: (data['following'] ?? 0).toInt(),
        bio: data['bio'] ?? '',
      );
    }
    return User.empty;
  }
}
