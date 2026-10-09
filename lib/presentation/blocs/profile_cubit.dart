import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:connectme_app/data/datasources/profile_image_data_source.dart';
import 'package:connectme_app/services/auth_service.dart';
import 'package:connectme_app/services/firestore_service.dart';

import 'profile_state.dart';

// Cubit for managing profile state
// Handles loading profile data and updating profile pictures
class ProfileCubit extends Cubit<ProfileState> {
  final AuthService _authService;
  final FirestoreService _firestoreService;
  final ProfileImageDataSource _imageDataSource;

  ProfileCubit(
    this._authService,
    this._firestoreService,
    this._imageDataSource,
  ) : super(const ProfileState());

  // Loads user profile from Firestore and local image storage
  // Combines user data from Firestore with profile image from local storage
  Future<void> loadProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final user = _authService.currentUser;

      if (user == null) {
        emit(state.copyWith(
          status: ProfileStatus.error,
          errorMessage: 'No signed-in user found.',
        ));
        return;
      }

      final document = await _firestoreService.firestore
          .collection('users')
          .doc(user.uid)
          .get();

      final data = document.data();

      final savedImagePath = await _imageDataSource.getSavedImagePath(user.uid);

      emit(ProfileState(
        status: ProfileStatus.success,
        fullName: (data?['fullName'] as String?) ?? user.displayName ?? '',
        email: (data?['email'] as String?) ?? user.email ?? '',
        photoPath: savedImagePath,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: 'Failed to load profile. Please try again.',
      ));
    }
  }

  // Changes the user's profile picture by picking from device gallery
  // Saves the image locally and updates the state to trigger UI refresh
  // Cancelling the picker leaves the existing image unchanged
  Future<void> changeProfileImage() async {
    final user = _authService.currentUser;

    if (user == null) return;

    try {
      // Emit loading state to show UI feedback
      emit(state.copyWith(status: ProfileStatus.loading));

      final imagePath = await _imageDataSource.pickAndSaveImage(user.uid);

      // If the user cancels image selection, restore the previous state
      if (imagePath == null) {
        emit(state.copyWith(status: ProfileStatus.success));
        return;
      }

      // Emit new state with updated image path to trigger UI rebuild
      emit(state.copyWith(
        status: ProfileStatus.success,
        photoPath: imagePath,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: 'Failed to save the selected image.',
      ));
    }
  }
}
