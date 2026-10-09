import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectme_app/domain/entities/user.dart';

// Data model for User
// Handles Firestore serialization/deserialization
// Converts between Firestore data and domain User entity
class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.createdAt,
  });

  // Factory constructor to create UserModel from Firestore data
  factory UserModel.fromJson(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      fullName: data['fullName'] as String? ?? '',
      email: data['email'] as String? ?? '',
      createdAt: data['createdAt'] is Timestamp
          ? (data['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  // Converts UserModel to Firestore-compatible JSON
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // Converts UserModel to domain User entity
  User toEntity() {
    return User(
      uid: uid,
      fullName: fullName,
      email: email,
      createdAt: createdAt,
    );
  }

  // Converts domain User entity to UserModel
  factory UserModel.fromEntity(User user) {
    return UserModel(
      uid: user.uid,
      fullName: user.fullName,
      email: user.email,
      createdAt: user.createdAt,
    );
  }
}
