import 'package:connectme_app/data/models/user_model.dart';
import 'package:connectme_app/services/firestore_service.dart';

// Remote datasource for user profiles from Firestore
// This handles the actual Firestore operations for user profiles
class FirestoreUserDataSource {
  FirestoreUserDataSource(this._firestoreService);

  final FirestoreService _firestoreService;

  // Creates or updates a user profile in Firestore
  Future<void> createUserProfile(UserModel user) async {
    await _firestoreService.firestore
        .collection('users')
        .doc(user.uid)
        .set(user.toJson());
  }

  // Fetches a user profile by UID
  Future<UserModel?> getUserProfile(String uid) async {
    final docSnapshot =
        await _firestoreService.firestore.collection('users').doc(uid).get();

    if (docSnapshot.exists) {
      return UserModel.fromJson(
        docSnapshot.data() as Map<String, dynamic>,
        docSnapshot.id,
      );
    }
    return null;
  }
}
