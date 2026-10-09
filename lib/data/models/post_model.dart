import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectme_app/domain/entities/post.dart';

// Data model for Post
// Handles Firestore serialization/deserialization
// Converts between Firestore data and domain Post entity
class PostModel {
  final String id;
  final String authorName;
  final String content;
  final DateTime createdAt;

  PostModel({
    required this.id,
    required this.authorName,
    required this.content,
    required this.createdAt,
  });

  // Factory constructor to create PostModel from Firestore data
  // Handles safe conversion of Firestore Timestamp to DateTime
  factory PostModel.fromJson(Map<String, dynamic> data, String id) {
    // Safely handle createdAt timestamp
    DateTime parsedCreatedAt;
    if (data['createdAt'] is Timestamp) {
      parsedCreatedAt = (data['createdAt'] as Timestamp).toDate();
    } else if (data['createdAt'] is DateTime) {
      parsedCreatedAt = data['createdAt'] as DateTime;
    } else {
      // Fallback to current time if timestamp is invalid
      parsedCreatedAt = DateTime.now();
    }

    return PostModel(
      id: id,
      authorName: data['authorName'] as String? ?? '',
      content: data['content'] as String? ?? '',
      createdAt: parsedCreatedAt,
    );
  }

  // Converts PostModel to Firestore-compatible JSON
  Map<String, dynamic> toJson() {
    return {
      'authorName': authorName,
      'content': content,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // Converts PostModel to domain Post entity
  Post toEntity() {
    return Post(
      id: id,
      authorName: authorName,
      content: content,
      createdAt: createdAt,
    );
  }

  // Converts domain Post entity to PostModel
  factory PostModel.fromEntity(Post post) {
    return PostModel(
      id: post.id,
      authorName: post.authorName,
      content: post.content,
      createdAt: post.createdAt,
    );
  }
}
