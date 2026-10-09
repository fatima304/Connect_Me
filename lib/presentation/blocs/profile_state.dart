
enum ProfileStatus { initial, loading, success, error }

class ProfileState {
  final ProfileStatus status;
  final String fullName;
  final String email;
  final String? photoPath;
  final String? errorMessage;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.fullName = '',
    this.email = '',
    this.photoPath,
    this.errorMessage,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    String? fullName,
    String? email,
    String? photoPath,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      photoPath: photoPath ?? this.photoPath,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}