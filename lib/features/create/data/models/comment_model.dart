import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:socially/core/config/paths.dart';

import 'package:socially/features/profile/data/models/user_model.dart';

class Comment extends Equatable {
  final String? id;
  final String postId;
  final User author;
  final String content;
  final DateTime? date;
  const Comment({
    this.id,
    required this.postId,
    required this.author,
    required this.content,
    required this.date,
  });

  static const empty = Comment(
    id: '',
    postId: '',
    author: User.empty,
    content: '',
    date: null,
  );

  @override
  List<Object?> get props => [
        id,
        postId,
        author,
        content,
        date,
      ];

  Comment copyWith({
    String? id,
    String? postId,
    User? author,
    String? content,
    DateTime? date,
  }) {
    return Comment(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      author: author ?? this.author,
      content: content ?? this.content,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'postId': postId,
      'author':
          FirebaseFirestore.instance.collection(Paths.users).doc(author.id),
      'content': content,
      'date': Timestamp.fromDate(date!),
    };
  }

  // static Future<Comment?> fromDocument(DocumentSnapshot? doc) async {
  //   if (doc == null) return null;
  //   // final data = doc.data();
  //   final authorRef = doc.get('author') as DocumentReference?;
  //   if (authorRef != null) {
  //     final authorDoc =
  //         await authorRef.get() as DocumentSnapshot<Map<String, dynamic>>;
  //     if (authorDoc.exists) {
  //       return Comment(
  //         id: doc.id,
  //         postId: doc.get('postId') ?? '',
  //         author: User.fromDocument(authorDoc),
  //         content: doc.get('content') ?? '',
  //         date: (doc.get('date') as Timestamp).toDate(),
  //       );
  //     }
  //     return null;
  //   }
  // }

  static Future<Comment> fromDocument(
      DocumentSnapshot<Map<String, dynamic>> doc) async {
    final authorRef = doc.get('author') as DocumentReference?;
    if (authorRef != null) {
      final authorDoc =
          await authorRef.get() as DocumentSnapshot<Map<String, dynamic>>;
      if (authorDoc.exists) {
        if (doc.data() != null) {
          Map<String, dynamic>? data = doc.data()!;
          return Comment(
            id: doc.id,
            postId: data['postId'] ?? '',
            author: User.fromDocument(authorDoc),
            content: data['content'] ?? '',
            date: (data['date'] as Timestamp).toDate(),
          );
        }
      }
    }
    return Comment.empty;
  }
}
