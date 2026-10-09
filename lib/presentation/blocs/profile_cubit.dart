
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:connectme_app/data/datasources/profile_image_data_source.dart';
import 'package:connectme_app/services/auth_service.dart';
import 'package:connectme_app/services/firestore_service.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthService _authService;
  final FirestoreService _firestoreService;
  final ProfileImageDataSource _imageDataSource;

  ProfileCubit(
    this._authService,
    this._firestoreService,
    this._imageDataSource,
  ) : super(const ProfileState());

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

      final savedImagePath =
          await _imageDataSource.getSavedImagePath(user.uid);

      emit(ProfileState(
        status: ProfileStatus.success,
        fullName: (data?['fullName'] as String?) ??
            user.displayName ??
            '',
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

  Future<void> changeProfileImage() async {
    final user = _authService.currentUser;

    if (user == null) return;

    try {
      final imagePath =
          await _imageDataSource.pickAndSaveImage(user.uid);

      // If the user cancels image selection, keep the current image.
      if (imagePath == null) return;

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