import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectme_app/domain/entities/post.dart';

class PostModel {
  final String id;
  final String authorId;
  final String authorName;
  final String content;
  final DateTime createdAt;

  PostModel({
    required this.id,
    this.authorId = '',
    required this.authorName,
    required this.content,
    required this.createdAt,
  });

  factory PostModel.fromJson(
    Map<String, dynamic> data,
    String id,
  ) {
    final createdAt = data['createdAt'];

    DateTime parsedCreatedAt;

    if (createdAt is Timestamp) {
      parsedCreatedAt = createdAt.toDate();
    } else if (createdAt is DateTime) {
      parsedCreatedAt = createdAt;
    } else {
      parsedCreatedAt = DateTime.now();
    }

    return PostModel(
      id: id,
      authorId: data['authorId'] as String? ?? '',
      authorName: data['authorName'] as String? ?? '',
      content: data['content'] as String? ?? '',
      createdAt: parsedCreatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'authorId': authorId,
      'authorName': authorName,
      'content': content,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  Post toEntity() {
    return Post(
      id: id,
      authorId: authorId,
      authorName: authorName,
      content: content,
      createdAt: createdAt,
    );
  }

  factory PostModel.fromEntity(Post post) {
    return PostModel(
      id: post.id,
      authorId: post.authorId,
      authorName: post.authorName,
      content: post.content,
      createdAt: post.createdAt,
    );
  }
}
