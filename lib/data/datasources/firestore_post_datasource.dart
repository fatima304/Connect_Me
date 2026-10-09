import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectme_app/data/models/post_model.dart';
import 'package:connectme_app/services/firestore_service.dart';

// Remote datasource for posts from Firestore
// This handles the actual Firestore operations for posts
class FirestorePostDataSource {
  FirestorePostDataSource(this._firestoreService);

  final FirestoreService _firestoreService;

  // Returns a stream of posts from Firestore for real-time updates
  // Ordered by createdAt in descending order (newest first)
  Stream<List<PostModel>> getPosts() {
    return _firestoreService.postsCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => PostModel.fromJson(
                  doc.data() as Map<String, dynamic>,
                  doc.id,
                ),
              )
              .toList(),
        );
  }

  // Creates a new post in Firestore

  Future<void> createPost({
    required String authorId,
    required String authorName,
    required String content,
  }) async {
    await _firestoreService.postsCollection.add({
      'authorId': authorId,
      'authorName': authorName,
      'content': content,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
