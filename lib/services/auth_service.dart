import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Singleton Pattern: FirebaseAuth.instance is a singleton provided by Firebase
// This service wraps Firebase Auth operations and is registered as a singleton in GetIt
class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signUp({
    required String email,
    required String password,
    String? fullName,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Set the display name if provided
    if (fullName != null && fullName.isNotEmpty) {
      await userCredential.user?.updateDisplayName(fullName);
    }

    // Save user profile to Firestore
    if (userCredential.user != null) {
      await _saveUserProfile(userCredential.user!.uid, fullName ?? '', email);
    }

    return userCredential;
  }

  // Helper method to save user profile to Firestore
  Future<void> _saveUserProfile(
    String uid,
    String fullName,
    String email,
  ) async {
    final userDoc = _firestore.collection('users').doc(uid);

    // Only create if it doesn't exist (to avoid overwriting existing data)
    final docSnapshot = await userDoc.get();
    if (!docSnapshot.exists) {
      await userDoc.set({
        'fullName': fullName,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  User? get currentUser => _firebaseAuth.currentUser;
}
