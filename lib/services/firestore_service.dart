import 'package:cloud_firestore/cloud_firestore.dart';

// Singleton Pattern: FirestoreService
// Only one instance of FirestoreService exists throughout the app lifecycle
// This ensures consistent Firestore access and manages the singleton instance explicitly
// (not just through GetIt dependency injection)
class FirestoreService {
  // Private constructor to prevent external instantiation
  FirestoreService._internal();

  // The single instance of FirestoreService
  static final FirestoreService _instance = FirestoreService._internal();

  // Factory constructor that returns the single instance
  factory FirestoreService() => _instance;

  // The Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Getter for the Firestore instance
  FirebaseFirestore get firestore => _firestore;

  // Get a reference to the posts collection
  CollectionReference get postsCollection => _firestore.collection('posts');
}
